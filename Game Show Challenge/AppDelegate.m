//
//  AppDelegate.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [Parse setApplicationId:@"w5RAxEGiVabFqloDlv1fJZoPmibtu3Eb9MKsyFzh"
                  clientKey:@"4SQ72d8aEWhqCDLOy1xo0o3aPLWmBAhmlNhMLG9l"];
    
    [PFTwitterUtils initializeWithConsumerKey:@"TuvoxiZ0Umh00Xovjq3BjGWyF"
                               consumerSecret:@"1RQ9iYpjZtbQ86E4ZfmL4NdjPNPRnKWVO18p7kG58hx9StDkEx"];
    
    [PFUser enableAutomaticUser];
    [[PFUser currentUser] saveInBackground];
    
    return YES;
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
