//
//  FriendListViewController.m
//  4Buy
//
//  Created by Даурен Макул on 03.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "FriendListViewController.h"

@interface FriendListViewController () <UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray  *friends;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;


@end



@implementation FriendListViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.friends = [NSMutableArray new];
    
    
    [self setUpScreen];
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
        if(self.tableView.editing) {
            self.navigationItem.leftBarButtonItem.title = @"Изменить";
            [self.tableView setEditing:NO animated:YES];
        } else{
            self.editButton.title = @"Готово";
            [self.tableView setEditing:YES animated:YES];
        }
    
}

#pragma mark - TableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Test";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadData];
    }
    
  
}

#pragma mark - Helper methods

-(void) setUpScreen
{
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.title = @"Мои друзья";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

@end
