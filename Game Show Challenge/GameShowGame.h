//
//  GameShowGame.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/19/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PFObject;

@interface GameShowGame : NSObject

@property (strong, nonatomic) NSString *playerName;

@property (strong, nonatomic) NSString *gameDescription;
@property NSInteger playerScore;
@property NSInteger nextValue;
@property NSInteger gameType;
@property BOOL persisted;

@property (strong, nonatomic) NSDictionary *pastValues;
@property (strong, nonatomic) NSString *parseObjectId;
@property (strong, nonatomic) NSDate *airDate;

- (GameShowGame *)initWithObject:(PFObject*)pfObject;
- (PFObject *)asPFObject;

@end
