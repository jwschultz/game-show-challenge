//
//  UserAccountSelectionViewController.m
//  Game Show Challenge
//
//  Created by John Schultz on 4/9/15.
//  Copyright (c) 2015 Friends of Hektor. All rights reserved.
//

#import "UserAccountSelectionViewController.h"
#import <Parse/Parse.h>

@interface UserAccountSelectionViewController ()

@end

@implementation UserAccountSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signInToService:(UIButton *)sender {
    PFUser *user = [PFUser currentUser];
    
    if (![PFTwitterUtils isLinkedWithUser:user]) {
        [PFTwitterUtils linkUser:user block:^(BOOL succeeded, NSError *error) {
            if ([PFTwitterUtils isLinkedWithUser:user]) {
                NSLog(@"Woohoo, user logged in with Twitter!");
            }
        }];
    } else {
        [PFTwitterUtils logInWithBlock:^(PFUser *user, NSError *error) {
            if (!user) {
                NSLog(@"Uh oh. The user cancelled the Twitter login.");
                return;
            } else if (user.isNew) {
                NSLog(@"User signed up and logged in with Twitter!");
            } else {
                NSLog(@"User logged in with Twitter!");
            }
        }];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
