//
//  FriendListViewController.m
//  4Buy
//
//  Created by Даурен Макул on 03.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "FriendListViewController.h"
#import <Parse/Parse.h>
#import "TableViewCell3.h"
#import <FlatUIKit/FlatUIKit.h>
#import <ChameleonFramework/Chameleon.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SCLAlertView_Objective_C/SCLAlertView.h>
#import <SCLAlertView_Objective_C/SCLButton.h>

@interface FriendListViewController () <UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray  *friends;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addFriendButton;


@end



@implementation FriendListViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.friends = [NSMutableArray new];
    
    [self downloadFriendList];
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
- (IBAction)addFriendButtonPressed:(UIBarButtonItem *)sender {
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    UITextField *textField = [alert addTextField:@""];
    textField.textColor = [UIColor wetAsphaltColor];

    
    [alert addButton:@"Добавить" actionBlock:^{
        NSString *username = textField.text;
        
        PFQuery *query = [PFUser query];
        [query whereKey:@"username" equalTo:username];
        [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error){
            if(!error){
                PFUser *user = (PFUser *)object;
                [self addFriend:user];
                [self.friends addObject:user];
                [self.tableView reloadData];
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Данного пользователя не существует" message:@"Введите логин заново" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                [alert show];
            }
        }];
    }];
                                                                
    [alert showCustom:[UIImage imageNamed:@"friend.png"] color:[UIColor emerlandColor] title:@"Добавить друга" subTitle:@"Введите логин друга" closeButtonTitle:@"Отмена" duration:0.0f];
    
    
}



#pragma mark - TableView Delegate Methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.friends.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell3 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[TableViewCell3 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    PFUser *friend = self.friends[indexPath.row];
    
    cell.friendUsername.text = friend[@"username"];
    
    cell.friendImage.layer.masksToBounds = YES;
    [cell.friendImage.layer setCornerRadius:22];
    
    PFFile *userImageFile = friend[@"image"];
    cell.friendImage.image = [UIImage imageNamed:@"placeholder.png"];
    
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error){
        if(imageData){
            UIImage *image = [UIImage imageWithData:imageData];
            cell.friendImage.image = image;
        } else {
            
        }
    }];
    
    

    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){

        PFObject *friend = self.friends[indexPath.row];
        
        PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
        [query1 whereKey:@"friend1" equalTo:[PFUser currentUser]];
        [query1 whereKey:@"friend2" equalTo:friend];
        
        PFQuery *query2 = [PFQuery queryWithClassName:@"Friends"];
        [query2 whereKey:@"friend2" equalTo:[PFUser currentUser]];
        [query2 whereKey:@"friend1" equalTo:friend];
        
        PFQuery *query = [PFQuery orQueryWithSubqueries:@[query1,query2]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            if(!error){
                for(PFObject *friendObject in objects){
                    [friendObject deleteInBackground];
                }
            }
            
        }];

        
        [self.friends removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadData];
    }
    
  
}

#pragma mark - Helper methods

-(void) addFriend: (PFUser *) friend
{
    PFObject *friendObject = [PFObject objectWithClassName:@"Friends"];
    
    friendObject[@"friend1"] = [PFUser currentUser];
    friendObject[@"friend2"] = friend;
    
    [friendObject saveInBackground];
}


-(void) downloadFriendList
{
    self.friends = [NSMutableArray new];
    PFQuery *query1 = [PFQuery queryWithClassName:@"Friends"];
    [query1 whereKey:@"friend1" equalTo:[PFUser currentUser]];
    
    PFQuery *query2 = [PFQuery queryWithClassName:@"Friends"];
    [query2 whereKey:@"friend2" equalTo:[PFUser currentUser]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[query1,query2]];
    
    [query includeKey:@"friend1"];
    [query includeKey:@"friend2"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            self.friends = [NSMutableArray new];
            for(PFObject *friendObject in objects){
                if([friendObject[@"friend1"][@"username"] isEqualToString:[PFUser currentUser][@"username"]]){
                    [self.friends addObject:friendObject[@"friend2"]];
                } else{
                    [self.friends addObject:friendObject[@"friend1"]];
                }
            }
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    }];
    
}

-(void) setUpScreen
{
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor emerlandColor]];
    
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.title = @"Мои друзья";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

@end
