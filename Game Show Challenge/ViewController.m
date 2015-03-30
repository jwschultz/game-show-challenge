//
//  ViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GameShowGame.h"
#import <Parse/Parse.h>

@interface ViewController ()

@property (weak, nonatomic) UIButton *selectedValue;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *dailyDoubleCollection;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (self.jeopardyGame == nil) {
        self.jeopardyGame = [[GameShowGame alloc] init];
        self.jeopardyGame.playerScore = 0;
    }
    
    if (self.jeopardyGame.gameType == 0) {
        for (UIControl *control in self.dailyDoubleCollection) {
            [control setAlpha:0];
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


- (IBAction)setNextValue:(UIButton *)sender {
    [self unsetNextValue];
    if (sender == self.selectedValue) {
        self.selectedValue = nil;
    } else {
        self.selectedValue = sender;
        self.jeopardyGame.nextValue = [sender.titleLabel.text intValue];
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
    self.jeopardyGame.gameDescription = formattedString;
    [self saveGameToParse];
    if (newScore >= 0) {
        [self.playerScore setTextColor:[UIColor whiteColor]];
    } else {
        [self.playerScore setTextColor:[UIColor redColor]];
    }
}

- (void) saveGameToParse {
    PFUser *user = [PFUser currentUser];
    PFObject *gameObject;
    
    // if this game has previously been saved, it should have a parseObjectId. Update the object with that id.
    if (self.jeopardyGame.persisted) {
        if (self.jeopardyGame != nil && self.jeopardyGame.parseObjectId != nil) {
            PFQuery *query = [PFQuery queryWithClassName:@"GameShowGame"];
            [query getObjectInBackgroundWithId:self.jeopardyGame.parseObjectId block:^(PFObject *gameObject, NSError *error) {
                [gameObject setValue:[NSNumber numberWithLong:self.jeopardyGame.playerScore] forKey:@"playerScore"];
                [gameObject setValue:self.jeopardyGame.gameDescription forKey:@"gameDescription"];
                [gameObject saveInBackground];
            }];
        }
    } else {
        gameObject = [PFObject objectWithClassName:@"GameShowGame"];
        
        [gameObject setValue:[NSNumber numberWithLong:self.jeopardyGame.playerScore] forKey:@"playerScore"];
        [gameObject setValue:self.jeopardyGame.gameDescription forKey:@"gameDescription"];
        [gameObject setValue:self.jeopardyGame.airDate forKey:@"airDate"];
        gameObject[@"user"] = user;

        [gameObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                self.jeopardyGame.parseObjectId = gameObject.objectId;
            } else {
                NSLog(@"There was an error: %@", error);
            }
        }];
        self.jeopardyGame.persisted = YES; // track the fact that we're trying to save this
    }

}

@end
