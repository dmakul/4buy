//
//  SignUpViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (strong, nonatomic) IBOutlet UITextField *loginTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *enterButton;

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


- (IBAction)exitButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];    
}
- (IBAction)enterButtonPressed:(UIButton *)sender {
    PFUser *user = [PFUser user];
    user.username = self.loginTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;
    
    if([self.loginTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Введите логин" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(self.loginTextField.text.length < 5){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Длина логина должна составлять больше 5 символов" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(![self NSStringIsValidEmail:self.emailTextField.text]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Введите корректный e-mail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if([self.passwordTextField.text isEqualToString:@""]){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Введите пароль" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(self.passwordTextField.text.length < 5){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Произошла ошибка" message:@"Длина пароля должна составлять больше 5 символов" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if(error.code == 202){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Данный логин уже занят" message:@"Пожалуйста, введите другой логин" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if(error.code == 203){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Данный e-mail уже занят" message:@"Пожалуйста, введите другой e-mail" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return;
        }
        
        if(succeeded){
            [self enterApp];
            NSLog(@"%@",user);
        }
        
    }];
}




#pragma mark- Helper methods

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
    
    if ([self.emailTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.emailTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"E-mail" attributes:@{NSForegroundColorAttributeName: color}];
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
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(25, 300, self.view.bounds.size.width-53, 0.3)];
    lineView3.backgroundColor = color;
    [self.view addSubview:lineView3];
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
