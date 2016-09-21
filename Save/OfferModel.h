//
//  OfferModel.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OfferModel : NSObject

@property (nonatomic, copy) NSString* merchant;
@property (nonatomic, copy) NSString* details;
@property (nonatomic, copy) NSString* clause;
@property (nonatomic, copy) NSURL* imageUrl;

@end
