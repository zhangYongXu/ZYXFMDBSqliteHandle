//
//  AppDelegate.m
//  YXDatabaseHandlle
//
//  Created by 拓之林 on 16/3/2.
//  Copyright © 2016年 拓之林. All rights reserved.
//

#import "AppDelegate.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configDatabaseHandle];
    return YES;
}
/**
 *  初始化数据库操作
 */
- (void)configDatabaseHandle{
    _dbHandle = [YXDatabaseHandle shareInstance];
    //是否打印执行的sql语句记录
    [YXDatabaseHandle setYXDatabaseHandleIsShowLogs:YES];
    //数据库路径
    NSString * path =[self getDataBaseFilePath];
    NSError * error = nil;
    //打开数据库
    BOOL isSuccess = [_dbHandle openDatabaseWithPath:path Error:&error];
    if(isSuccess){
        //注册要存入数据库的模型(在这个过程里，如果没有模型对应的表就创建表)
        [_dbHandle registerClass:[UserModel class] MappingTypeType:TableFeildMappingTypeClassProperty];
        [_dbHandle registerClass:[CompanyModel class] MappingTypeType:TableFeildMappingTypeClassProperty];
        [_dbHandle registerClass:[EmployeeModel class] MappingTypeType:TableFeildMappingTypeMappingFile];
    }
}

-(NSString*) getDataBaseFilePath
{
    
    NSString * homeDir = NSHomeDirectory();
    NSString * documents = [homeDir stringByAppendingPathComponent:@"Documents"];
    NSString * dirctoryPath = [documents stringByAppendingPathComponent:@"DataBase/DB"];
    
    NSFileManager *FM = [NSFileManager defaultManager];
    BOOL isDir;
    BOOL isExist = [FM fileExistsAtPath:dirctoryPath isDirectory:&isDir];
    if(!isExist){
        NSError * error = nil;
        BOOL isSuccess = [FM createDirectoryAtPath:dirctoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if(!isSuccess){
            NSLog(@"创建数据库文件存放目录失败  defaultDataBaseFilePath error: %@",error);
        }
    }
    
    NSString * dbPath = [dirctoryPath stringByAppendingString:@"db.sqlite"];
    
    return dbPath;
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
