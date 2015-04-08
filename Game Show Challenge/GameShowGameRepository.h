//
//  GameShowGameRepository.h
//  Game Show Challenge
//
//  Created by John Schultz on 4/6/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameShowGame;

@interface GameShowGameRepository : NSObject

+ (void)findGamesForCurrentUserWithBlock:(void(^)(NSArray *gamesArray)) block;
+ (void)saveGame:(GameShowGame*)game;


@end
