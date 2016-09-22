//
//  TransactionCell.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "SimpleCell.h"
#import "TransactionModel.h"
#import "BudgetModel.h"
#import "OfferModel.h"

@interface SimpleCell ()
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation SimpleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configure:(NSObject*)model {
    
    if ([model isKindOfClass:[TransactionModel class]]) {
        [self configureAsTransaction:(TransactionModel*) model];
    }
    
    else if ([model isKindOfClass:[BudgetModel class]]) {
        [self configureAsBudget:(BudgetModel*)model];
    }
    
    else if ([model isKindOfClass:[OfferModel class]]) {
        [self configureAsOffer:(OfferModel*)model];
    }
}

- (void)configureAsTransaction:(TransactionModel*)model {
    self.categoryImageView.image = [UIImage imageNamed:model.category];
    self.titleLabel.text = model.merchant;
    self.amountLabel.text = [NSString stringWithFormat:@"$ %@", model.amount];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    NSString *stringDate = [dateFormatter stringFromDate:model.date];
    self.subtitleLabel.text = stringDate;
}

- (void)configureAsBudget:(BudgetModel*)model {
    self.categoryImageView.image = [UIImage imageNamed:model.category];
    self.titleLabel.text = model.category;
    self.amountLabel.text = @"   ";
    self.subtitleLabel.text = [NSString stringWithFormat:@"Limit to $ %@", model.limit];
}

- (void)configureAsOffer:(OfferModel*)model {
    self.titleLabel.text = model.merchant;
    self.subtitleLabel.text = model.details;
    self.subtitleLabel.numberOfLines = 2;
    self.categoryImageView.image = [UIImage imageNamed:model.category];
}


@end
