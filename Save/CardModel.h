//
//  CardModel.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

@import Foundation;

@interface CardModel : NSObject
@property (nonatomic, copy) NSString* number;
@property (nonatomic, copy) NSString* expiry;
@property (nonatomic, copy) NSString* cvv;
@end
