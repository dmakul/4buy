//
//  AddProductViewController.h
//  4Buy
//
//  Created by Даурен Макул on 01.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import <Parse/Parse.h>


@protocol AddProductViewControllerDelegate <NSObject>

-(void) didAddProduct: (PFObject *) newProduct;

@end

@interface AddProductViewController : UIViewController

@property (nonatomic) PFObject *list;

@property id<AddProductViewControllerDelegate> delegate;

@end
