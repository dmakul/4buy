//
//  TableViewCell.h
//  4Buy
//
//  Created by Даурен Макул on 01.07.15.
//  Copyright (c) 2015 Даурен Макул. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@property (strong, nonatomic) IBOutlet UIImageView *friendsNumberImage;
@property (strong, nonatomic) IBOutlet UILabel *friendsNumberLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@property (strong, nonatomic) IBOutlet UILabel *listLabel;


@end
