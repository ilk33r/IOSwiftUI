//
//  IOBuildConfigGenerator.h
//  
//
//  Created by Adnan ilker Ozcan on 22.09.2022.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface IOBuildConfigGenerator : NSObject

#pragma mark - Initialization Methods

- (instancetype)initWithBuildDir:(NSString *)buildDir
           configurationFilePath:(NSString *)configurationFilePath
                 environmentName:(NSString *)environmentName
             sourceRootDirectory:(NSString *)srcRoot
                   executableDir:(NSString *)executableDir;

#pragma mark - Generator Methods

- (int)generateConfiguration;

@end

NS_ASSUME_NONNULL_END
