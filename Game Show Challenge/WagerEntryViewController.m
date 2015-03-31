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
    NSInteger newWagerValue = [sender value] * 1;
    NSLog(@"New wager value: %li", newWagerValue);
    NSLog(@"%@", [NSString stringWithFormat:@"%li", newWagerValue]);
    NSLog(@"Text field: %@", self.playerWager);
    self.playerWager.hidden = NO;
    [self.playerWager setText:[NSString stringWithFormat:@"%li", newWagerValue]];
    NSLog(@"Changed the value: %f", [sender value]);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *viewController = (ViewController*)[segue destinationViewController];
    NSInteger wagerValue = [self.playerWager.text intValue];
    [viewController setDailyDoubleWager:wagerValue];
    [self dismissViewControllerAnimated:NO completion:^{
        //
    }];
}



@end
