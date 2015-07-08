//
//  EditViewController.h
//  4Buy
//
//  Created by Даурен Макул on 08.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol EditViewControllerDelegate <NSObject>

-(void)didEditProduct: (PFObject *)editedProduct;

@end

@interface EditViewController : UIViewController

@property (nonatomic) PFObject *product;
@property (nonatomic) PFObject *list;

@property id<EditViewControllerDelegate> delegate;

@end
