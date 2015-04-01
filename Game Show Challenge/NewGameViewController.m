//
//  NewGameViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/28/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "NewGameViewController.h"
#import "GameShowGame.h"

@interface NewGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *gameType;
@property (weak, nonatomic) IBOutlet UIDatePicker *airDate;

@end

const static NSInteger TODAYS_GAME_TAG = 0;
const static NSInteger ANOTHER_AIRDATE_TAG = 1;

@implementation NewGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.airDate.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    GameShowScoringViewController *viewController = [segue destinationViewController];
    UIButton *senderButton = (UIButton*)sender;
    
    viewController.jeopardyGame = [[GameShowGame alloc] init];
    viewController.jeopardyGame.gameType = self.gameType.selectedSegmentIndex;
    switch (senderButton.tag) {
        case TODAYS_GAME_TAG:
            // just use the default date from the GameShowGame init method
            break;
        case ANOTHER_AIRDATE_TAG:
            viewController.jeopardyGame.airDate = self.airDate.date;
        default:
            break;
    }
}

@end
