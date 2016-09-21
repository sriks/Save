//
//  TransactionsViewControllerTableViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "Brain.h"
#import "TransactionsViewController.h"
#import "SimpleCell.h"

@interface TransactionsViewController ()
@property (nonatomic) RLMResults<TransactionModel*>* transactions;
@property (nonatomic, weak) Brain* brain;
@end

@implementation TransactionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.brain = [Brain sharedInstance];
    [self reload];
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)reload  {
    self.transactions = [self.brain transactionsForCategories:self.categories];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SimpleCell *cell = (SimpleCell*)[tableView dequeueReusableCellWithIdentifier:@"simplecell" forIndexPath:indexPath];
    [cell configure:self.transactions[indexPath.row]];
    return cell;
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
