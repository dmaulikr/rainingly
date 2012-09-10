//
//  AboutViewController.m
//  HK Libraries
//
//  Created by Kenneth Anguish Anguish on 7/23/09.
//  Copyright 2009 Fantastic. All rights reserved.
// ʤ

#import "AboutViewController.h"


@implementation AboutViewController
@synthesize webView;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    self.view.backgroundColor = [UIColor darkGrayColor];
    
	NSString *helpfilepath;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        helpfilepath = [[NSBundle mainBundle] pathForResource:@"helpContent" ofType:@"html"];
    } else {
        helpfilepath = [[NSBundle mainBundle] pathForResource:@"helpContent_iphone" ofType:@"html"];
    }
    
	NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:helpfilepath];
	
	NSString *htmlString = [[NSString alloc] initWithData: 
							[readHandle readDataToEndOfFile] encoding:NSUTF8StringEncoding];
	
	NSString *basepath = [[NSBundle mainBundle] bundlePath];
	NSURL *baseURL = [NSURL fileURLWithPath:basepath];
	
	// to make html content transparent to its parent view -
	// 1) set the webview's backgroundColor property to [UIColor clearColor]
	// 2) use the content in the html: <body style="background-color: transparent">
	// 3) opaque property set to NO
	//
	webView.opaque = NO;
	webView.backgroundColor = [UIColor clearColor];
	[self.webView loadHTMLString:htmlString baseURL: baseURL];
	
    if (!(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
        self.webView.userInteractionEnabled = YES;
    }
    
	// Google Analytics
	//[GanTrackerWrapper trackEvent: @"About" withAction: @"List" andLabel: @"List"];
	
	// Splash screen stuff
	// http://michael.burford.net/2008/11/fading-defaultpng-when-iphone-app.html
	

	UIButton *websiteButton = [[UIButton alloc] initWithFrame: 
							 CGRectMake( 19.0, 510.0, 262.0, 37.0 )];
	// [websiteButton setBackgroundColor: [UIColor redColor]];
	
	[websiteButton addTarget: self action: @selector( websiteAction: ) forControlEvents: UIControlEventTouchDown];
	
	[self.view addSubview: websiteButton];
	
}

- (void)websiteAction:(id)sender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.britishcouncil.org/"]]; 
}

#pragma mark -
#pragma mark Other delegates

- (IBAction)dismissWindow:(id)sender {
	[self dismissModalViewControllerAnimated: YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}



@end
