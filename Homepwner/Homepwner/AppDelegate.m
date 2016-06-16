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

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    if (!self.window.rootViewController) {
        RMDItemsTableViewController *itemsVC = [[RMDItemsTableViewController alloc] initWithStyle:UITableViewStylePlain];
   
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:itemsVC];
        navController.restorationIdentifier = NSStringFromClass([navController class]);
        [self.window setRootViewController:navController];
    }
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    return YES;
}

- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    BOOL success = [[RMDItemStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all the items");
    } else {
        NSLog(@"Could not save the items");
    }
}

- (UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
    UIViewController *vc = [[UINavigationController alloc] init];
    vc.restorationIdentifier = [identifierComponents lastObject];
    
    if ([identifierComponents count] == 1) {
        self.window.rootViewController = vc;
    } else {
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    return vc;
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
