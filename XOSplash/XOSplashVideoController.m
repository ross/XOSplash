//
//  XOSplashVideoController.m
//  XOSplash
//
//  Created by Ross McFarland on 6/1/12.
//  Copyright (c) 2012 Ross McFarland. All rights reserved.
//

#import "XOSplashVideoController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation XOSplashVideoController {
    MPMoviePlayerController *_player;
    UIImageView *_backgroundImageView;
}

@synthesize delegate = _delegate;

- (id)initWithVideoURL:(NSURL *)url
             imageName:(NSString *)imageName
              delegate:(NSObject<XOSplashVideoDelegate> *)delegate;
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        CGRect frame = [[UIScreen mainScreen] bounds];
        UIWindow *window = [UIApplication sharedApplication].delegate.window;

        // put a background image in the window, so that it'll show as soon as the splash
        // goes away, this fixes most of the black flash
        UIImage *image = [UIImage imageNamed:imageName];
        _backgroundImageView = [[UIImageView alloc] initWithImage:image];
        CGRect backgroundFrame = frame;
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            // shift the background frame down to allow for the status bar, which shows and 
            // takes up "sapce" during the splash image on ipad
            backgroundFrame.origin.y += [[UIApplication sharedApplication] statusBarFrame].size.height;
            backgroundFrame.size.height -= [[UIApplication sharedApplication] statusBarFrame].size.height;
        }
        _backgroundImageView.frame = backgroundFrame;
        [window addSubview:_backgroundImageView];
        
        _player = [[MPMoviePlayerController alloc] initWithContentURL:url];
        // video doesn't need to be shifted down
        _player.view.frame = frame;
        _player.useApplicationAudioSession = NO;
        _player.controlStyle = MPMovieControlStyleNone;
        _player.scalingMode = MPMovieScalingModeNone;
        // we're going to install it once it's loaded and play it then
        _player.shouldAutoplay = NO;
        // there's still a little bit of black flash left when the player is inserted
        // as it starts to play, adding the splash image to the background of the player
        // will get rid of it
        UIImageView *playerBackground = [[UIImageView alloc] initWithImage:image];
        playerBackground.frame = backgroundFrame;
        [_player.backgroundView addSubview:playerBackground];

        // tell us when the video has loaded
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(splashLoadDidChange:)
                                                     name:MPMoviePlayerLoadStateDidChangeNotification
                                                   object:_player];
        
        // tell us when the video has finished playing
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(splashDidFinished:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:_player];
    }
    return self;
}

- (void)splashLoadDidChange:(NSNotification *)notification
{
    // we don't need this again
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerLoadStateDidChangeNotification
                                                  object:_player];

    // the video has loaded so we can safely add the player to the window now
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [window addSubview:_player.view];
    // and play it
    [_player play];

    // tell the delegate that the video has loaded
    [_delegate splashVideoLoaded:self];
}

- (void)splashDidFinished:(NSNotification *)notification
{
    // we don't need this again
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:_player];

    // tell our delegate that we're done playing
    [_delegate splashVideoLoaded:self];

    // take the background image out, we're done with it
    [_backgroundImageView removeFromSuperview];
    _backgroundImageView = nil;

    // take our player out of the window, we're done with it
    [_player.view removeFromSuperview];
    _player = nil;
}

@end
