//
//  ListsViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ListsViewController.h"
#import "AddListViewController.h"
#import <Parse/Parse.h>
#import "List.h"
#import "TableViewCell.h"

@interface ListsViewController ()<AddListViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) NSMutableArray *lists;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
@property (strong, nonatomic) IBOutlet UILabel *addLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self checkForEmptiness];
    self.lists = [NSMutableArray new];
  
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addNewList" sender:nil];
}


#pragma mark - AddList Delegate methods
-(void)didAddList:(List *)newList
{
    self.navigationItem.leftBarButtonItem.enabled = YES;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.addBarButton.enabled = YES;
    self.tableView.hidden = NO;
    self.addBarButton.tintColor = [UIColor whiteColor];
    self.addButton.hidden = NO;
    self.addLabel.hidden = NO;
    [self.lists addObject:newList];
    [self.tableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - TableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lists count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    List *list = self.lists[indexPath.row];
    cell.textLabel.alpha = 0.9;
    
    cell.nameLabel.text = list.name;
    cell.friendsNumberLabel.text = @"1";
    cell.friendsNumberImage.alpha = 0.7;
    cell.colorLabel.alpha = 0.65;
    cell.colorLabel.text = @"";
    [cell.colorLabel.layer setCornerRadius:15];
    [cell.colorLabel.layer setBackgroundColor:[list.color CGColor]];
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"viewList" sender:nil];
}

#pragma mark- Helper methods



-(void) checkForEmptiness
{
    if(self.lists.count == 0){
        self.navigationItem.leftBarButtonItem.enabled = NO;
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor clearColor];
        self.addBarButton.enabled = NO;
        self.tableView.hidden = YES;
        self.addBarButton.tintColor = [UIColor clearColor];
    } else {
        self.addButton.hidden = YES;
        self.addLabel.hidden = YES;
    }
}

-(void) setUpScreen
{
    [self.addButton.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [self.addButton.layer setBorderWidth:0.5];
    [self.addButton.layer setCornerRadius:4];
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Мои списки";
    
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"addNewList"]) {
        UINavigationController *nextVC = segue.destinationViewController;
        AddListViewController *controller = [nextVC viewControllers][0];
        controller.delegate = self;
    }
}


@end
