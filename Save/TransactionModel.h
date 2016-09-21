//
//  TransactionModel.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

@interface TransactionModel : RLMObject

@property NSString* category;
@property NSString* merchant;
@property NSNumber<RLMDouble>* amount;
@property NSDate* date;

@end
RLM_ARRAY_TYPE(TransactionModel)
