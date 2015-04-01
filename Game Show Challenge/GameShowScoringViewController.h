//
//  ViewController.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameShowGame;

@interface GameShowScoringViewController : UIViewController 

@property (strong, nonatomic) GameShowGame *jeopardyGame;
@property (weak, nonatomic) IBOutlet UITextField *playerScore;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *clueValues;
@property (nonatomic) NSInteger dailyDoubleWager;


@end

