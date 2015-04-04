//
//  WagerEntryViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/30/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "WagerEntryViewController.h"

@interface WagerEntryViewController ()

@property (weak, nonatomic) IBOutlet UILabel *wagerDisplay;
@property (weak, nonatomic) IBOutlet UISlider *wagerSlider;
@property (nonatomic) NSInteger wagerAmount;


@end

@implementation WagerEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.wagerSlider setMinimumValue:5];
    [self.wagerSlider setMaximumValue:[self calculateMaximumWager]];
    
    [self.wagerDisplay setText:@"$0"];
    self.wagerAmount = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (NSInteger)calculateMaximumWager {
    NSInteger defaultMax = (self.gameRound == 0 ? 1000 : 2000);
    return self.playerScore > defaultMax ? self.playerScore : defaultMax;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)changeWager:(UISlider *)sender {
    self.wagerAmount = 50.0 * floor(([sender value]/50.0)+0.5);
    [self.wagerDisplay setText:[NSString stringWithFormat:@"$%li", (long)self.wagerAmount]];
}

- (IBAction)placeWager:(id)sender {
    [self.modalPresenterViewController setDailyDoubleWager:self.wagerAmount];
    [self dismissViewControllerAnimated:NO completion:^{
        //
    }];
}





@end
