//
//  BudgetViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "BudgetViewController.h"
#import "Brain.h"
#import "SimpleCell.h"
#import "UpdateBudgetViewController.h"

@interface BudgetViewController ()
@property (nonatomic) RLMResults<BudgetModel*>* budgets;
@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINib* nib = [UINib nibWithNibName:@"SimpleCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"simplecell"];
}

- (void)viewWillAppear:(BOOL)animated {
    self.budgets = [Brain sharedInstance].budgets;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.budgets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SimpleCell* cell = (SimpleCell*)[tableView dequeueReusableCellWithIdentifier:@"simplecell" forIndexPath:indexPath];
    [cell configure:self.budgets[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"updateBudget" sender:self.budgets[indexPath.row]];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)model {
    UpdateBudgetViewController* dest = (UpdateBudgetViewController*)segue.destinationViewController;
    dest.model = (BudgetModel*)model;
}

@end
