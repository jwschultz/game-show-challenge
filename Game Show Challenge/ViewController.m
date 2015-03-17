//
//  ViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self addConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addConstraints {
    [self.view removeConstraints:self.view.constraints];

    UITextField *playerScore = self.playerScore;
    UIButton *button7 = self.button7;
    UIButton *button8 = self.button8;
    UIButton *button9 = self.button9;
    UIButton *button4 = self.button4;
    UIButton *button5 = self.button5;
    UIButton *button6 = self.button6;
    UIButton *button1 = self.button1;
    UIButton *button2 = self.button2;
    UIButton *button3 = self.button3;
    UIButton *button0 = self.button0;
    UIButton *buttonCancel = self.buttonCancel;
    UIButton *dailyDouble = self.dailyDouble;
    UIButton *finalWager = self.finalWager;
    UIButton *correct = self.correct;
    UIButton *incorrect = self.incorrect;
    UIButton *singleValue200 = self.singleValue200;
    UIButton *singleValue400 = self.singleValue400;
    UIButton *singleValue600 = self.singleValue600;
    UIButton *singleValue800 = self.singleValue800;
    UIButton *singleValue1000 = self.singleValue1000;
    UIButton *doubleValue400 = self.doubleValue400;
    UIButton *doubleValue800 = self.doubleValue800;
    UIButton *doubleValue1200 = self.doubleValue1200;
    UIButton *doubleValue1600 = self.doubleValue1600;
    UIButton *doubleValue2000 = self.doubleValue2000;
    NSDictionary *views = NSDictionaryOfVariableBindings
        (button7, button8, button9, button4, button5, button6, button1, button2, button3,
         button0, buttonCancel, dailyDouble, finalWager, correct, incorrect,
         singleValue200, singleValue400, singleValue600, singleValue800, singleValue1000,
         doubleValue400, doubleValue800, doubleValue1200, doubleValue1600, doubleValue2000,
         playerScore);
    NSDictionary *metrics = @{};
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat: @"V:|-[playerScore]-[button7]-[button4]-[button1]-[button0]-[dailyDouble]-[finalWager]-[correct]-|"
                                                                   options:0
                                                                   metrics:metrics
                                                                     views:views];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[playerScore]-[singleValue200]-[singleValue400]-[singleValue600]-[singleValue800]-[singleValue1000]-|" options:0 metrics:metrics views:views]];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button7]-[button8]-[button9]-[singleValue200]-[doubleValue400]-|"
                                                                                                     options:0
                                                                                                     metrics:metrics
                                                                                                       views:views]];
    
    [self.view addConstraints:constraints];
}

@end
