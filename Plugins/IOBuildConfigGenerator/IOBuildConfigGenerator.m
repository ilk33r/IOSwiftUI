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
    NSString *_executableDir;
}

NSString *IOBuildConfigGeneratorChecksumFileName = @"Configuration.checksum.sha256";
NSString *IOBuildConfigGeneratorEnvironmentFileName = @"Configuration.env";
NSString * const IOBuildConfigFileItemFormat = @"\t\t\"%@\": \"%@\",\n";
NSString * const IOBuildConfigGeneratorFileName = @"IOBuildConfig";

NSString * const IOBuildConfigGeneratorFile = @"import Foundation\n\n\
@objc(IOBuildConfig)\n\
public class IOBuildConfig: NSObject {\n\
\n\
\t@objc public static var configValues: [String: Any] = [\n\
%@\n\
\t\t]\n\
}\n";

#pragma mark - Initialization Methods

- (instancetype)initWithBuildDir:(NSString *)buildDir
           configurationFilePath:(NSString *)configurationFilePath
                 environmentName:(NSString *)environmentName
             sourceRootDirectory:(NSString *)srcRoot
                   executableDir:(NSString *)executableDir {
    self = [super init];
    if (self) {
        _buildDir = buildDir;
        _configurationFilePath = configurationFilePath;
        _environmentName = environmentName;
        _srcRoot = srcRoot;
        _executableDir = executableDir;
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
    NSString *checksumFilePath = [_executableDir stringByAppendingPathComponent:IOBuildConfigGeneratorChecksumFileName];
    
    // Obtain configuration file checksum
    NSString *configurationFileChecksum = [self checksumForConfigurationFile:configurationFile checksumFilePath:checksumFilePath];
    
    // Obtain configuration file data
    NSDictionary *configurationFileData = [self readConfigurationJsonFileFromPath:configurationFile];
        
    // Check configuration file readed
    if (!configurationFileData) {
        // Log call
        printf("error: Could not read configuration file at: %s\n", [configurationFile UTF8String]);
            
        // Exit failure
        return 1;
    }
        
    // Generate configuration data
    NSDictionary *configurationData = [self setConfigurationDataFromConfiguration:configurationFileData environment:_environmentName];
    int generateConfigStatus = [self generateBuildConfigFilesToPath:_buildDir configuration:configurationData];
    
    // Write checksum to file
    [configurationFileChecksum writeToFile:checksumFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    // Write environment file
    NSString *environmentFilePath = [_executableDir stringByAppendingPathComponent:IOBuildConfigGeneratorEnvironmentFileName];
    if ([NSFileManager.defaultManager fileExistsAtPath:environmentFilePath]) {
        [NSFileManager.defaultManager removeItemAtPath:environmentFilePath error:nil];
    }
    [_environmentName writeToFile:environmentFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
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
        // Remove checksum file
        [fileManager removeItemAtPath:checksumFilePath error:nil];
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
    
    printf("error: Could not found configuration file at\n%s", [path UTF8String]);
    return NO;
}

- (NSString *)escapeSlashesFromValue:(NSString *)value {
    return [value stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
}

- (int)generateBuildConfigFilesToPath:(NSString *)path configuration:(NSDictionary *)configuration {
    // Obtain file manager
    NSFileManager *fileManager = [NSFileManager defaultManager];

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
    
    // Generate swift file
    NSString *swiftFilePath = [[path stringByAppendingPathComponent:IOBuildConfigGeneratorFileName] stringByAppendingString:@".swift"];
    
    // Check m file exists
    if ([fileManager fileExistsAtPath:swiftFilePath]) {
        // Then remove file
        [fileManager removeItemAtPath:swiftFilePath error:nil];
    }
    
    // Generate m file
    NSString *swiftFileData = [NSString stringWithFormat:IOBuildConfigGeneratorFile, contentFileData];
    [swiftFileData writeToFile:swiftFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
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
        printf("error: Could not parse JSON: %s\n%s\n", [error.localizedDescription UTF8String], [error.localizedFailureReason UTF8String]);
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
        printf("error: Could not found 'default' key in configuration file");
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
