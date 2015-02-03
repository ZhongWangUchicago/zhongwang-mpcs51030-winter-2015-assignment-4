//
//  Circle.m
//  project4
//
//  Created by WangZhong on 15-2-2.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "Circle.h"

@implementation Circle

- (void)drawRect:(CGRect)rect
{
    
    CGRect bounds = self.bounds;
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    float radius = MIN(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path addArcWithCenter:center radius:radius -10 startAngle:0 endAngle:M_PI*2.0 clockwise:YES];
    path.lineWidth = 10;
    [[UIColor greenColor] setStroke];
    [path stroke];
    
    UIBezierPath *secondPath = [[UIBezierPath alloc]init];
    [secondPath addArcWithCenter:center radius:radius -30 startAngle:0 endAngle:M_PI*2.0 clockwise:YES];
    secondPath.lineWidth = 10;
    [[UIColor redColor] setStroke];
    [secondPath stroke];
    
    
    //draw two labels
    CGRect label1Frame = CGRectMake(bounds.origin.x + 10, center.y + 10, bounds.size.width - 20, 50);
    CGRect label2Frame = CGRectMake(bounds.origin.x + 10, center.y - 50, bounds.size.width - 20, 50);
    
    self.closedIssues = [[UILabel alloc]initWithFrame:label2Frame];
    self.closedIssues.font = [UIFont boldSystemFontOfSize:30.0f];
    self.closedIssues.textColor = [UIColor redColor];
    self.closedIssues.textAlignment = NSTextAlignmentCenter;
    self.closedIssues.numberOfLines = 0;
    
    self.openIssues = [[UILabel alloc]initWithFrame:label1Frame];
    self.openIssues.font = [UIFont boldSystemFontOfSize:30.0f];
    self.openIssues.textColor = [UIColor greenColor];
    self.openIssues.textAlignment = NSTextAlignmentCenter;
    self.openIssues.numberOfLines = 0;
    
    
    //display the number of open and closed issues by querying API
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=all";
    NSURLSession *session = [NSURLSession sharedSession];
    self.issueData = [[NSMutableArray alloc]init];
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                
                NSError *jsonError;
                self.issueData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&jsonError];
                // Log the data for debugging
                NSLog(@"DownloadeData:%@", self.issueData);
                
                //count the number of closed and open issues
                self.closedNumber = 0;
                self.openNumber = 0;
                for(NSMutableDictionary *a in self.issueData){
                    NSString *state = [a objectForKey: @"state"];
                    if ([state isEqualToString:@"open"]) {
                        self.openNumber++;
                    }
                    if([state isEqualToString:@"closed"]){
                        self.closedNumber++;
                    }
                }
                // Use dispatch_async to update the labels on the main thread
                // Remember that NSURLSession is downloading in the background
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.closedIssues.text = [NSString stringWithFormat:@"%d Open Issues", self.openNumber];
                    self.openIssues.text = [NSString stringWithFormat:@"%d Closed Issues", self.closedNumber];
                });
            }] resume];
    
   
    [self addSubview: self.closedIssues];
    [self addSubview:self.openIssues];
    
}


@end
