//
//  IOBuildConfigGenerator.m
//  
//
//  Created by Adnan ilker Ozcan on 22.09.2022.
//

#import <CommonCrypto/CommonDigest.h>
#import "IOBuildConfigGenerator.h"

@implementation IOBuildConfigGenerator {
    NSString *_buildDir;
    NSString *_configurationFilePath;
    NSString *_environmentName;
    NSString *_srcRoot;
}

NSString *IOBuildBuildStatusFileName = @"BUILD_STATUS.iobuildconfig";
NSString *IOBuildConfigGeneratorChecksumFileName = @"Configuration.checksum.sha256";
NSString * const IOBuildConfigFileItemFormat = @"@\"%@\": @\"%@\",";
NSString * const IOBuildConfigGeneratorFileName = @"IOBuildConfig";

NSString * const IOBuildConfigGeneratorHeaderFile = @"#import <Foundation/Foundation.h>\n\
NS_ASSUME_NONNULL_BEGIN\n\
@interface IOBuildConfig : NSObject\n\
\n\
+ (NSString * _Nullable)configForKey:(NSString *)key;\n\
@end\n\
NS_ASSUME_NONNULL_END\n";

NSString * const IOBuildConfigGeneratorMFile = @"#import \"IOBuildConfig.h\"\n\
@implementation IOBuildConfig\n\
+ (NSDictionary *)configValues {\n\
return @{%@};\n\
}\n\
+ (NSString *)configForKey:(NSString *)key {\n\
return [[self configValues] objectForKey:key];\n\
}\n\
@end\n";

#pragma mark - Initialization Methods

- (instancetype)initWithBuildDir:(NSString *)buildDir
           configurationFilePath:(NSString *)configurationFilePath
                 environmentName:(NSString *)environmentName
             sourceRootDirectory:(NSString *)srcRoot {
    self = [super init];
    if (self) {
        _buildDir = buildDir;
        _configurationFilePath = configurationFilePath;
        _environmentName = environmentName;
        _srcRoot = srcRoot;
    }
    return self;
}

#pragma mark - Generator Methods

- (int)generateConfiguration {
    // Check configuration file is not exists
    NSString *configurationFile = [_srcRoot stringByAppendingPathComponent:_configurationFilePath];
    if (![self configurationFileExistsFromPath:configurationFile]) {
        // Then exit failure
        return 1;
    }
    
    // Create checksum file path
    NSString *checksumFilePath = [_buildDir stringByAppendingPathComponent:IOBuildConfigGeneratorChecksumFileName];
    
    // Obtain configuration file checksum
    NSString *configurationFileChecksum = [self checksumForConfigurationFile:configurationFile checksumFilePath:checksumFilePath];
    NSString *buildStatusFile = [_buildDir stringByAppendingPathComponent:IOBuildBuildStatusFileName];
    
    // Check checksum is changed
    if (!configurationFileChecksum) {
        // Write compile status to file
        NSString *buildStatus = @"NO";
        [buildStatus writeToFile:buildStatusFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
        
        // Then exit successfully
        return 0;
    }
    
    // Obtain configuration file data
    NSDictionary *configurationFileData = [self readConfigurationJsonFileFromPath:configurationFile];
        
    // Check configuration file readed
    if (!configurationFileData) {
        // Log call
        NSLog(@"error: Could not read configuration file at: %@\n", configurationFile);
            
        // Exit failure
        return 1;
    }
        
    // Generate configuration data
    NSDictionary *configurationData = [self setConfigurationDataFromConfiguration:configurationFileData environment:_environmentName];
    int generateConfigStatus = [self generateBuildConfigFilesToPath:_buildDir configuration:configurationData];
    
    // Write checksum to file
    [configurationFileChecksum writeToFile:checksumFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // Write compile status to file
    NSString *buildStatus = @"YES";
    [buildStatus writeToFile:buildStatusFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // Then exit successfully
    return generateConfigStatus;
}

#pragma mark - Helper Methods

- (NSString *)checksumForConfigurationFile:(NSString *)path checksumFilePath:(NSString *)checksumFilePath {
    // Obtain file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Read file data
    NSData *fileData = [NSData dataWithContentsOfFile:path];
    
    // Create sha256 data
    unsigned char buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(fileData.bytes, (CC_LONG)fileData.length, buffer);
    
    // Create sha 256 format
    char formatted[CC_SHA256_DIGEST_LENGTH * 2 + 1];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; ++i) {
        sprintf(formatted + i * 2, "%02x", buffer[i]);
    }
    
    // Obtain configuration file checksum
    NSString *configFileChecksum = [[NSString alloc] initWithBytes:formatted
                                                            length:CC_SHA256_DIGEST_LENGTH * 2
                                                          encoding:NSUTF8StringEncoding];
    
    // Check checksum file exists
    if ([fileManager fileExistsAtPath:checksumFilePath]) {
        // Read checksum
        NSString *configurationChecksum = [NSString stringWithContentsOfFile:checksumFilePath encoding:NSUTF8StringEncoding error:nil];
        
        // Check checksum values is not equal
        if ([configurationChecksum isEqualToString:configFileChecksum]) {
            // Then return new checksum
            return nil;
        }
    }
    
    return configFileChecksum;
}

- (BOOL)configurationFileExistsFromPath:(NSString *)path {
    // Obtain file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Check config file exists
    if ([fileManager fileExistsAtPath:path]) {
        return YES;
    }
    
    NSLog(@"error: Could not found configuration file at\n%@", path);
    return NO;
}

- (NSString *)escapeSlashesFromValue:(NSString *)value {
    return [value stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

- (int)generateBuildConfigFilesToPath:(NSString *)path configuration:(NSDictionary *)configuration {
    // Obtain file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Generate header file
    NSString *headerFilePath = [[path stringByAppendingPathComponent:IOBuildConfigGeneratorFileName] stringByAppendingString:@".h"];
    
    // Check header file exists
    if ([fileManager fileExistsAtPath:headerFilePath]) {
        // Then remove file
        [fileManager removeItemAtPath:headerFilePath error:nil];
    }
    
    // Generate header file
    [IOBuildConfigGeneratorHeaderFile writeToFile:headerFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // Content file data
    NSMutableString *contentFileData = [NSMutableString new];
    
    // Loop throught configuration
    for (NSString *configKey in configuration) {
        // Obtain escaped config value
        NSString *configValue = [self escapeSlashesFromValue:[configuration objectForKey:configKey]];
            
        // Create dictionary value
        NSString *value = [NSString stringWithFormat:IOBuildConfigFileItemFormat, configKey, configValue];
        [contentFileData appendString:value];
    }
    
    // Generate m file
    NSString *mFilePath = [[path stringByAppendingPathComponent:IOBuildConfigGeneratorFileName] stringByAppendingString:@".m"];
    
    // Check m file exists
    if ([fileManager fileExistsAtPath:mFilePath]) {
        // Then remove file
        [fileManager removeItemAtPath:mFilePath error:nil];
    }
    
    // Generate m file
    NSString *mFileData = [NSString stringWithFormat:IOBuildConfigGeneratorMFile, contentFileData];
    [mFileData writeToFile:mFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    return 0;
}

- (NSDictionary * _Nullable)readConfigurationJsonFileFromPath:(NSString *)path {
    // Read file
    NSData *configurationFileData = [NSData dataWithContentsOfFile:path];
    
    // Create string
    NSString *configurationFileDataString = [[[NSString alloc
                                               ] initWithData:configurationFileData encoding:NSUTF8StringEncoding
                                              ] stringByReplacingOccurrencesOfString:@"\\\n" withString:@""];
    
    // Create an error
    NSError *error;
    
    // Json decode file
    NSDictionary *jsonDictionar = [NSJSONSerialization JSONObjectWithData:[configurationFileDataString dataUsingEncoding:NSUTF8StringEncoding]
                                                                  options:0
                                                                    error:&error];
    
    // Check error
    if (error) {
        // Log call
        NSLog(@"error: Could not parse JSON: %@\n%@\n", error.localizedDescription, error.localizedFailureReason);
        return nil;
    }
    
    return jsonDictionar;
}

- (NSDictionary *)setConfigurationDataFromConfiguration:(NSDictionary *)configuration environment:(NSString *)environment {
    // Create a mutable dictionary
    NSMutableDictionary *configurationData = [NSMutableDictionary new];
    
    // Copy default values to data
    NSDictionary *defaultValues = [configuration objectForKey:@"default"];
    
    // Check default values is not exists
    if (!defaultValues) {
        // Log call
        NSLog(@"error: Could not found 'default' key in configuration file");
        return nil;
    }
    
    // Loop throught default values
    for (NSString *key in defaultValues) {
        // Update configuration data
        [configurationData setObject:[defaultValues objectForKey:key] forKey:key];
    }
    
    // Obtain environment specific values
    NSDictionary *environmentValues = [configuration objectForKey:environment];
    
    // Check environment values found
    if (environmentValues) {
        // Loop throught environment values
        for (NSString *key in environmentValues) {
            // Update configuration data
            [configurationData setObject:[environmentValues objectForKey:key] forKey:key];
        }
    }
    
    // Obtain build environment variables
    NSDictionary *buildEnv = [[NSProcessInfo processInfo] environment];
    
    // Check environment values found
    for (NSString *key in buildEnv) {
        // Check key exists
        id configValue = [defaultValues objectForKey:key];
        if (configValue) {
            // Update configuration data
            [configurationData setObject:[buildEnv objectForKey:key] forKey:key];
        }
    }

    // Then return configuration data
    return configurationData;
}

@end
