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
#import <Parse/Parse.h>

@interface SavedGamesTableViewController ()

@property (strong, nonatomic) GameShowGame *jeopardyGame;
@property (strong, nonatomic) NSArray *savedGames;

@end

@implementation SavedGamesTableViewController

//static NSMutableArray *savedGames;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.savedGames == nil) {
        self.savedGames = [NSMutableArray arrayWithCapacity:50];
    }
    
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"GameShowGame"];
    [query whereKey:@"user" equalTo:user];
    if (user.objectId) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *gameShowGames, NSError *error) {
            NSMutableArray *theGames = [NSMutableArray arrayWithCapacity:[gameShowGames count]];
            for (PFObject *gameObject in gameShowGames) {
                GameShowGame *game = [[GameShowGame alloc] init];
                game.playerScore = [[gameObject objectForKey:@"playerScore"] longValue];
                game.gameDescription = [gameObject objectForKey:@"gameDescription"];
                game.parseObjectId = gameObject.objectId;
                game.persisted = YES;
                [theGames addObject:game];
            }
            self.savedGames = [NSArray arrayWithArray:theGames];
            [self.tableView reloadData];
        }];
    }

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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedGameCell" forIndexPath:indexPath];
    if ([self.savedGames count] > indexPath.row) {
        GameShowGame *savedGame = [self.savedGames objectAtIndex:indexPath.row];
        UIView *contentView = cell.subviews[0];
        [contentView.subviews[0] setText:[NSString stringWithFormat:@"%@", savedGame.gameDescription]];
    }
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *viewController = [segue destinationViewController];
    UITableViewCell *selectedCell = (UITableViewCell*)sender;
    
    NSArray *savedGamesArray = self.savedGames;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:selectedCell];
    if (indexPath.section > 0 && [savedGamesArray count] > indexPath.row) {
        viewController.jeopardyGame = [savedGamesArray objectAtIndex:(indexPath.row)];
    } else {
        viewController.jeopardyGame = [[GameShowGame alloc] init];
//        [self.s addObject:viewController.jeopardyGame];
    }
}


@end
