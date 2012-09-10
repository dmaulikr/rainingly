//
//  HomeScreenViewController.h
//  Rainingly
//
//  Created by Kenneth Anguish on 8/12/12.
//  Copyright (c) 2012 Kenneth Anguish. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JBKenBurnsView.h"
#import <AVFoundation/AVFoundation.h>

@interface HomeScreenViewController : UIViewController {
    BOOL is_playing;
}

@property (nonatomic, retain) IBOutlet KenBurnsView *kbView;

@property (nonatomic, retain) IBOutlet UIButton *playPauseButton;
@property (nonatomic, retain) IBOutlet UIButton *aboutButton;

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;

- (IBAction)playPauseAction:(id)sender;
- (IBAction)aboutAction:(id)sender;

@end
