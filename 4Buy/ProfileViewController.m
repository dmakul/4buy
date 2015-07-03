//
//  ProfileViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "AppDelegate.h"

@interface ProfileViewController ()
@property (strong, nonatomic) IBOutlet UIButton *logOutButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutButtonPressed:(UIButton *)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate logout];
    }];    
}




#pragma mark - Helper methods

-(void) setUpScreen
{
    [self.logOutButton.layer setBorderColor:[[UIColor redColor]CGColor]];
    [self.logOutButton.layer setBorderWidth:0.5];
    [self.logOutButton.layer setCornerRadius:4];
    
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
