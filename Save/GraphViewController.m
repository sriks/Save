//
//  GraphViewController.m
//  Save
//
//  Created by Srikanth Sombhatla on 21/9/16.
//  Copyright © 2016 Mastercard. All rights reserved.
//

#import "GraphViewController.h"
#import "TransactionsViewController.h"

@interface GraphViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;
    
    NSURL* url = [NSURL URLWithString:@"https://babydailywork.firebaseapp.com/index.html"];
    //NSURL* url = [NSURL URLWithString:@"http://10.157.195.153:8082/index.html"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL* url = request.URL;
    if ([url.host isEqualToString:@"saveapp.com"]) {
        NSLog(@"customurl: %@", url);
        NSURLComponents* comps = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:NO];
        if ([comps.path isEqualToString:@"/showtransactions"] && comps.queryItems) {
            NSURLQueryItem* query = comps.queryItems.firstObject;
            NSString* category = query.value;
            NSLog(@"category: %@", category);
            [self performSegueWithIdentifier:@"showtransactions" sender:category];
        }
        return NO;
    } else {
        return YES;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error {
    NSLog(@"webview error %@", error);
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)category {
    TransactionsViewController* dest = (TransactionsViewController*)segue.destinationViewController;
    dest.categories = @[category];
    dest.title = category;
}


@end
