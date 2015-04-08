//
//  ViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowScoringViewController.h"
#import "GameShowGame.h"
#import "WagerEntryViewController.h"
#import "GameShowGameRepository.h"

@interface GameShowScoringViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameRoundSelector;
@property (weak, nonatomic) UIButton *selectedValue;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *dailyDoubleCollection;
@property (weak, nonatomic) IBOutlet UIButton *dailyDoubleButton;

@end

@implementation GameShowScoringViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.jeopardyGame == nil) {
        self.jeopardyGame = [[GameShowGame alloc] init];
        self.jeopardyGame.playerScore = 0;
    }

    for (UIView *control in self.dailyDoubleCollection) {
        if ((UIButton*)control) {
            control.layer.cornerRadius = 10;
            control.clipsToBounds = YES;
        }
    }

    if (self.jeopardyGame.gameType == 0) {
        for (UIView *control in self.dailyDoubleCollection) {
            [control removeFromSuperview];
        }
    }

    [self setPlayerScoreValue:self.jeopardyGame.playerScore];

    for (UIButton *yourButton in self.clueValues) {
        yourButton.layer.cornerRadius = 10;
        yourButton.clipsToBounds = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setDailyDoubleWager:(NSInteger)dailyDoubleWager {
    _dailyDoubleWager = dailyDoubleWager;
    [self unsetNextValue];
    self.jeopardyGame.nextValue = dailyDoubleWager;
    UIColor *borderColor = [UIColor colorWithRed:(16.0/255.0) green:(2.0/255.0) blue:(114.0/255.0) alpha:1.0];
    [self.dailyDoubleButton.layer setBorderColor:[borderColor CGColor]];
    CGFloat borderWidth = 5.0;
    [self.dailyDoubleButton.layer setBorderWidth:borderWidth];
}

- (IBAction)setNextValue:(UIButton *)sender {
    [self unsetNextValue];
    if (sender == self.selectedValue) {
        self.selectedValue = nil;
    } else {
        self.selectedValue = sender;
        self.jeopardyGame.nextValue = sender.tag;
        UIColor *borderColor = [UIColor colorWithRed:(231.0/255.0) green:(196.0/255.0) blue:(90.0/255.0) alpha:1.0];
        [sender.layer setBorderColor:[borderColor CGColor]];
        CGFloat borderWidth = 5.0;
        [sender.layer setBorderWidth:borderWidth];
    }
}

- (void)unsetNextValue {
    for (UIButton *clueValue in self.clueValues) {
        [clueValue.layer setBorderColor:nil];
        [clueValue.layer setBorderWidth:0.0];
    }
    if (self.dailyDoubleButton) {
        [self.dailyDoubleButton.layer setBorderColor:nil];
        [self.dailyDoubleButton.layer setBorderWidth:0.0];
    }
    self.jeopardyGame.nextValue = 0;
}

- (IBAction)markAnswerCorrect {
    self.jeopardyGame.playerScore += self.jeopardyGame.nextValue;
    [self setPlayerScoreValue:self.jeopardyGame.playerScore];
    [self unsetNextValue];
}

- (IBAction)markAnswerIncorrect {
    self.jeopardyGame.playerScore -= self.jeopardyGame.nextValue;
    [self setPlayerScoreValue:self.jeopardyGame.playerScore];
    [self unsetNextValue];
}

- (IBAction)toggleJeopardyRound:(UISegmentedControl *)sender {
    [self unsetNextValue];
    self.selectedValue = nil;
    NSInteger ( ^ retag )( NSInteger );
    
    if ([sender selectedSegmentIndex] == 0) {
        retag = ^(NSInteger number){ return number / 2; };
    } else {
        retag = ^(NSInteger number){ return number * 2; };
    }
    for (UIButton *clueValue in self.clueValues) {
        NSInteger oldValue = clueValue.tag;
        NSInteger newValue = retag(oldValue);
        NSString *newValueText = [NSString stringWithFormat:@"$%li", (long)newValue];
        [clueValue setTitle:newValueText forState:UIControlStateNormal];
        [clueValue setTag:newValue];
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
    self.jeopardyGame.gameDescription = formattedString;
    [GameShowGameRepository saveGame:self.jeopardyGame];
    if (newScore >= 0) {
        [self.playerScore setTextColor:[UIColor whiteColor]];
    } else {
        [self.playerScore setTextColor:[UIColor redColor]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameShowScoringViewController *viewController = [segue destinationViewController];
    if ([viewController isKindOfClass:[WagerEntryViewController class]]) {
        WagerEntryViewController *wagerEntryViewController = (WagerEntryViewController*)viewController;
        wagerEntryViewController.playerScore = self.jeopardyGame.playerScore;
        wagerEntryViewController.gameRound = self.gameRoundSelector.selectedSegmentIndex;
        wagerEntryViewController.modalPresenterViewController = self;
    }
}


@end
