//
//  ScanCardViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "ScanCardViewController.h"
#import "CardIO.h"
#import "CardModel.h"
#import "Brain.h"
#import "Navigator.h"

@interface ScanCardViewController () <CardIOPaymentViewControllerDelegate>

@end

@implementation ScanCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([Brain sharedInstance].isCardAdded) {
        [[Navigator sharedInstance] navigateToHome];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [CardIOUtilities preloadCardIO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didTapOnScanCard:(id)sender {
    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
    [self presentViewController:scanViewController animated:YES completion:nil];
}

- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)scanViewController {
    NSLog(@"User canceled payment info");
    // Handle user cancellation here...
    [scanViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info
             inPaymentViewController:(CardIOPaymentViewController *)scanViewController {

    [scanViewController dismissViewControllerAnimated:YES completion:nil];
    CardModel* card = [CardModel new];
    card.number = info.redactedCardNumber;
    card.expiry = [NSString stringWithFormat:@"%02lu/%lu", (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear];
    card.cvv = info.cvv;
    [[Brain sharedInstance] addCard:card];
    NSLog(@"Received card info. Number: %@, expiry: %@, cvv: %@.", card.number, card.expiry, card.cvv);
    
    [self performSegueWithIdentifier:@"showCardAdded" sender:self];
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
