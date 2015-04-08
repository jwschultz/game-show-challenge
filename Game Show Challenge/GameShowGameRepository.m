//
//  GameShowGameRepository.m
//  Game Show Challenge
//
//  Created by John Schultz on 4/6/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowGameRepository.h"
#import "GameShowGame.h"
#import <Parse/Parse.h>

@implementation GameShowGameRepository

+ (void)findGamesForCurrentUserWithBlock:(void (^)(NSArray *))block {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [PFQuery queryWithClassName:@"GameShowGame"];
    [query whereKey:@"user" equalTo:user];
    if (user.objectId) {
        [query findObjectsInBackgroundWithBlock:^(NSArray *gameShowGames, NSError *error) {
            NSMutableArray *theGames = [NSMutableArray arrayWithCapacity:[gameShowGames count]];
            for (PFObject *gameObject in gameShowGames) {
                GameShowGame *game = [[GameShowGame alloc] initWithObject:gameObject];
                [theGames addObject:game];
            }
            block(theGames);
        }];
    }

}

+ (void)saveGame:(GameShowGame *)game {
    PFObject *gameObject = [game asPFObject];
    game.persisted = YES;

    [gameObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            game.parseObjectId = gameObject.objectId;
        } else {
            NSLog(@"There was an error: %@", error);
        }
    }];

}


@end
