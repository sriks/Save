//
//  OffersViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "OffersViewController.h"
#import "Brain.h"
#import "SimpleCell.h"

@interface OffersViewController ()
@property (nonatomic) NSArray* offers;
@end

@implementation OffersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.offers = [[Brain sharedInstance] offers];
    UINib* nib = [UINib nibWithNibName:@"SimpleCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"simplecell2"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.offers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"offercell" forIndexPath:indexPath];
    OfferModel* model = self.offers[indexPath.row];
    cell.textLabel.text= model.merchant;
    cell.detailTextLabel.text = model.details;
    return cell;
}


@end
