//
//  SavedGamesTableViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/23/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "SavedGamesTableViewController.h"
#import "SavedGameTableViewCell.h"
#import "GameShowGame.h"
#import "GameShowScoringViewController.h"
#import "GameShowGameRepository.h"

@interface SavedGamesTableViewController ()

@property (strong, nonatomic) GameShowGame *jeopardyGame;
@property (strong, nonatomic) NSArray *savedGames;

@end

@implementation SavedGamesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.savedGames == nil) {
        self.savedGames = [NSMutableArray arrayWithCapacity:50];
    }
    
    [GameShowGameRepository findGamesForCurrentUserWithBlock:^(NSArray *gamesArray) {
        self.savedGames = [NSArray arrayWithArray:gamesArray];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return [self.savedGames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"newGameCell" forIndexPath:indexPath];
    }
    SavedGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedGameCell" forIndexPath:indexPath];
    if ([self.savedGames count] > indexPath.row) {
        GameShowGame *savedGame = [self.savedGames objectAtIndex:indexPath.row];
        cell.game = savedGame;
        UIView *contentView = cell.subviews[0];
        NSString *dateString = [NSDateFormatter localizedStringFromDate:savedGame.airDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
        [contentView.subviews[0] setText:[NSString stringWithFormat:@"%@ (%@)", dateString, savedGame.gameDescription]];
        if (savedGame.playerScore < 0) {
            UILabel * playerScoreLabel = contentView.subviews[0];
            [playerScoreLabel setTextColor:[UIColor redColor]];
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    GameShowScoringViewController *viewController = [segue destinationViewController];
    UITableViewCell *selectedCell = (UITableViewCell*)sender;
    
    NSArray *savedGamesArray = self.savedGames;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    if (indexPath.section > 0 && [savedGamesArray count] > indexPath.row) {
        viewController.jeopardyGame = [savedGamesArray objectAtIndex:(indexPath.row)];
    }
}


@end
