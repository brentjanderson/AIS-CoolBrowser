//
//  CBBrowserViewController.m
//  CoolBrowser
//
//  Created by Brent Anderson on 10/30/13.
//  Copyright (c) 2013 BYU AIS. All rights reserved.
//

#import "CBBrowserViewController.h"

@interface CBBrowserViewController ()

@end

@implementation CBBrowserViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.textField.delegate = self;
    self.webView.delegate = self;
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.apple.com/"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
}

/** Button to stop loading/refresh the page */
- (IBAction)refreshStop:(UIBarButtonItem *)sender {
    if (self.webView.isLoading) {
        [self.webView stopLoading];
    } else {
        [self.webView reload];
    }
}

/** Button to go back */
- (IBAction)goBack:(id)sender {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

/** Button to go forward */
- (IBAction)goForward:(id)sender {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

/** Delegate method - triggered when the user presses the return key in the URL box */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSURL *url = [[NSURL alloc] initWithString:textField.text];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    [textField resignFirstResponder];
    return NO;
}

/** Delegate method - triggered when the web view starts loading; change the bar button item to be a stop button */
- (void) webViewDidStartLoad:(UIWebView *)webView {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                         target:self
                                                                         action:@selector(refreshStop:)];
    self.refreshStopButton = btn;
    
}

/** Delegate method - triggered when the web view is finished loading; Set up buttons to be enabled/disabled depending on history, set up URL field */
- (void) webViewDidFinishLoad:(UIWebView *)webView {
    UIBarButtonItem* btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                         target:self
                                                                         action:@selector(refreshStop:)];
    self.refreshStopButton = btn;
    
    if (webView.canGoBack) {
        self.goBackButton.enabled = YES;
    } else {
        self.goBackButton.enabled = NO;
    }
    
    if (webView.canGoForward) {
        self.goForwardButton.enabled = YES;
    } else {
        self.goForwardButton.enabled = NO;
    }
    
    self.textField.text = webView.request.URL.absoluteString;
}

/** If something bad happens! */
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView* av = [[UIAlertView alloc] initWithTitle:@"Error loading page" message:error.localizedDescription delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

/** Easter egg - when we shake the phone, load AIS website :-) */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake) {
        NSURL *url = [[NSURL alloc] initWithString:@"http://ais.byu.edu"];
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:request];

    }
}

@end
