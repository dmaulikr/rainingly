//
//  HomeScreenViewController.m
//  Rainingly
//
//  Created by Kenneth Anguish on 8/12/12.
//  Copyright (c) 2012 Kenneth Anguish. All rights reserved.
//

#import "HomeScreenViewController.h"
#import "AboutViewController.h"
#import "WBSuccessNoticeView.h"

@interface HomeScreenViewController ()

@end

@implementation HomeScreenViewController
@synthesize kbView, playPauseButton, aboutButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSString *nibname;
    
    // Custom initialization
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        nibname = @"HomeScreenViewController";
    } else {
        nibname = @"HomeScreenViewIPhoneController";
    }
    
    self = [super initWithNibName: nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.kbView != nil) {
        self.kbView.backgroundColor = [UIColor blackColor];
        self.kbView.layer.borderWidth = 1;
        self.kbView.layer.borderColor = [UIColor blackColor].CGColor;
        
        
        NSArray *myImages = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"bg_01.jpg"],
                             [UIImage imageNamed:@"bg_02.jpg"],
                             [UIImage imageNamed:@"bg_03.jpg"],
                             [UIImage imageNamed:@"bg_04.jpg"],
                             
                             nil];
        
        [self.kbView animateWithImages: myImages
                    transitionDuration: 15
                                  loop: YES
                           isLandscape: YES];
    }
    
    
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"loop" ofType:@"mp3"]];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL: url error:nil];
    self.audioPlayer.numberOfLoops = -1;
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    is_playing = NO;
    
    [self.view bringSubviewToFront: self.playPauseButton];
    
    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.playPauseButton.frame = CGRectMake( 412.0, 284.0, 200.0, 200.0 );
            self.aboutButton.frame = CGRectMake( 967.0, 689.0, 44.0, 44.0 );

        } else {
            self.playPauseButton.frame = CGRectMake( 284.0, 412.0, 200.0, 200.0 );
            self.aboutButton.frame = CGRectMake( 704.0, 940.0, 44.0, 44.0 );
        }
    } else {
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            self.playPauseButton.frame = CGRectMake( 190.0, 110.0 - 10, 100.0, 100.0 );
            self.aboutButton.frame = CGRectMake( 416.0 + 10, 246.0, 44.0, 44.0 );
        } else {
            self.playPauseButton.frame = CGRectMake( 110.0, 190.0 - 10, 100.0, 100.0 );
            self.aboutButton.frame = CGRectMake( 260.0 + 10, 410.0, 44.0, 44.0 );
        }

    }
    
    // check if it's iPhone 5
    if ([[UIScreen mainScreen] bounds].size.height >= 568) {
        self.aboutButton.frame = CGRectMake( 260.0, 400.0 + 84, 44.0, 44.0 );
    }

}

- (IBAction)playPauseAction:(id)sender {
    NSLog(@"- (IBAction)playPauseAction:(id)sender");
    
    if ([self.audioPlayer isPlaying]) {
        is_playing = NO;
        [self.audioPlayer stop];
        
        
        self.playPauseButton.hidden = NO;
        self.aboutButton.hidden = NO;
        
        self.playPauseButton.alpha = 0.0;
        self.aboutButton.alpha = 0.0;

        [UIView animateWithDuration: 0.4 animations:^{
            self.playPauseButton.alpha = 1.0;
            self.aboutButton.alpha = 1.0;

        } completion:^(BOOL finished) {
            if (finished) {
            }
        }];

    } else {
        is_playing = YES;
        [self.audioPlayer play];
        
        self.playPauseButton.hidden = YES;
        self.aboutButton.hidden = YES;

        self.playPauseButton.alpha = 1.0;
        self.aboutButton.alpha = 1.0;

        
        [UIView animateWithDuration: 0.4 animations:^{
            self.playPauseButton.alpha = 0.0;
            self.aboutButton.alpha = 0.0;

        } completion:^(BOOL finished) {
            if (finished) {
                WBSuccessNoticeView *view = [WBSuccessNoticeView successNoticeInView: self.kbView title: @"Click anywhere to stop raining"];
                [view show];

            }
        }];

    }
    
    [super viewDidLoad];

}

- (IBAction)aboutAction:(id)sender {
    AboutViewController *nextController = [[AboutViewController alloc] initWithNibName: @"AboutView" bundle: nil];
	nextController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
	nextController.modalPresentationStyle = UIModalPresentationFormSheet;

    [self.navigationController presentModalViewController: nextController animated: YES];
}

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
            self.playPauseButton.frame = CGRectMake( 412.0, 284.0, 200.0, 200.0 );
            self.aboutButton.frame = CGRectMake( 967.0, 689.0, 44.0, 44.0 );
            
        } else {
            self.playPauseButton.frame = CGRectMake( 284.0, 412.0, 200.0, 200.0 );
            self.aboutButton.frame = CGRectMake( 704.0, 940.0, 44.0, 44.0 );
        }
    } else {
        if ([[UIScreen mainScreen] bounds].size.height >= 568) {

            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
                self.playPauseButton.frame = CGRectMake( 190.0, 110.0 - 10, 100.0, 100.0 );
                self.aboutButton.frame = CGRectMake( 420.0 + 84, 240.0, 44.0, 44.0 );
                
            } else {
                self.playPauseButton.frame = CGRectMake( 110.0, 190.0 - 10, 100.0, 100.0 );
                self.aboutButton.frame = CGRectMake( 260.0, 400.0 + 84, 44.0, 44.0 );
            }
        } else {
            if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight) {
                self.playPauseButton.frame = CGRectMake( 190.0, 110.0 - 10, 100.0, 100.0 );
                self.aboutButton.frame = CGRectMake( 416.0 + 10, 246.0, 44.0, 44.0 );
                
            } else {
                self.playPauseButton.frame = CGRectMake( 110.0, 190.0 - 10, 100.0, 100.0 );
                self.aboutButton.frame = CGRectMake( 260.0 + 10, 410.0, 44.0, 44.0 );
            }
        }
    }

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	// gestureStartPoint = [touch locationInView: tapView];
	
	NSUInteger tapCount = [touch tapCount];
	switch (tapCount) {
            //	NSLog(@"entered tap count");
        case 1:
            if (is_playing) {
                [self performSelector: @selector(playPauseAction:) withObject: nil  afterDelay: .01 ];
            }
            break;
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
