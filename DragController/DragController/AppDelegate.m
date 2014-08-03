//
//  AppDelegate.m
//  DragController
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [MainViewController new];
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
