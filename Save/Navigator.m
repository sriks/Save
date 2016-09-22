//
//  Navigator.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

@import UIKit;
#import "Navigator.h"
#import "AppDelegate.h"

@implementation Navigator

+ (instancetype)sharedInstance {
    static Navigator *sharedNavigator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNavigator = [Navigator new];
    });
    return sharedNavigator;
}

- (void)navigateToHome {
    UIViewController* root = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateInitialViewController];
    [self ourWindow].rootViewController = root;
}

- (void)navigateToGettingStarted {
    UIViewController* root = [[UIStoryboard storyboardWithName:@"GettingStarted" bundle:nil] instantiateInitialViewController];
    [self ourWindow].rootViewController = root;

}

- (UIWindow*)ourWindow {
    UIApplication* app = [UIApplication sharedApplication];
    return app.windows.firstObject;
}

@end
