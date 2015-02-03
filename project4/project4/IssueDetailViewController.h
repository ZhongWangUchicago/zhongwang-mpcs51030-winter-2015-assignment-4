//
//  IssueDetailViewController.h
//  project4
//
//  Created by WangZhong on 15-2-2.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueTableViewCell.h"
#import "IssueTableViewController.h"

@interface IssueDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *Comments;
@property (weak, nonatomic) IBOutlet UILabel *Author;
@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (nonatomic) NSMutableDictionary *currentDictionary;
@end
