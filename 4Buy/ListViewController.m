//

//  ListViewController.m

//  4Buy

//

//  Created by Даурен Макул on 01.07.15.

//  Copyright (c) 2015 Даурен Макул. All rights reserved.

//

#import <MGSwipeTableCell/MGSwipeTableCell.h>
#import <MGSwipeTableCell/MGSwipeButton.h>
#import <ChameleonFramework/Chameleon.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIScrollView+EmptyDataSet.h"
#import <FlatUIKit/UIColor+FlatUI.h>
#import "AddProductViewController.h"
#import <FlatUIKit/FlatUIKit.h>
#import "ListViewController.h"
#import "EditViewController.h"
#import <Masonry/Masonry.h>
#import "TableViewCell2.h"


@interface ListViewController () <EditViewControllerDelegate,DZNEmptyDataSetDelegate,DZNEmptyDataSetSource,MGSwipeTableCellDelegate,UITableViewDataSource,UITableViewDelegate,AddProductViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *isDoneProducts;
@property (nonatomic) NSMutableArray *isNotDoneProducts;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetDelegate = self;
    self.tableView.emptyDataSetSource = self;
    
    [self downloadProducts];
    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - EmptyList delegate methods

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    UIView *customView = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"Нету списков";
    label.textColor = [UIColor asbestosColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:22.0f];
    
    [customView addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(customView.mas_centerX);
        make.centerY.equalTo(customView.mas_centerY);
    }];
    return customView;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([[segue identifier] isEqualToString:@"AddNewProduct"]) {
        UINavigationController *nextVC = segue.destinationViewController;
        AddProductViewController *controller = [nextVC viewControllers][0];
        controller.delegate = self;
        controller.list = self.list;
    }
    if ([[segue identifier] isEqualToString:@"editProduct"]) {
        UINavigationController *nextVC = segue.destinationViewController;
        EditViewController *controller = [nextVC viewControllers][0];
        controller.delegate = self;
        controller.list = self.list;
        controller.product = sender;
    }
    
}

#pragma mark - EditPRoduct Methods

-(void)didEditProduct:(PFObject *)editedProduct {
    if([editedProduct[@"isDone"]  isEqual: @(YES)]) {

    }
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}

#pragma mark - AddProduct Methods


-(void)didAddProduct:(PFObject *)newProduct {
    [self.isNotDoneProducts addObject:newProduct];
    [self.tableView reloadData];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
}



#pragma mark - TableView Delegate mehtods

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete){
        PFObject *product = self.products[indexPath.row];
        [product deleteInBackground];
        if(indexPath.section == 0){
            [self.isNotDoneProducts removeObject:product];
            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        }
        if(indexPath.section == 1) {
            [self.isDoneProducts removeObject:product];
            NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
            [self.tableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self.tableView reloadData];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0) return self.isNotDoneProducts.count;
    if(section == 1) return self.isDoneProducts.count;
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * reuseIdentifier = @"Cell";
    
    MGSwipeTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        
        cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
        
    }
    cell.textLabel.text = @"Title";
    cell.detailTextLabel.text = @"Detail text";
    UIColor *color = [UIColor emerlandColor];
    
    //configure left buttons
    
    if(indexPath.section == 0) {
    
        cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"check.png"] backgroundColor:color]];
        
    } else {
        cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"cross.png"] backgroundColor:[UIColor alizarinColor]]];
    }
    
    cell.delegate = self;
    cell.leftExpansion.buttonIndex = 0;
    cell.leftExpansion.fillOnTrigger = YES;
    cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
    
    if(indexPath.section == 0){
        PFObject *product = self.isNotDoneProducts[indexPath.row];
        cell.textLabel.alpha = 1;
        cell.detailTextLabel.alpha = 1;
        cell.textLabel.text = product[@"name"];
        cell.detailTextLabel.text = product[@"amount"];
    }
    
    if(indexPath.section == 1){
        PFObject *product = self.isDoneProducts[indexPath.row];
        cell.textLabel.alpha = 0.3;
        cell.detailTextLabel.alpha = 0.3;
        cell.textLabel.text = product[@"name"];
        cell.detailTextLabel.text = product[@"amount"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"editProduct" sender:self.products[indexPath.row]];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.alpha = 0.8;
    UIFont *helvFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f];
    label.font = helvFont;
    
    //    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    
    if(section == 0){
        if(self.isNotDoneProducts.count == 0) label.text = @""; else label.text = @"Надо купить";
    }
    
    if(section == 1){
        if(self.isDoneProducts.count == 0) label.text = @""; else label.text = @"Уже куплено";
    }
    [headerView addSubview:label];
    
   
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView.mas_centerX);
        make.top.mas_equalTo(5);
    }];
    
    return headerView;
}

#pragma mark - MGSwipe delegate

-(BOOL)swipeTableCell:(MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if(indexPath.section == 0){
        PFObject *product = self.isNotDoneProducts[indexPath.row];
        [self.isDoneProducts addObject:product];
        [self.isNotDoneProducts removeObject:product];
        product[@"isDone"] = @(YES);
        [product saveInBackground];
        NSArray *insertIndexPaths = [[NSArray alloc] initWithObjects:
                                     [NSIndexPath indexPathForRow:0 inSection:1],
                                     nil];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }

    if(indexPath.section == 1){
        PFObject *product = self.isDoneProducts[indexPath.row];
        [self.isNotDoneProducts addObject:product];
        [self.isDoneProducts removeObject:product];
        product[@"isDone"] = @(NO);
        [product saveInBackground];
        NSArray *insertIndexPaths = [[NSArray alloc] initWithObjects:
                                     [NSIndexPath indexPathForRow:0 inSection:0],
                                     nil];
        [self.tableView beginUpdates];
        [self.tableView insertRowsAtIndexPaths:insertIndexPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
    [self.tableView reloadData];
    return YES;
}

#pragma mark - Helper methods

- (UIView *)viewWithImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

-(void) isDoneOrNot {
    self.isDoneProducts = [NSMutableArray new];
    self.isNotDoneProducts = [NSMutableArray new];
    for(PFObject *productObject in self.products){
        if([productObject[@"isDone"]  isEqual: @(YES)]){
            [self.isDoneProducts addObject:productObject];
        } else
            [self.isNotDoneProducts addObject:productObject];
    }
}

-(void) downloadProducts {
    PFQuery *query = [PFQuery queryWithClassName:@"ProductList"];
    [query whereKey:@"listId" equalTo:self.list];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            self.products = [NSMutableArray new];
            for(PFObject *listObject in objects){
                [self.products addObject:listObject];
            }
            [self isDoneOrNot];
            if([self.products count] != 0) {
                [self.tableView reloadData];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}

-(void) setUpScreen {
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.title = self.list[@"name"];
}



@end

