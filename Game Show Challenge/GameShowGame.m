//
//  GameShowGame.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/19/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowGame.h"
#import <Parse/Parse.h>

@implementation GameShowGame

- (GameShowGame *)init {
    self.persisted = NO;
    self.airDate = [NSDate dateWithTimeIntervalSinceNow:0];
    return self;
}

- (GameShowGame *)initWithObject:(PFObject *)pfObject {
    self.playerScore = [[pfObject objectForKey:@"playerScore"] longValue];
    self.gameDescription = [pfObject objectForKey:@"gameDescription"];
    self.gameType = [[pfObject objectForKey:@"gameType"] longValue];
    self.airDate = [pfObject objectForKey:@"airDate"];
    if (!self.airDate) {
        self.airDate = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    self.parseObjectId = pfObject.objectId;
    self.persisted = YES;

    return self;
}

- (PFObject *)asPFObject {
    PFObject *gameObject;
    gameObject = [PFObject objectWithClassName:@"GameShowGame"];
    
    if (self.parseObjectId) {
        gameObject.objectId = self.parseObjectId;
    }
    [gameObject setValue:[NSNumber numberWithLong:self.playerScore] forKey:@"playerScore"];
    [gameObject setValue:self.gameDescription forKey:@"gameDescription"];
    [gameObject setValue:[NSNumber numberWithLong:self.gameType] forKey:@"gameType"];
    [gameObject setValue:self.airDate forKey:@"airDate"];
    gameObject[@"user"] = [PFUser currentUser];
    
    return gameObject;
}

@end
