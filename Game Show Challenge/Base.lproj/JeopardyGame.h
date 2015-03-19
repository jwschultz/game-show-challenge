//
//  JeopardyGame.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/18/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JeopardyGame : NSObject

@property (strong, nonatomic) NSString *playerName;

@property NSInteger playerScore;
@property NSInteger nextValue;

@property (strong, nonatomic) NSDictionary *pastValues;


@end
