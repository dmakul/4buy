//
//  ViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ChameleonFramework/Chameleon.h>
#import <FlatUIKit/FlatUIKit.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <Masonry/Masonry.h>
#import <SCLAlertView_Objective_C/SCLAlertView.h>

@interface ViewController ()

@property (nonatomic) FUITextField *loginTextField;
@property (nonatomic) FUITextField *passwordTextField;


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

-(void)enterButtonPressed {
    [PFUser logInWithUsernameInBackground:self.loginTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            [self enterApp];
                                        } else {
                                            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                                            alert.backgroundType = Shadow;
                                            [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
                                            [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
                                            [alert showError:self title:@"Неверный логин или пароль" subTitle:@"Повторите еще раз" closeButtonTitle:@"OK" duration:0.0f]; // Error
                                        }
                                    }];
}

-(void) resetButtonPressed {
    
}


-(void) createAccountButtonPressed {
    [self performSegueWithIdentifier:@"createAccount" sender:self];
}

-(void) setUpScreen
{
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.text = @"4Buy";
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:50.0f];
    nameLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UILabel *enterLabel = [[UILabel alloc]init];
    enterLabel.text = @"Войдите в свой аккаунт";
    enterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f];
    enterLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:enterLabel];
    
    [enterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    [self.view setBackgroundColor:[UIColor emerlandColor]];
    
    self.loginTextField = [[FUITextField alloc]init];
    self.loginTextField.textColor = [UIColor wetAsphaltColor];
    self.loginTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.loginTextField.backgroundColor = [UIColor clearColor];
    self.loginTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.loginTextField.textFieldColor = [UIColor whiteColor];
    self.loginTextField.borderColor = [UIColor emerlandColor];
    self.loginTextField.borderWidth = 0;
    [self.loginTextField setBorderStyle:UITextBorderStyleNone];
    self.loginTextField.cornerRadius = 3.0f;
    self.loginTextField.placeholder = @"Введите логин";
    
    [self.view addSubview:self.loginTextField];
    
    [self.loginTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(enterLabel.mas_bottom).with.offset(65);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    self.passwordTextField = [[FUITextField alloc]init];
    self.passwordTextField.textColor = [UIColor wetAsphaltColor];
    self.passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.passwordTextField.textFieldColor = [UIColor whiteColor];
    self.passwordTextField.borderColor = [UIColor emerlandColor];
    self.passwordTextField.borderWidth = 0;
    [self.passwordTextField setBorderStyle:UITextBorderStyleNone];
    self.passwordTextField.cornerRadius = 3.0f;
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.placeholder = @"Введите пароль";
    
    [self.view addSubview:self.passwordTextField];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTextField.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    FUIButton *enterButton = [[FUIButton alloc]init];
    enterButton.buttonColor = [UIColor flatWhiteColor];
    enterButton.shadowColor = [UIColor flatGrayColorDark];
    enterButton.shadowHeight = 3.0f;
    enterButton.cornerRadius = 6.0f;
    [enterButton setTitle:@"Войти" forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [enterButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateHighlighted];
    [enterButton addTarget:self action:@selector(enterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    
    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    
    FUIButton *resetPassword = [[FUIButton alloc]init];
    resetPassword.buttonColor = [UIColor clearColor];
    resetPassword.shadowColor = [UIColor clearColor];
    resetPassword.shadowHeight = 3.0f;
    resetPassword.cornerRadius = 6.0f;
    [resetPassword setTitle:@"Забыли пароль?" forState:UIControlStateNormal];
    resetPassword.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f];
    [resetPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetPassword setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [resetPassword addTarget:self action:@selector(resetButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPassword];
    
    [resetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(enterButton.mas_bottom).with.offset(80);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    
    FUIButton *createAccountButton = [[FUIButton alloc]init];
    createAccountButton.buttonColor = [UIColor clearColor];
    createAccountButton.shadowColor = [UIColor clearColor];
    createAccountButton.shadowHeight = 3.0f;
    createAccountButton.cornerRadius = 6.0f;
    [createAccountButton setTitle:@"Создать аккаунт" forState:UIControlStateNormal];
    createAccountButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f];
    [createAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [createAccountButton addTarget:self action:@selector(createAccountButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createAccountButton];
    
    [createAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(resetPassword.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
}

@end
