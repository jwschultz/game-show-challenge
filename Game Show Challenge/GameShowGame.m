//
//  GameShowGame.m
//  Game Show Challenge
//
//  Created by John Schultz on 3/19/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "GameShowGame.h"

@implementation GameShowGame

- (GameShowGame *)init {
    self.persisted = NO;
    self.airDate = [NSDate dateWithTimeIntervalSinceNow:0];
    return self;
}

@end
