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
    PFUser *currentUser = [PFUser currentUser];
    NSLog(@"%@", [currentUser objectForKey:@"authData"]);
    
    if ([PFTwitterUtils isLinkedWithUser:currentUser]) {
        
    }
    
    [PFTwitterUtils linkUser:currentUser block:^(BOOL succeeded, NSError *error) {
        NSLog(@"Succeeded = %i", succeeded);
    }];
}
- (IBAction)signOutOfService:(id)sender {
    PFUser *user = [PFUser currentUser];
    [PFTwitterUtils unlinkUserInBackground:user block:^(BOOL succeeded, NSError *error) {
        if (!error && succeeded) {
            NSLog(@"The user is no longer associated with their Twitter account.");
        }
    }];
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
