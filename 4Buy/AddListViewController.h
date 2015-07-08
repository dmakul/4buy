//
//  AddListViewController.h
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@protocol AddListViewControllerDelegate <NSObject>

-(void) didAddList: (PFObject *) newList;

@end

@interface AddListViewController : UIViewController

@property id<AddListViewControllerDelegate> delegate;

@end
