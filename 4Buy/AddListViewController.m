//
//  AddListViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "AddListViewController.h"
#import "List.h"

@interface AddListViewController ()
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UIButton *redColorButton;
@property (strong, nonatomic) IBOutlet UIButton *blueColorButton;
@property (strong, nonatomic) IBOutlet UIButton *greenColorButton;
@property (strong, nonatomic) IBOutlet UIButton *yellowColorButton;
@property (strong, nonatomic) IBOutlet UIButton *orangeColorButton;
@property (strong, nonatomic) IBOutlet UIButton *blackColorButton;

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
    List *list = [List new];
    list.name = self.nameTextField.text;
    list.color = self.nameTextField.textColor;
    [self.delegate didAddList:list];
}

#pragma mark - color pick methods

- (IBAction)redButtonPressed:(UIButton *)sender {
    self.nameTextField.textColor = [UIColor redColor];
}
- (IBAction)blueButtonPressed:(UIButton *)sender {
    self.nameTextField.textColor = [UIColor blueColor];
}
- (IBAction)greenButtonPressed:(UIButton *)sender {
    UIColor* clr = [UIColor colorWithRed:0x29/255.0f
                                   green:0xC0/255.0f
                                    blue:0x62/255.0f alpha:1];
    self.nameTextField.textColor = clr;
}
- (IBAction)magentaButtonPressed:(UIButton *)sender {
    self.nameTextField.textColor = [UIColor magentaColor];
}
- (IBAction)orangeButtonPressed:(UIButton *)sender {
    self.nameTextField.textColor = [UIColor orangeColor];
}
- (IBAction)brownButtonPressed:(UIButton *)sender {
    self.nameTextField.textColor = [UIColor brownColor];
}

#pragma mark - Helper methods

-(void)addColor:(UIColor *)color forButton:(UIButton *)button
{
    [button.layer setCornerRadius:15];
    [button.layer setBorderColor:[color CGColor]];
    [button.layer setBorderWidth:1];
    [button setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button.layer setBackgroundColor:[color CGColor]];
    [button setAlpha:0.65];
}

-(void) setUpScreen
{
    UIColor* clr = [UIColor colorWithRed:0x29/255.0f
                                   green:0xC0/255.0f
                                    blue:0x62/255.0f alpha:1];
    [self addColor:[UIColor redColor] forButton:self.redColorButton];
    [self addColor:[UIColor blueColor] forButton:self.blueColorButton];
    [self addColor:clr forButton:self.greenColorButton];
    [self addColor:[UIColor magentaColor] forButton:self.yellowColorButton];
    [self addColor:[UIColor orangeColor] forButton:self.orangeColorButton];
    [self addColor:[UIColor brownColor] forButton:self.blackColorButton];
    
    
    
    UIColor *color = [UIColor grayColor];
    if ([self.nameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Введите название" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
        // TODO: Add fall-back code to set placeholder color.
    }
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(25, 130, self.view.bounds.size.width-53, 0.5)];
    lineView1.backgroundColor = color;
    [self.view addSubview:lineView1];
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
