//
//  Brain.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "TransactionModel.h"
#import "BudgetModel.h"
#import "OfferModel.h"

@class CardModel;
@class UIColor;

@interface Brain : NSObject

+ (instancetype)sharedInstance;

+ (UIColor*)themeColor;

- (void)addCard:(CardModel*)card;
- (BOOL)isCardAdded;

- (RLMResults<TransactionModel*>*)transactionsForCategories:(NSArray*)categories;
- (RLMResults<BudgetModel*>*)budgets;
- (BudgetModel*)updateBudget:(BudgetModel*)budget limitTo:(NSNumber*)limit;
- (NSArray*)offers;

@end
