//
//  CardsViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 22/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "CardsViewController.h"
#import "Brain.h"
#import "Navigator.h"

@interface CardsViewController ()

@property (nonatomic) CardModel* card;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardExpiryLabel;
@end

@implementation CardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.card = [[Brain sharedInstance] card];
    if (self.card) {
        self.cardNumberLabel.text = self.card.number;
        self.cardExpiryLabel.text = self.card.expiry;
    }
    
    // Do any additional setup after loading the view.
}

- (IBAction)onRemoveCardTapped:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Squirrel"
                                          message:@"Delete this card?"
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:NSLocalizedString(@"Cancel", @"Cancel action")
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:NSLocalizedString(@"Delete", @"OK action")
                               style:UIAlertActionStyleDestructive
                               handler:^(UIAlertAction *action)
                               {
                                   [[Brain sharedInstance] clear];
                                   [[Navigator sharedInstance] navigateToGettingStarted];
                                   
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
