//
//  AppDelegate.m
//  Homepwner
//
//  Created by Rachel Dorn on 5/24/16.
//  Copyright © 2016 Rachel Dorn. All rights reserved.
//

#import "AppDelegate.h"
#import "RMDItemsTableViewController.h"
#import "RMDItemStore.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    RMDItemsTableViewController *itemsVC = [[RMDItemsTableViewController alloc] initWithStyle:UITableViewStylePlain];
   
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsVC];
    [self.window setRootViewController:navController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BOOL success = [[RMDItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all the items");
    } else {
        NSLog(@"Could not save the items");
    }
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
