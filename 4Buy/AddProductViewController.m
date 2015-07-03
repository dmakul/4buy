//
//  AddProductViewController.m
//  4Buy
//
//  Created by Даурен Макул on 01.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "AddProductViewController.h"
#import <Parse/Parse.h>

@interface AddProductViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *numberPickerView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;

@property (strong, nonatomic) IBOutlet UITextField *amountTextField;
@property (nonatomic) NSMutableArray *number;
@property (nonatomic) NSArray *type;

@end

@implementation AddProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.number = [NSMutableArray new];
    for(int i=1;i<=100;i++){
        id var = [NSNumber numberWithInt:i];
        [self.number addObject:var];
    }
    
    [self.numberPickerView selectRow:20000 inComponent:0 animated:NO];
    [self.numberPickerView selectRow:2 inComponent:1 animated:NO];
    
    self.type = @[@"Бутылка", @"Литр", @"Кг", @"Упаковка", @"Коробка"];
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addButtonPressed:(UIBarButtonItem *)sender {
    
    PFObject *product = [PFObject objectWithClassName:@"ProductList"];
    product[@"name"] = self.nameTextField.text;
    product[@"listId"] = self.list;
    product[@"amount"] = self.amountTextField.text;
    product[@"isDone"] = @(NO);
    [product saveInBackground];
    
    
    [self.delegate didAddProduct:product];
}



#pragma mark - PickerView Delegate Methods



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0){
        return INT16_MAX;
    } else
        if(component == 1){
            return 5;
        } else return 0;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0){
        row = row % self.number.count;
        NSString *str = [NSString stringWithFormat:@"%@",self.number[row]];
        return str;
    } else
    if(component == 1){
        return self.type[row];
    } else
        return nil;
}

#pragma mark - Helper methods

-(void) setUpScreen
{
    UIColor *color = [UIColor grayColor];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(25, 155, self.view.bounds.size.width-53, 0.5)];
    lineView2.backgroundColor = color;
    lineView2.alpha = 0.7;
    [self.view addSubview:lineView2];

    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(25, 110, self.view.bounds.size.width-53, 0.5)];
    lineView1.backgroundColor = color;
    lineView1.alpha = 0.7;
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
