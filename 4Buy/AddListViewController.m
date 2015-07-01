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
@property (nonatomic) UIColor *clr;
@property (nonatomic) UIColor *clr2;
@property (nonatomic) UIColor *selectedColor;

@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clr2 = [UIColor colorWithRed:0x47/255.0f
                               green:0x98/255.0f
                                blue:0xFF/255.0f alpha:1];
    
    self.clr = [UIColor colorWithRed:0x29/255.0f
                                   green:0xC0/255.0f
                                    blue:0x62/255.0f alpha:1];

    
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
    if(self.selectedColor)  list.color = self.selectedColor; else list.color = [UIColor blackColor];
    [self.delegate didAddList:list];
}

#pragma mark - color pick methods

- (IBAction)redButtonPressed:(UIButton *)sender {
    self.selectedColor = [UIColor redColor];
    [self.redColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.redColorButton.layer setBorderWidth:3.2];
    [self.blueColorButton.layer setBorderColor:[self.clr2 CGColor]];
    [self.greenColorButton.layer setBorderColor:[self.clr CGColor]];
    [self.yellowColorButton.layer setBorderColor:[[UIColor magentaColor] CGColor]];
    [self.orangeColorButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [self.blackColorButton.layer setBorderColor:[[UIColor brownColor] CGColor]];
}
- (IBAction)blueButtonPressed:(UIButton *)sender {
    self.selectedColor = self.clr2;
    [self.blueColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.blueColorButton.layer setBorderWidth:3.2];
    [self.redColorButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.greenColorButton.layer setBorderColor:[self.clr CGColor]];
    [self.yellowColorButton.layer setBorderColor:[[UIColor magentaColor] CGColor]];
    [self.orangeColorButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [self.blackColorButton.layer setBorderColor:[[UIColor brownColor] CGColor]];
}
- (IBAction)greenButtonPressed:(UIButton *)sender {
    self.selectedColor = self.clr;
    [self.greenColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.greenColorButton.layer setBorderWidth:3.2];
    [self.redColorButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.blueColorButton.layer setBorderColor:[self.clr2 CGColor]];
    [self.yellowColorButton.layer setBorderColor:[[UIColor magentaColor] CGColor]];
    [self.orangeColorButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [self.blackColorButton.layer setBorderColor:[[UIColor brownColor] CGColor]];
}
- (IBAction)magentaButtonPressed:(UIButton *)sender {
    self.selectedColor = [UIColor magentaColor];
    [self.yellowColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.yellowColorButton.layer setBorderWidth:3.2];
    [self.redColorButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.blueColorButton.layer setBorderColor:[self.clr2 CGColor]];
    [self.greenColorButton.layer setBorderColor:[self.clr CGColor]];
    [self.orangeColorButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [self.blackColorButton.layer setBorderColor:[[UIColor brownColor] CGColor]];
}

- (IBAction)orangeButtonPressed:(UIButton *)sender {
    self.selectedColor = [UIColor orangeColor];
    [self.orangeColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.orangeColorButton.layer setBorderWidth:3.2];
    [self.redColorButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.blueColorButton.layer setBorderColor:[self.clr2 CGColor]];
    [self.greenColorButton.layer setBorderColor:[self.clr CGColor]];
    [self.yellowColorButton.layer setBorderColor:[[UIColor magentaColor] CGColor]];
    [self.blackColorButton.layer setBorderColor:[[UIColor brownColor] CGColor]];
}
- (IBAction)brownButtonPressed:(UIButton *)sender {
    self.selectedColor = [UIColor brownColor];
    [self.blackColorButton.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [self.blackColorButton.layer setBorderWidth:3.2];
    [self.redColorButton.layer setBorderColor:[[UIColor redColor] CGColor]];
    [self.blueColorButton.layer setBorderColor:[self.clr2 CGColor]];
    [self.greenColorButton.layer setBorderColor:[self.clr CGColor]];
    [self.yellowColorButton.layer setBorderColor:[[UIColor magentaColor] CGColor]];
    [self.orangeColorButton.layer setBorderColor:[[UIColor orangeColor] CGColor]];

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
    [self addColor:[UIColor redColor] forButton:self.redColorButton];
    [self addColor:self.clr2 forButton:self.blueColorButton];
    [self addColor:self.clr forButton:self.greenColorButton];
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
