//
//  TransactionCell.h
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransactionModel;
@interface SimpleCell : UITableViewCell

- (void)configure:(NSObject*)model;

@end
