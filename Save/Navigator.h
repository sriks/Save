//
//  Navigator.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Navigator : NSObject

+ (instancetype)sharedInstance;

- (void)navigateToHome;
- (void)navigateToGettingStarted;

@end
