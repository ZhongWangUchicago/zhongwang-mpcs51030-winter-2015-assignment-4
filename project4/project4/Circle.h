//
//  Circle.h
//  project4
//
//  Created by WangZhong on 15-2-2.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Circle : UIView
@property (nonatomic)  UILabel *openIssues;
@property (nonatomic)  UILabel *closedIssues;
@property (nonatomic) NSMutableDictionary *status;
@property (nonatomic) NSMutableArray *issueData;
@property (nonatomic) int closedNumber;
@property (nonatomic) int openNumber;
@end
