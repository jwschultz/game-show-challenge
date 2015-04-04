//
//  WagerEntryViewController.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/30/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowScoringViewController.h"

@interface WagerEntryViewController : UIViewController

@property (weak, nonatomic) GameShowScoringViewController *modalPresenterViewController;

@property (nonatomic) NSInteger playerScore;
@property NSInteger gameRound;

@end
