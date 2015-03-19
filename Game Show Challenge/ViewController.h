//
//  ViewController.h
//  Game Show Challenge
//
//  Created by John Schultz on 3/14/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JeopardyGame;

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *clueValues;
@property (strong, nonatomic) JeopardyGame *jeopardyGame;

@end

