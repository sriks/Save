//
//  BudgetModel.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Realm/Realm.h>

@interface BudgetModel : RLMObject

@property NSString* category;
@property NSNumber<RLMDouble>* limit;

@end
