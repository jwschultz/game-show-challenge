//
//  SavedGamesTableViewController.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/23/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameShowGame;

@interface SavedGamesTableViewController : UITableViewController

@property (strong, nonatomic) GameShowGame *jeopardyGame;

@end