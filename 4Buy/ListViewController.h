//
//  ListViewController.h
//  4Buy
//
//  Created by Даурен Макул on 01.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@protocol AddProductToTheListViewControllerDelegate <NSObject>

-(void) didAddProductToTheList;

@end

@interface ListViewController : UIViewController

@property (nonatomic) PFObject* list;

@property (nonatomic) NSMutableArray *products;

@property id<AddProductToTheListViewControllerDelegate> delegate;

@end
