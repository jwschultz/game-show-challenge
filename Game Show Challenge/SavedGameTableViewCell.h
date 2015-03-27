//
//  SavedGameTableViewCell.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/27/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GameShowGame;

@interface SavedGameTableViewCell : UITableViewCell

@property (weak, nonatomic) GameShowGame *game;

@end
