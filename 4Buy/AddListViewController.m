//
//  AddListViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "AddListViewController.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <FlatUIKit/FlatUIKit.h>
#import <Parse/Parse.h>
#import <Masonry/Masonry.h>
#import <ChameleonFramework/Chameleon.h>


@interface AddListViewController ()

@property (nonatomic) FUIButton *firstButton;
@property (nonatomic) FUIButton *secondButton;
@property (nonatomic) FUIButton *thirdButton;
@property (nonatomic) FUIButton *fourthButton;
@property (nonatomic) FUIButton *fifthButton;
@property (nonatomic) FUIButton *sixthButton;

@property (nonatomic) NSString *selectedColor;

@property (nonatomic) UILabel *borderLabel;
@property (nonatomic) FUITextField * nameTextField;

@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AdButtonPressed:(UIBarButtonItem *)sender {
    PFObject *list = [PFObject objectWithClassName:@"List"];
    list[@"name"] = self.nameTextField.text;
    list[@"userId"] = [PFUser currentUser];
    if(self.selectedColor)  list[@"color"] = self.selectedColor; else list[@"color"] = @"000000";
    [list saveInBackground];
    //list.products = [NSMutableArray new];
    [self.delegate didAddList:list];
}

#pragma mark - color pick methods

-(void) firstButtonPressed {
    self.selectedColor = @"#3498DB";
    [self.borderLabel.layer setBorderColor:[[UIColor peterRiverColor] CGColor]];
}

-(void) secondButtonPressed {
    self.selectedColor = @"#90745B";
    [self.borderLabel.layer setBorderColor:[[UIColor flatCoffeeColor] CGColor]];
}

-(void) thirdButtonPressed {
    self.selectedColor = @"#f1c40f";
    [self.borderLabel.layer setBorderColor:[[UIColor sunflowerColor] CGColor]];
}

-(void) fourthButtonPressed {
    self.selectedColor = @"#e74c3c";
    [self.borderLabel.layer setBorderColor:[[UIColor alizarinColor] CGColor]];
}

-(void) fifthButtonPressed {
    self.selectedColor = @"#853DAE";
    [self.borderLabel.layer setBorderColor:[[UIColor flatMagentaColor] CGColor]];
}

-(void) sixthButtonPressed {
    self.selectedColor = @"#E960BB";
    [self.borderLabel.layer setBorderColor:[[UIColor flatPinkColor] CGColor]];
}


#pragma mark - Helper methods

-(void) setUpScreen
{
    
    self.nameTextField = [[FUITextField alloc] init];
//    [self.nameTextField becomeFirstResponder];
    self.nameTextField.placeholder = @"Введите название списка";
    self.selectedColor = @"#2ecc71";
    self.nameTextField.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    self.nameTextField.backgroundColor = [UIColor clearColor];
    self.nameTextField.textFieldColor = [UIColor whiteColor];
    self.nameTextField.textColor = [UIColor flatBlackColor];
    self.nameTextField.borderColor = [UIColor clearColor];
    self.nameTextField.borderWidth = 0;
    self.nameTextField.cornerRadius = 3.0f;
    

    
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, 10, 20)];
    self.nameTextField.leftView = paddingView;
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [self.view addSubview:self.nameTextField];
    [self.nameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    self.borderLabel = [[UILabel alloc]init];
    [self.borderLabel.layer setBorderColor:[[UIColor emerlandColor]CGColor]];
    [self.borderLabel.layer setBorderWidth:1.8f];
    [self.borderLabel.layer setCornerRadius:3.0f];
    
    [self.view addSubview:self.borderLabel];
    [self.borderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(80);
        make.centerX.equalTo(self.view.mas_centerX);
        make.height.mas_equalTo(self.view.frame.size.height / 15);
        make.width.mas_equalTo(self.view.frame.size.width - 30);
    }];
    
    self.firstButton = [[FUIButton alloc]init];
    self.firstButton.buttonColor = [UIColor peterRiverColor];
    self.firstButton.shadowColor = [UIColor belizeHoleColor];
    self.firstButton.shadowHeight = 6.0f;
    self.firstButton.cornerRadius = self.view.frame.size.width / 10;
    self.firstButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.firstButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.firstButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.view addSubview:self.firstButton];
    
    [self.firstButton addTarget:self action:@selector(firstButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    int margin_left = self.view.frame.size.width / 7.65;
    
    [self.firstButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
    }];
    
    self.secondButton = [[FUIButton alloc]init];
    self.secondButton.buttonColor = [UIColor flatCoffeeColor];
    self.secondButton.shadowColor = [UIColor flatCoffeeColorDark];
    self.secondButton.shadowHeight = 6.0f;
    self.secondButton.cornerRadius = self.view.frame.size.width / 10;
    self.secondButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.secondButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.secondButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.secondButton addTarget:self action:@selector(secondButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.secondButton];
    
    [self.secondButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left * 2);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
    }];
    
    self.thirdButton = [[FUIButton alloc]init];
    self.thirdButton.buttonColor = [UIColor sunflowerColor];
    self.thirdButton.shadowColor = [UIColor flatYellowColorDark];
    self.thirdButton.shadowHeight = 6.0f;
    self.thirdButton.cornerRadius = self.view.frame.size.width / 10;
    self.thirdButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.thirdButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.thirdButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.thirdButton addTarget:self action:@selector(thirdButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.thirdButton];
    
    [self.thirdButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left * 3);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
    }];
    
    self.fourthButton = [[FUIButton alloc]init];
    self.fourthButton.buttonColor = [UIColor alizarinColor];
    self.fourthButton.shadowColor = [UIColor pomegranateColor];
    self.fourthButton.shadowHeight = 6.0f;
    self.fourthButton.cornerRadius = self.view.frame.size.width / 10;
    self.fourthButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.fourthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.fourthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.fourthButton addTarget:self action:@selector(fourthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.fourthButton];
    
    [self.fourthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left * 4);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
    }];
    
    self.fifthButton = [[FUIButton alloc]init];
    self.fifthButton.buttonColor = [UIColor flatMagentaColor];
    self.fifthButton.shadowColor = [UIColor flatMagentaColorDark];
    self.fifthButton.shadowHeight = 6.0f;
    self.fifthButton.cornerRadius = self.view.frame.size.width / 10;
    self.fifthButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.fifthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.fifthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.fifthButton addTarget:self action:@selector(fifthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.fifthButton];
    
    [self.fifthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left * 5);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
    }];
    
    self.sixthButton = [[FUIButton alloc]init];
    self.sixthButton.buttonColor = [UIColor flatPinkColor];
    self.sixthButton.shadowColor = [UIColor flatPinkColorDark];
    self.sixthButton.shadowHeight = 6.0f;
    self.sixthButton.cornerRadius = self.view.frame.size.width / 10;
    self.sixthButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.sixthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.sixthButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [self.sixthButton addTarget:self action:@selector(sixthButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.sixthButton];
    
    [self.sixthButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
        make.left.mas_equalTo(margin_left * 6);
        make.width.mas_equalTo(self.view.frame.size.width / 9.5);
        make.height.mas_equalTo(self.view.frame.size.height / 17);
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
