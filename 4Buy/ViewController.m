//
//  ViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *enterButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpScreen];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if([PFUser currentUser]){
        [self enterApp];
    }
}


#pragma mark - Helper methods

-(void)enterApp
{
    [self performSegueWithIdentifier:@"EnterAppFromLogIn" sender:nil];
}

- (IBAction)enterButtonPressed:(UIButton *)sender {
    
    [PFUser logInWithUsernameInBackground:self.loginTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self enterApp];
                                        } else {
                                            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Повторите заново" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                                            [alert show];
                                        }
                                    }];
    
}

-(void) setUpScreen
{
    UIColor *color = [UIColor whiteColor];
    self.passwordTextField.secureTextEntry = YES;
    
    if ([self.loginTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.loginTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Логин" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    if ([self.passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Пароль" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    [self.enterButton.layer setBorderColor:[color CGColor]];
    [self.enterButton.layer setBorderWidth:0.5];
    [self.enterButton.layer setCornerRadius:4];

    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(25, 220, self.view.bounds.size.width-53, 0.5)];
    lineView1.backgroundColor = color;
    [self.view addSubview:lineView1];
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(25, 260, self.view.bounds.size.width-53, 0.3)];
    lineView2.backgroundColor = color;
    [self.view addSubview:lineView2];
}

@end
