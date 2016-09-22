//
//  Brain.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

@import UIKit;
#import "Brain.h"
#import "CardModel.h"

@interface Brain ()
@property (nonatomic) RLMRealm* realm;
@property (nonatomic) NSMutableArray* offersArray;
@end

@implementation Brain

+ (instancetype)sharedInstance {
    static Brain *sharedBrain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedBrain = [Brain new];
        [sharedBrain setup];
    });
    return sharedBrain;
}

- (void)setup {
    self.realm = [RLMRealm defaultRealm];
    if ([self.realm isEmpty]) {
        [self loadData];
    }
}

- (void)clear {
    [self.realm beginWriteTransaction];
    [self.realm deleteAllObjects];
    [self.realm commitWriteTransaction];
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
}

+ (UIColor*)themeColor {
    return [UIColor colorWithRed:14/255.0 green:173/255.0 blue:154/255.0 alpha:1];
}

- (void)addCard:(CardModel*)card {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:card.number forKey:@"card_number"];
    [defaults synchronize];
}

- (BOOL)isCardAdded {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* cardNum = [defaults stringForKey:@"card_number"];
    return (cardNum != nil);
}

- (void)setSetting:(NSString*)settingName value:(NSObject*)value {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:settingName];
    [defaults synchronize];
}

- (BOOL)isSet:(NSString*)settingName {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSObject* value = [defaults objectForKey:settingName];
    return (value != nil);
}

- (void)loadData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray* transactions = json[@"data"];
    NSArray* budgets = json[@"budget"];
    NSLog(@"data %@", json);
    
    [self.realm beginWriteTransaction];
    
    for (NSDictionary* t in transactions) {
        TransactionModel* model = [[TransactionModel alloc] init];
        model.category = t[@"category"];
        model.merchant = t[@"merchant"];
        model.amount = t[@"amount"];
        NSString *dateString = t[@"date"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
        NSDate *date = [[NSDate alloc] init];
        date = [dateFormatter dateFromString:dateString];
        model.date = date;
        NSLog(@"%@", model);
        [self.realm addObject:model];
    }
    
    for (NSDictionary* b in budgets) {
        BudgetModel* model = [BudgetModel new];
        model.category = b[@"category"];
        model.limit = b[@"limit"];
        [self.realm addObject:model];
    }
    
    [self.realm commitWriteTransaction];
    [self setSetting:@"loaddata" value:[NSNumber numberWithBool:YES]];
}

- (RLMResults<TransactionModel*>*)transactionsForCategories:(NSArray*)categories {
    RLMResults<TransactionModel*>* transactions;
    if (categories.count) {
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"category IN %@", categories];
        transactions = [TransactionModel objectsWithPredicate:pred];
    } else {
        transactions = [TransactionModel allObjects];
    }
    
    transactions = [transactions sortedResultsUsingProperty:@"date" ascending:NO];
    NSLog(@"all %@", transactions);
    return transactions;
}

- (RLMResults<BudgetModel*>*)budgets {
    return [BudgetModel allObjects];
}

- (BudgetModel*)updateBudget:(BudgetModel*)budget limitTo:(NSNumber*)limit {
    [self.realm beginWriteTransaction];
    budget.limit = limit;
    [self.realm commitWriteTransaction];
    return budget;
}

- (NSArray*)offers {
    if (!self.offersArray) {
        self.offersArray = [NSMutableArray new];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"offers" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSArray* offers = json[@"offers"];

        for (NSDictionary* o in offers) {
            OfferModel* model = [OfferModel new];
            model.category = o[@"category"];
            model.merchant = o[@"name"];
            model.details = o[@"desc"];
            model.clause = o[@"subtitle"];
            model.imageUrl = [NSURL URLWithString:o[@"image"]];
            [self.offersArray addObject:model];
        }
    }
    
    return self.offersArray;
}

@end
