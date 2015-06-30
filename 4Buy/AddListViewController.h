//
//  AddListViewController.h
//  4Buy
//
//  Created by Даурен Макул on 30.06.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "List.h"


@protocol AddListViewControllerDelegate <NSObject>

-(void) didAddList: (List *) newList;

@end

@interface AddListViewController : UIViewController

@property id<AddListViewControllerDelegate> delegate;

@end
