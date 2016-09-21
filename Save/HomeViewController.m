//
//  FirstViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "HomeViewController.h"
#import "TransactionsViewController.h"
#import "GraphViewController.h"

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
@property (weak, nonatomic) IBOutlet UIView *contentContainer;
@property (nonatomic) TransactionsViewController* transactionsVC;
@property (nonatomic) GraphViewController* graphVC;
@property (assign, nonatomic) BOOL didSetContent;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    if (!self.didSetContent) {
        self.didSetContent = YES;
        self.segment.selectedSegmentIndex = 0;
        [self onSegmentChanged:self.segment];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSegmentChanged:(id)sender {
    if (0 == self.segment.selectedSegmentIndex) {
        [self showTransactionsList];
    } else {
        [self showTransactionsGraph];
    }
}

- (void)showTransactionsList {
    if (!self.transactionsVC) {
        self.transactionsVC = (TransactionsViewController*) [self viewControllerWithName:@"TransactionsViewController"];
    }
    [self moveChild:self.transactionsVC toContainer:self.contentContainer];
}

- (void)showTransactionsGraph {
    if (!self.graphVC) {
        self.graphVC = (GraphViewController*) [self viewControllerWithName:@"GraphViewController"];
    }
    [self moveChild:self.graphVC toContainer:self.contentContainer];
}

- (UIViewController*)viewControllerWithName:(NSString*)name {
    return
    [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:name];
}

- (void)moveChild:(UIViewController*)child toContainer:(UIView*)container {
    UIViewController *existingChild = [self.childViewControllers lastObject];
    if (existingChild) {
        [existingChild.view removeFromSuperview];
        [existingChild removeFromParentViewController];
    }
    
    [self addChildViewController:child];
    child.view.frame = CGRectMake(0, 0, container.frame.size.width, container.frame.size.height);
    [container addSubview:child.view];
    [child didMoveToParentViewController:self];
}




@end
