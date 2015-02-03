//
//  IssueDetailViewController.m
//  project4
//
//  Created by WangZhong on 15-2-2.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "IssueDetailViewController.h"

@interface IssueDetailViewController ()

@end

@implementation IssueDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    self.Title.text = [NSString stringWithFormat:@"Title: %@", [self.currentDictionary objectForKey:@"title"]];
    self.Author.text = [NSString stringWithFormat:@"Author: %@", [[self.currentDictionary objectForKey:@"user"] objectForKey:@"login"]];
    self.Comments.text = [NSString stringWithFormat:@"Comments: %@", [self.currentDictionary objectForKey:@"body"]];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
