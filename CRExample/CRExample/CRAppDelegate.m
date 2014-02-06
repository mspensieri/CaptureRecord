//
//  CRAppDelegate.m
//  CRExample
//
//  Created by Michael Spensieri on 2/6/14.
//  Copyright (c) 2014 Michael Spensieri. All rights reserved.
//

#import "CRAppDelegate.h"
#import "CRViewController.h"

@implementation CRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[CRUIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[CRViewController alloc] init];
    
    [[CRRecorder sharedRecorder] setAlbumName:@"Capture Record"];
    //[[CRRecorder sharedRecorder] setOptions:0];
    
    // To disable:
    //[CRUIWindow setDisabled:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end