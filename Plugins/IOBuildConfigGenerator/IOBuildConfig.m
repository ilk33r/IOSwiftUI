//
//  IOBuildConfig.m
//  
//
//  Created by Adnan ilker Ozcan on 22.09.2022.
//

#import <Foundation/Foundation.h>
#import "IOBuildConfigGenerator.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Check argument count
        if (argc != 5) {
            NSLog(@"Invalid arguments\n");
            NSLog(@"{buildDir} {configurationFilePath} {environmentName} {sourceRoot}\n");
            for (NSInteger i = 0; i < argc; i++) {
                NSLog(@"ARG[%d]: %s", argc, argv[i]);
            }
            return 1;
        }
        
        // Convert arguments to nsstring
        NSString *buildDir = [NSString stringWithUTF8String:argv[1]];
        NSString *configurationFilePath = [NSString stringWithUTF8String:argv[2]];
        NSString *environmentName = [NSString stringWithUTF8String:argv[3]];
        NSString *sourceRoot = [NSString stringWithUTF8String:argv[4]];
        
        // Initialize configuration generator
        IOBuildConfigGenerator *configurationGenerator = [[IOBuildConfigGenerator alloc
                                                           ] initWithBuildDir:buildDir configurationFilePath:configurationFilePath environmentName:environmentName
                                                          sourceRootDirectory:sourceRoot];
        
        // Generate configuration
        return [configurationGenerator generateConfiguration];
    }
    return 0;
}
