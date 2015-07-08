//
//  EditViewController.m
//  4Buy
//
//  Created by Даурен Макул on 08.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "EditViewController.h"
#import <FlatUIKit/FlatUIKit.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>
#import <Parse/Parse.h>

@interface EditViewController ()

@property (nonatomic) FUITextField *nameTextField;
@property (nonatomic) FUITextField *amountTextField;


@end


@implementation EditViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    PFObject *product = [PFObject new];
    product[@"name"] = self.nameTextField.text;
    product[@"listId"] = self.list;
    product[@"amount"] = self.amountTextField.text;
    product[@"isDone"] = self.product[@"isDone"];
    [product saveInBackground];
    
    [self.delegate didEditProduct:product];
}


#pragma mark - Helper methods

-(void) setUpScreen {
    
    self.nameTextField = [[FUITextField alloc]init];
    self.nameTextField.text = self.product[@"name"];
    self.nameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.nameTextField.backgroundColor = [UIColor clearColor];
    self.nameTextField.textFieldColor = [UIColor whiteColor];
    self.nameTextField.textColor = [UIColor flatBlackColor];
    self.nameTextField.borderColor = [UIColor emerlandColor];
    self.nameTextField.borderWidth = 1.8f;
    self.nameTextField.cornerRadius = 3.0f;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 10, 20)];
    self.nameTextField.leftView = paddingView;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.nameTextField];
    
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(75);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    self.amountTextField = [[FUITextField alloc]init];
    self.amountTextField.text = self.product[@"amount"];
    self.amountTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.amountTextField.backgroundColor = [UIColor clearColor];
    self.amountTextField.textFieldColor = [UIColor whiteColor];
    self.amountTextField.textColor = [UIColor flatBlackColor];
    self.amountTextField.borderColor = [UIColor emerlandColor];
    self.amountTextField.borderWidth = 1.8f;
    self.amountTextField.cornerRadius = 3.0f;
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 10, 20)];
    self.amountTextField.leftView = paddingView1;
    self.amountTextField.leftViewMode = UITextFieldViewModeAlways;
    [self.view addSubview:self.amountTextField];
    
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(115);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
}


@end
