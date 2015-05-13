//
//  ViewController.m
//  SafariClone
//
//  Created by Husein Kareem on 5/13/15.
//  Copyright (c) 2015 Husein Kareem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self goToURLString:@"http://www.google.com"];

    

}

-(void)goToURLString:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text containsString:@"http://"]) {
        [self goToURLString:textField.text];
        [textField resignFirstResponder];
        return YES;
    } else {
        NSString *updatedUrl = [NSString stringWithFormat:@"http://www.%@", textField.text];
        [self goToURLString:updatedUrl];
        [textField resignFirstResponder];
        return YES;
    }
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.backButton setEnabled:[self.webView canGoBack]];
    [self.forwardButton setEnabled:[self.webView canGoForward]];
    [self.spinner stopAnimating];
    NSString *currentURL = self.webView.request.URL.absoluteString;
    self.textField.text = currentURL;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    UIAlertView *alert = [UIAlertView new];
    alert.title = @"Load Failed!";
    alert.message = error.localizedDescription;

    [alert addButtonWithTitle:@"Dismiss"];
    [alert addButtonWithTitle:@"Go home!"];
    alert.delegate = self;
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self goToURLString:@"http://www.google.com"];
    }
}

- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    [self.webView goForward];
}
- (IBAction)onStopLoadingButtonPressed:(UIButton *)sender {
    [self.webView stopLoading];
}
- (IBAction)onReloadButtonPressed:(UIButton *)sender {
    [self.webView reload];
}
- (IBAction)comingSoonButtonPressed:(UIButton *)sender {
    UIAlertView *alert = [UIAlertView new];
    alert.title = @"Coming Soon!";
    [alert addButtonWithTitle:@"Dismiss"];
    alert.delegate = self;
    [alert show];
}

//- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender {
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//        sender.enabled = YES;
//    } else {
//        sender.enabled = NO;
//    }
//}
//- (IBAction)onForwardButtonPressed:(UIBarButtonItem *)sender {
//    [self.webView goForward];
//    [sender setEnabled:[self.webView canGoForward]];
//}
//- (IBAction)onStopLoadingPressed:(UIBarButtonItem *)sender {
//    [self.webView stopLoading];
//}
//
//- (IBAction)onReloadButtonPressed:(UIBarButtonItem *)sender {
//    [self.webView reload];
//}
@end
