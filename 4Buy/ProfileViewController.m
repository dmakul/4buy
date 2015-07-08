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
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <FlatUIKit/NSString+Icons.h>
#import <FlatUIKit/FlatUIKit.h>
#import <ChameleonFramework/Chameleon.h>
#import <Masonry/Masonry.h>



@interface ProfileViewController ()

@property (nonatomic) FUIButton *logOutButton;

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

#pragma mark - Selectors

-(void) logOutButtonPressed {
    [PFUser logOutInBackgroundWithBlock:^(NSError *error){
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        [delegate logout];
    }];
}


#pragma mark - Helper methods

-(void) setUpScreen{
    
    [self logOutButtonAdded];
    
}


-(void) logOutButtonAdded {
    
    self.logOutButton = [[FUIButton alloc] init];
    self.logOutButton.buttonColor = [UIColor emerlandColor];
    self.logOutButton.shadowColor = [UIColor nephritisColor];
    self.logOutButton.shadowHeight = 3.0f;
    self.logOutButton.cornerRadius = 5.0f;
    self.logOutButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17.0f];
    [self.logOutButton setTitle:@"Выйти с аккаунта" forState:UIControlStateNormal];
    [self.logOutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.logOutButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:self.logOutButton];
    
    [self.logOutButton addTarget:self action:@selector(logOutButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.logOutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-55);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.left.mas_equalTo(10);
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
