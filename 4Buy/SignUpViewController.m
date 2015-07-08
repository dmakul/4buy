//
//  SignUpViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "SignUpViewController.h"
#import <Masonry/Masonry.h>
#import <FlatUIKit/FlatUIKit.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <ChameleonFramework/Chameleon.h>
#import <Parse/Parse.h>
#import <SCLAlertView_Objective_C/SCLAlertView.h>

@interface SignUpViewController ()

@property (nonatomic) FUITextField *loginTextField;
@property (nonatomic) FUITextField *passwordTextField;
@property (nonatomic) FUITextField *emailTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //[self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark- Helper methods

-(void) enterButtonPressed {
    PFUser *user = [PFUser user];
    user.username = self.loginTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;
    
    if([self.loginTextField.text isEqualToString:@""]){
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:16.0f];
        [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
        [alert showError:self title:@"Введите логин" subTitle:@"" closeButtonTitle:@"OK" duration:0.0f]; // Error
        return;
    }
    
    if(self.loginTextField.text.length < 4){
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
        [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
        [alert showError:self title:@"" subTitle:@"Длина логина должна составлять больше 3 символов" closeButtonTitle:@"OK" duration:0.0f]; // Error
        return;
    }
    
    if(![self NSStringIsValidEmail:self.emailTextField.text]){
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
        [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
        [alert showError:self title:@"Введите корректный e-mail" subTitle:@"" closeButtonTitle:@"OK" duration:0.0f]; // Error
        return;
    }
    
    if([self.passwordTextField.text isEqualToString:@""]){
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
        [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
        [alert showError:self title:@"Введите пароль" subTitle:@"" closeButtonTitle:@"OK" duration:0.0f]; // Error

        return;
    }
    
    if(self.passwordTextField.text.length < 5){
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
        [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:14.0f];
        [alert showError:self title:@"" subTitle:@"Длина пароля должна составлять больше 4 символов" closeButtonTitle:@"OK" duration:0.0f]; // Error
        return;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error.code == 202){
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
            [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:13.0f];
            [alert showError:self title:@"Данный логин уже занят" subTitle:@"Пожалуйста, введите другой логин" closeButtonTitle:@"OK" duration:0.0f]; // Error

            return;
        }
        
        if(error.code == 203){
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert setTitleFontFamily:@"HelveticaNeue-Light" withSize:15.0f];
            [alert setBodyTextFontFamily:@"HelveticaNeue-Light" withSize:13.0f];
            [alert showError:self title:@"Данный e-mail уже занят" subTitle:@"Пожалуйста, введите другой e-mail" closeButtonTitle:@"OK" duration:0.0f]; // Error

            return;
        }
        
        if(succeeded){
            [self enterApp];
        }
        
    }];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void) enterApp
{
    [self performSegueWithIdentifier:@"EnterAppFromSignUp" sender:nil];
}

-(void) exitButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];  
}

-(void) setUpScreen {
    [self.view setBackgroundColor:[UIColor emerlandColor]];
    
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
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.textColor = [UIColor wetAsphaltColor];
    self.passwordTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.passwordTextField.backgroundColor = [UIColor clearColor];
    self.passwordTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.passwordTextField.textFieldColor = [UIColor whiteColor];
    self.passwordTextField.borderColor = [UIColor emerlandColor];
    self.passwordTextField.borderWidth = 0;
    [self.passwordTextField setBorderStyle:UITextBorderStyleNone];
    self.passwordTextField.cornerRadius = 3.0f;
    self.passwordTextField.placeholder = @"Введите пароль";
    
    [self.view addSubview:self.passwordTextField];
    
    [self.passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginTextField.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    self.emailTextField = [[FUITextField alloc]init];
    self.emailTextField.textColor = [UIColor wetAsphaltColor];
    self.emailTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.emailTextField.backgroundColor = [UIColor clearColor];
    self.emailTextField.edgeInsets = UIEdgeInsetsMake(4.0f, 15.0f, 4.0f, 15.0f);
    self.emailTextField.textFieldColor = [UIColor whiteColor];
    self.emailTextField.borderColor = [UIColor emerlandColor];
    self.emailTextField.borderWidth = 0;
    [self.emailTextField setBorderStyle:UITextBorderStyleNone];
    self.emailTextField.cornerRadius = 3.0f;
    self.emailTextField.placeholder = @"Введите email";
    
    [self.view addSubview:self.emailTextField];
    
    [self.emailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextField.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    FUIButton *enterButton = [[FUIButton alloc]init];
    enterButton.buttonColor = [UIColor flatWhiteColor];
    enterButton.shadowColor = [UIColor flatGrayColorDark];
    enterButton.shadowHeight = 3.0f;
    enterButton.cornerRadius = 6.0f;
    [enterButton setTitle:@"Начать" forState:UIControlStateNormal];
    enterButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f];
    [enterButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateNormal];
    [enterButton setTitleColor:[UIColor emerlandColor] forState:UIControlStateHighlighted];
    [enterButton addTarget:self action:@selector(enterButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enterButton];
    
    [enterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.emailTextField.mas_bottom).with.offset(30);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    

 
    
    FUIButton *createAccountButton = [[FUIButton alloc]init];
    createAccountButton.buttonColor = [UIColor clearColor];
    createAccountButton.shadowColor = [UIColor clearColor];
    createAccountButton.shadowHeight = 3.0f;
    createAccountButton.cornerRadius = 6.0f;
    [createAccountButton setTitle:@"Уже есть аккаунт?" forState:UIControlStateNormal];
    createAccountButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f];
    [createAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [createAccountButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [createAccountButton addTarget:self action:@selector(exitButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:createAccountButton];
    
    [createAccountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(enterButton.mas_bottom).with.offset(80);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
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
