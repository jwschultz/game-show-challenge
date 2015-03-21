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
    self.playerScore.text = @"0";
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
    [self.playerScore setText:[@(jeopardyGame.playerScore) stringValue]];
}

- (IBAction)markAnswerIncorrect {
    jeopardyGame.playerScore -= jeopardyGame.nextValue;
    jeopardyGame.nextValue = 0;
    [self.playerScore setText:[@(jeopardyGame.playerScore) stringValue]];
}

- (IBAction)toggleJeopardyRound:(UISegmentedControl *)sender {
    if ([sender selectedSegmentIndex] == 0) {
        for (UIButton *clueValue in self.clueValues) {
            int oldValue = [clueValue.titleLabel.text intValue];
            int newValue = oldValue / 2;
            NSString *newValueText = [@(newValue) stringValue];
//            [clueValue.titleLabel setText:newValueText];
            [clueValue setTitle:newValueText forState:UIControlStateNormal];
        }
    } else {
        for (UIButton *clueValue in self.clueValues) {
            int oldValue = [clueValue.titleLabel.text intValue];
            int newValue = oldValue * 2;
            NSString *newValueText = [@(newValue) stringValue];
//            [clueValue.titleLabel setText:newValueText];
            [clueValue setTitle:newValueText forState:UIControlStateNormal];
        }
    }
    
    
    
}

@end
