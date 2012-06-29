//
//  XOAppDelegate.m
//  XOSplash
//
//  Created by Ross McFarland on 6/1/12.
//  Copyright (c) 2012 Ross McFarland. All rights reserved.
//

#import "XOAppDelegate.h"

#import "XOViewController.h"
#import "XOSplashVideoController.h"

@implementation XOAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:frame];

    NSString *portraitVideoName = @"splash-iphone";
    NSString *portraitImageName = @"Default.png";
    NSString *landscapeVideoName = nil; // n/a
    NSString *landscapeImageName = nil; // n/a
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        portraitVideoName = @"splash-ipad";
        portraitImageName = @"Default-Portrait~ipad.png";
        landscapeVideoName = @"splash-ipad-landscape";
        landscapeImageName = @"Default-Landscape~ipad.png";
    }
    
    // our video
    NSURL *portraitUrl = [[NSBundle mainBundle] URLForResource:portraitVideoName withExtension:@"mp4"];
    NSURL *landscapeUrl = [[NSBundle mainBundle] URLForResource:landscapeVideoName withExtension:@"mp4"];
    // our splash controller
    XOSplashVideoController *splashVideoController = 
        [[XOSplashVideoController alloc] initWithVideoPortraitUrl:portraitUrl
                                                portraitImageName:portraitImageName
                                                     landscapeUrl:landscapeUrl
                                               landscapeImageName:landscapeImageName
                                                         delegate:self];
    // we'll start out with the spash view controller in the window
    self.window.rootViewController = splashVideoController;

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)splashVideoLoaded:(XOSplashVideoController *)splashVideo
{
    // load up our real view controller, but don't put it in to the window until the video is done
    // if there's anything expensive to do it should happen in the background now
    self.viewController = [[XOViewController alloc] initWithNibName:@"XOViewController" bundle:nil];
}

- (void)splashVideoComplete:(XOSplashVideoController *)splashVideo
{
    // swap out the splash controller for our app's
    self.window.rootViewController = self.viewController;
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
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
