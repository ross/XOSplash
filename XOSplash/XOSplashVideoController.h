//
//  XOSplashVideoPlayer.h
//  XOSplash
//
//  Created by Ross McFarland on 6/1/12.
//  Copyright (c) 2012 Ross McFarland. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XOSplashVideoController;

@protocol XOSplashVideoDelegate <NSObject>

@required

/** Called when the splash video has finished playing, the point at
 * which the video controller should be swapped out for the 
 * application's own (window.rootViewController) */
- (void)splashVideoComplete:(XOSplashVideoController *)splashVideo;

@optional

/** Called when the splash video has completed loading and is about
 * to play. Applications should avoid doing any "work" before this
 * call so that the splash image will switch to the splash video as
 * quickly as possible. Once this call is made the application should 
 * begin doing any heavy lifting (likely in a background thread)
 * while the video plays. In the ideal case the work would be done
 * by the time the complete call is made. */
- (void)splashVideoLoaded:(XOSplashVideoController *)splashVideo;

@end

@interface XOSplashVideoController : UIViewController

@property (nonatomic, strong) NSObject<XOSplashVideoDelegate> * delegate;

/** Create a splash player, normally called in 
 * application:didLoadWithOptions and assigned to 
 * window.rootViewController. The video url and image name should
 * be appropriate for the current device and orientation. The video 
 * needs to match the screen's resolution and the image should
 * be one of the ones configured in the target summary, the
 * one that matches the current device and orientation. */
- (id)initWithVideoURL:(NSURL *)url
             imageName:(NSString *)imageName
              delegate:(NSObject<XOSplashVideoDelegate> *)delegate;

@end