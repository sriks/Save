//
//  UpdateBudgetViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "UpdateBudgetViewController.h"
#import "Brain.h"

@interface UpdateBudgetViewController ()
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UITextField *limitTextField;

@end

@implementation UpdateBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.categoryLabel.text = self.model.category;
    self.limitTextField.text = [NSString stringWithFormat:@"%@", self.model.limit];
    self.categoryLabel.tintColor = [Brain themeColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.limitTextField.text.length) {
        [[Brain sharedInstance] updateBudget:self.model
                                     limitTo:[NSNumber numberWithDouble: self.limitTextField.text.doubleValue]];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
