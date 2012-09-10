//
//  AboutViewController.h
//  HK Libraries
//
//  Created by Kenneth Anguish Anguish on 7/23/09.
//  Copyright 2009 Fantastic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface AboutViewController : UIViewController {
	UIWebView *webView;
}
@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (IBAction)dismissWindow:(id)sender;
-(void)displayComposerSheet;

@end
