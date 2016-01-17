//
//  AppDelegate.m
//  Darumasan
//
//  Created by 小川大暉 on 2014/10/21.
//  Copyright (c) 2014年 DaikiOgawa. All rights reserved.
//

#import "AppDelegate.h"
#import "DataControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [DataControl initializeData];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSNotification* n = [NSNotification notificationWithName:@"applicationDidEnterBackground" object:self];
    // 通知を行う
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    //ローカル通知
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    BOOL tsuchi = [ud boolForKey:@"KEY_Tsuchi"];
    
    if (tsuchi == YES) {
        
        // インスタンス生成
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        // 5分後に通知をする（設定は秒単位）
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:60*30];
        // タイムゾーンの設定
        notification.timeZone = [NSTimeZone defaultTimeZone];
        // 通知時に表示させるメッセージ内容
        notification.alertBody = @"忍力がたまったぞ！お宝を盗みに行こう！";
        // 通知に鳴る音の設定
        notification.soundName = UILocalNotificationDefaultSoundName;
        
        // 通知の登録
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    NSNotification* n = [NSNotification notificationWithName:@"applicationWillEnterForeground" object:self];
    // 通知を行う
    [[NSNotificationCenter defaultCenter] postNotification:n];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    NSLog(@"WillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
