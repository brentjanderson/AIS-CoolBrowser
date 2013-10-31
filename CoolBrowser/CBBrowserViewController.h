//
//  CBBrowserViewController.h
//  CoolBrowser
//
//  Created by Brent Anderson on 10/30/13.
//  Copyright (c) 2013 BYU AIS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CBBrowserViewController : UIViewController <UITextFieldDelegate, UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshStopButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
