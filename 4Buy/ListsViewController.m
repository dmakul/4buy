//
//  ListsViewController.m
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ListsViewController.h"
#import "AddListViewController.h"
#import "ListViewController.h"
#import <Parse/Parse.h>
#import "TableViewCell.h"
#import "ListViewController.h"
#import "UIColor+Helpers.h"
#import <UIScrollView+EmptyDataSet.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ListsViewController ()<AddListViewControllerDelegate,UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@property (nonatomic) NSMutableArray *lists;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *addBarButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (nonatomic) NSMutableArray *productsArray;

@end

@implementation ListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [self downloadLists];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    
  
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

- (IBAction)addBarButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"addNewList" sender:nil];
}

- (IBAction)editButtonPressed:(UIBarButtonItem *)sender {
    
    if(self.lists.count!=0){
        if(self.tableView.editing) {
            self.navigationItem.leftBarButtonItem.title = @"Изменить";
            [self.tableView setEditing:NO animated:YES];
        } else{
            self.editButton.title = @"Готово";
            [self.tableView setEditing:YES animated:YES];
        }
    }
}

#pragma mark - EmptyList delegate methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *text = @"У Вас нету ни одного списка";
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:18.0],
                                 NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0]};
    
    return [[NSAttributedString alloc] initWithString:@"СОЗДАТЬ НОВЫЙ СПИСОК" attributes:attributes];
}

- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView {
    [self performSegueWithIdentifier:@"addNewList" sender:nil];
}

#pragma mark - AddList Delegate methods
-(void)didAddList:(PFObject *)newList
{
    [self.lists addObject:newList];
    [self.tableView reloadData];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - parse methods

-(void) downloadLists
{
    PFQuery *query = [PFQuery queryWithClassName:@"List"];
    [query whereKey:@"userId" equalTo:[PFUser currentUser]];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            self.lists = [NSMutableArray new];
            for(PFObject *listObject in objects){
                [self.lists addObject:listObject];
            }
            [self.tableView reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        
    }];
    
}


#pragma mark - TableView delegate methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.lists count];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        PFObject *list = self.lists[indexPath.row];
        [list deleteInBackground];
        [self.lists removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.tableView reloadData];
    }
    
    if(self.lists.count == 0){
        self.navigationItem.leftBarButtonItem.title = @"Изменить";
        [self.tableView setEditing:NO animated:YES];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if(!cell){
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    PFObject *list = self.lists[indexPath.row];
    cell.textLabel.alpha = 0.9;
    
    cell.nameLabel.text = list[@"name"];
    cell.friendsNumberLabel.text = @"1";
    cell.friendsNumberImage.alpha = 0.7;
    cell.colorLabel.alpha = 0.65;
    cell.colorLabel.text = @"";
    [cell.colorLabel.layer setCornerRadius:18];
    
    PFQuery *query = [PFQuery queryWithClassName:@"ProductList"];
    [query whereKey:@"listId" equalTo:list];

    self.productsArray = [NSMutableArray new];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            for(PFObject *productObject in objects){
                [self.productsArray addObject:productObject[@"name"]];
            }
            NSLog(@"%@", [self.productsArray componentsJoinedByString:@", "]);
            cell.listLabel.text = [self.productsArray componentsJoinedByString:@", "];
        }
    }];
    
    UIColor *color = [UIColor colorFromHexString:list[@"color"]];

    
    [cell.colorLabel.layer setBackgroundColor:[color CGColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"viewList" sender:nil];
}

#pragma mark- Helper methods



-(void) setUpScreen
{
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIFont fontWithName:@"Helvetica Neue" size:11.0],NSFontAttributeName,
      nil]];
    

    
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.title = @"Списки";
    
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
    
    if([segue.destinationViewController isKindOfClass:[ListViewController class]]){
        ListViewController *nextVC = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        nextVC.list = self.lists[indexPath.row];
    }
}


@end
