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

@end

@implementation AddListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AdButtonPressed:(UIBarButtonItem *)sender {
    List *list = [List new];
    list.name = self.nameTextField.text;
    list.color = [UIColor redColor];
    [self.delegate didAddList:list];
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
