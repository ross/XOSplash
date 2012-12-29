//
//  XOSplashVideoController.h
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
 * to play. It is called in a background thread to avoid video studders.
 * Applications should avoid doing any "work" before this call so that
 * the splash image will switch to the splash video as quickly as
 * possible. Once this call is made the application should begin
 * doing any heavy lifting (likely in a background thread) while
 * the video plays. In the ideal case the work would be done by
 * by the time the complete call is made. */
- (void)splashVideoLoaded:(XOSplashVideoController *)splashVideo;

@end

/** Controller that enables integration of seamless splash video on 
 * iPad and iPhone. Videos should be at the full resolution of the device. 
 * It is recommended that you take a screenshot of the first video frame using
 * the simulator to get an exact match between the splash image and video. This
 * can be accomplished by commenting out the play call in the load notification.
 * You'll need to remove the status bar area (20px) from the iPad screenshot to
 * get the size required, 1004px for portrait. The procedure for iPhone is
 * slightly different, you'll need to remove the status bar and fill it in with
 * the video's background (color) to leave a full-size image.
 */
@interface XOSplashVideoController : UIViewController

@property (nonatomic, strong) NSObject<XOSplashVideoDelegate> * delegate;

/** Create a splash player, normally called in 
 * application:didLoadWithOptions and assigned to 
 * window.rootViewController. The video url and image name should
 * be appropriate for the current device and orientation. The video 
 * needs to match the screen's resolution and the image should
 * be one of the ones configured in the target summary, the
 * one that matches the current device and orientation. Orientations 
 * support will be dictated by the urls and image names passed in. */
- (id)initWithVideoPortraitUrl:(NSURL *)portraitUrl
             portraitImageName:(NSString *)portraitImageName
                  landscapeUrl:(NSURL *)landscapeUrl
            landscapeImageName:(NSString *)landscapeImageName
                      delegate:(NSObject<XOSplashVideoDelegate> *)delegate;

@end
