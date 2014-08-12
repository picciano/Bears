//
//  AppDelegate.m
//  Bears
//
//  Created by Anthony Picciano on 8/11/14.
//  Copyright (c) 2014 Picciano. All rights reserved.
//

#import "AppDelegate.h"
#import "NSURL+QueryString.h"
#import "MainViewController.h"
#import <Parse/Parse.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [Parse setApplicationId:@"GRUgA9n7ZWptzN3cP6pWJfTVvWFBqjTzS1a2ZQtz"
                  clientKey:@"0sHyGSDMgILzShPpa2xjPmBgLlIXo6oXyMio7XbY"];
    
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
     UIRemoteNotificationTypeAlert|
     UIRemoteNotificationTypeSound];
    
    MainViewController *viewController = [[MainViewController alloc] initWithNibName:nil bundle:nil];
    self.window.rootViewController = viewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"Openned URL: %@", url);
    if ([PFUser currentUser])
    {
        NSString *user = [url queryStringValueForKey:@"user"];
        NSLog(@"Adding friend: %@", user);
        
        PFUser *friend = [PFUser objectWithoutDataWithObjectId:user];
        [[PFUser currentUser] addUniqueObject:friend forKey:@"friends"];
        [[PFUser currentUser] saveInBackground];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"BEARS" message:@"You need to be logged in before accepting an invitation." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        [alertView show];
    }
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    
    // Associate the device with a user
    currentInstallation[@"user"] = [PFUser currentUser];
    
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    if (currentInstallation.badge != 0)
    {
        currentInstallation.badge = 0;
        [currentInstallation saveEventually];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
