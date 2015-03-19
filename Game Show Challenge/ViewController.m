//
//  ViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "ViewController.h"
#import "JeopardyGame.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    self.jeopardyGame = [[JeopardyGame alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)setNextValue:(UIButton *)sender {
    self.jeopardyGame.nextValue = atoi([sender.titleLabel.text cString]);
}

- (IBAction)markAnswerCorrect {
    self.jeopardyGame.playerScore += self.jeopardyGame.nextValue;
}

@end
