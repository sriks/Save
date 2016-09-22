//
//  CardModel.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

@import Foundation;
#import <Realm/Realm.h>

@interface CardModel : RLMObject
@property NSString* number;
@property NSString* expiry;
@property NSString* cvv;
@end
