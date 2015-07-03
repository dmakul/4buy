//
//  ListViewController.m
//  4Buy
//
//  Created by Даурен Макул on 01.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import "ListViewController.h"
#import "AddProductViewController.h"
#import "Product.h"
#import "TableViewCell2.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <TNRadioButtonGroup/TNRadioButtonGroup.h>



@interface ListViewController () <UITableViewDataSource,UITableViewDelegate,AddProductViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIButton *addProductButton;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *emptyListLabel;
@property (nonatomic) TNRadioButtonGroup *sexGroup;
@property (nonatomic) NSMutableArray *isDoneProducts;
@property (nonatomic) NSMutableArray *isNotDoneProducts;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hidden = YES;
    self.emptyListLabel.hidden = YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    [self downloadProducts];

    
    [self setUpScreen];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"AddNewProduct"]) {
        UINavigationController *nextVC = segue.destinationViewController;
        AddProductViewController *controller = [nextVC viewControllers][0];
        controller.delegate = self;
        controller.list = self.list;
    }
}

#pragma mark - AddProduct Methods

-(void)didAddProduct:(Product *)newProduct
{
    self.tableView.hidden = NO;
    self.emptyListLabel.hidden = YES;
    [self.isNotDoneProducts addObject:newProduct];
    [self.tableView reloadData];
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
}

#pragma mark - TableView Delegate mehtods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return self.isNotDoneProducts.count;
    if(section == 1) return self.isDoneProducts.count;
    return 0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell2 *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if(!cell){
        cell = [[TableViewCell2 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    
    if(indexPath.section == 0){
        PFObject *product = self.isNotDoneProducts[indexPath.row];
        cell.nameLabel.alpha = 1;
        cell.amountLabel.alpha = 1;
        cell.nameLabel.text = product[@"name"];
        cell.amountLabel.text = product[@"amount"];
    }
    
    if(indexPath.section == 1){
        PFObject *product = self.isDoneProducts[indexPath.row];
        cell.nameLabel.alpha = 0.3;
        cell.amountLabel.alpha = 0.3;
        cell.nameLabel.text = product[@"name"];
        cell.amountLabel.text = product[@"amount"];
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
        
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
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
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    
    [self.tableView reloadData];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 230, 20)];
    headerView.backgroundColor = [UIColor clearColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame: CGRectMake(110,0, 250, 20)];
    label.backgroundColor = [UIColor clearColor];
    label.alpha = 0.8;
    UIFont *helvFont = [UIFont fontWithName:@"HelveticaNeue" size:15.0];
    label.font = helvFont;
//    label.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    if(section == 0){
       if(self.isNotDoneProducts.count == 0) label.text = @""; else label.text = @"Надо купить";
    }
    if(section == 1){
       if(self.isDoneProducts.count == 0) label.text = @""; else label.text = @"Уже куплено";
    }
    [headerView addSubview:label];
    return headerView;
}


#pragma mark - Helper methods


-(void) isDoneOrNot
{
    self.isDoneProducts = [NSMutableArray new];
    self.isNotDoneProducts = [NSMutableArray new];
    for(PFObject *productObject in self.products){
        if([productObject[@"isDone"]  isEqual: @(YES)]){
            [self.isDoneProducts addObject:productObject];
        } else
            [self.isNotDoneProducts addObject:productObject];
    }
    
}

-(void) downloadProducts
{
    PFQuery *query = [PFQuery queryWithClassName:@"ProductList"];
    [query whereKey:@"listId" equalTo:self.list];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if(!error){
            self.products = [NSMutableArray new];
            for(PFObject *listObject in objects){
                [self.products addObject:listObject];
            }
            [self isDoneOrNot];
            if(self.products.count != 0){
                [self.tableView reloadData];
                self.tableView.hidden = NO;
            } else {
                self.emptyListLabel.hidden = NO;
                self.emptyListLabel.alpha = 0.7;
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
        }
    }];
}

-(void) setUpScreen
{
    
    
    
    
    self.tableView.tableFooterView = [UIView new];
    self.navigationItem.title = self.list[@"name"];
    [self.addProductButton.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self.addProductButton.layer setCornerRadius:4];
    [self.addProductButton.layer setBorderWidth:0.5];
    
}

@end
