//
//  SavedGamesTableViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/23/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "SavedGamesTableViewController.h"
#import "GameShowGame.h"
#import "ViewController.h"

@interface SavedGamesTableViewController ()

@end

@implementation SavedGamesTableViewController

static NSMutableArray *savedGames;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (savedGames == nil) {
        savedGames = [NSMutableArray arrayWithCapacity:50];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    
    return [savedGames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"newGameCell" forIndexPath:indexPath];
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedGameCell" forIndexPath:indexPath];
    if ([savedGames count] > indexPath.row) {
        GameShowGame *savedGame = [savedGames objectAtIndex:indexPath.row];
        UIView *contentView = cell.subviews[0];
        [contentView.subviews[0] setText:[NSString stringWithFormat:@"%@", savedGame.description]];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *viewController = [segue destinationViewController];
    UITableViewCell *selectedCell = (UITableViewCell*)sender;
    
    NSArray *savedGamesArray = savedGames;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    if (indexPath.section > 0 && [savedGamesArray count] > indexPath.row) {
        viewController.jeopardyGame = [savedGamesArray objectAtIndex:(indexPath.row)];
    } else {
        viewController.jeopardyGame = [[GameShowGame alloc] init];
        [savedGames addObject:viewController.jeopardyGame];
    }
}


@end
