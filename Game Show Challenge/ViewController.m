//
//  ViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "ViewController.h"
#import "GameShowGame.h"

@interface ViewController ()

@end

@implementation ViewController

static GameShowGame *jeopardyGame;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    jeopardyGame = [[GameShowGame alloc] init];
    jeopardyGame.playerScore = 0;
    self.playerScore.text = @"$0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setNextValue:(UIButton *)sender {
    jeopardyGame.nextValue = [sender.titleLabel.text intValue];
}

- (IBAction)markAnswerCorrect {
    jeopardyGame.playerScore += jeopardyGame.nextValue;
    jeopardyGame.nextValue = 0;
    [self setPlayerScoreValue:jeopardyGame.playerScore];
}

- (IBAction)markAnswerIncorrect {
    jeopardyGame.playerScore -= jeopardyGame.nextValue;
    jeopardyGame.nextValue = 0;
    [self setPlayerScoreValue:jeopardyGame.playerScore];
}

- (IBAction)toggleJeopardyRound:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        for (UIButton *clueValue in self.clueValues) {
            int oldValue = [clueValue.titleLabel.text intValue];
            int newValue = oldValue / 2;
            NSString *newValueText = [@(newValue) stringValue];
            [clueValue setTitle:newValueText forState:UIControlStateNormal];
        }
    } else {
        for (UIButton *clueValue in self.clueValues) {
            int oldValue = [clueValue.titleLabel.text intValue];
            int newValue = oldValue * 2;
            NSString *newValueText = [@(newValue) stringValue];
            [clueValue setTitle:newValueText forState:UIControlStateNormal];
        }
    }
}

- (void) setPlayerScoreValue:(NSInteger)newScore {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
    [formatter setGroupingSeparator:groupingSeparator];
    [formatter setGroupingSize:3];
    [formatter setAlwaysShowsDecimalSeparator:NO];
    [formatter setMaximumFractionDigits:0];
    [formatter setUsesGroupingSeparator:YES];
        
    NSString *formattedString = [formatter stringFromNumber:[NSNumber numberWithInteger:newScore]];
    [self.playerScore setText:formattedString];
    if (newScore > 0) {
        [self.playerScore setTextColor:[UIColor whiteColor]];
    } else {
        [self.playerScore setTextColor:[UIColor redColor]];
    }
}

@end
