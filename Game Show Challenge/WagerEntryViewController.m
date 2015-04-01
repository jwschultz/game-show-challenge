//
//  WagerEntryViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/30/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "WagerEntryViewController.h"

@interface WagerEntryViewController ()

@property (weak, nonatomic) IBOutlet UISlider *wagerSlider;


@end

@implementation WagerEntryViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"You entered %@",self.playerWager.text);
    [self.playerWager resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.wagerSlider setMinimumValue:5];
    [self.wagerSlider setMaximumValue:[self calculateMaximumWager]];
    
    self.playerWager.text = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (NSInteger)calculateMaximumWager {
    NSInteger defaultMax = (self.gameRound == 0 ? 1000 : 2000);
    return self.playerScore > defaultMax ? self.playerScore : defaultMax;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeWager:(UISlider *)sender {
    NSInteger newWagerValue = 50.0 * floor(([sender value]/50.0)+0.5);
    self.playerWager.hidden = NO;
    [self.playerWager setText:[NSString stringWithFormat:@"%li", newWagerValue]];
}
- (IBAction)placeWager:(id)sender {
    NSInteger wagerValue = [self.playerWager.text intValue];
    [self.myViewController setDailyDoubleWager:wagerValue];
    [self dismissViewControllerAnimated:NO completion:^{
        //
    }];
}





@end
