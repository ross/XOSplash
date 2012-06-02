//
//  XOAppDelegate.h
//  XOSplash
//
//  Created by Ross McFarland on 6/1/12.
//  Copyright (c) 2012 Ross McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XOSplashVideoController.h"

@class XOViewController;

@interface XOAppDelegate : UIResponder <UIApplicationDelegate, XOSplashVideoDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) XOViewController *viewController;

@end
