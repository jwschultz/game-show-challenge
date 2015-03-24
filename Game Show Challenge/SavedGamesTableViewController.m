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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    if (indexPath == 0) {
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"savedGameCell" forIndexPath:indexPath];
    if ([savedGames count] > indexPath.row - 1) {
        GameShowGame *savedGame = [savedGames objectAtIndex:indexPath.row - 1];
    
        [cell.textLabel setText:[NSString stringWithFormat:@"%@", savedGame.description]];
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
