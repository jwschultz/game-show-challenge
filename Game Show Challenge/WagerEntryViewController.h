//
//  WagerEntryViewController.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/30/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowScoringViewController.h"

@interface WagerEntryViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *playerWager;
@property (weak, nonatomic) GameShowScoringViewController *myViewController;

@property (nonatomic) NSInteger playerScore;
@property NSInteger gameRound;

@end
