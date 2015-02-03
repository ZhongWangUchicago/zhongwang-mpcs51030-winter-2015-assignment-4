//
//  IssueTableViewController.m
//  project4
//
//  Created by WangZhong on 15-2-2.
//  Copyright (c) 2015年 Zhong. All rights reserved.
//

#import "IssueTableViewController.h"

@interface IssueTableViewController ()
@property (strong, nonatomic) NSMutableArray * issueData;
@end

@implementation IssueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    UIRefreshControl *pullToRefresh = [[UIRefreshControl alloc]init];
    pullToRefresh.tintColor = [UIColor magentaColor];
    [pullToRefresh addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = pullToRefresh;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self downloadIssueData];
}
-(void)refreshAction{
    NSLog(@"Pull to refresh action");
    [self downloadIssueData];
    [self.refreshControl endRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

		
#pragma mark - Table view data source


-(void) downloadIssueData{
    // GitHub API url
    NSString *url = @"https://api.github.com/repos/uchicago-mobi/2015-Winter-Forum/issues?state=open";
    
    // Create NSUrlSession
    NSURLSession *session = [NSURLSession sharedSession];
    
    // Create data download taks
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                
                NSError *jsonError;
                self.issueData = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:&jsonError];
                // Log the data for debugging
                NSLog(@"DownloadeData:%@",self.issueData);
                
                // Use dispatch_async to update the table on the main thread
                // Remember that NSURLSession is downloading in the background
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }] resume];
//    if(self.refreshControl.refreshing){
//        [self.refreshControl endRefreshing];
//    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.issueData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IssueCell";
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSMutableDictionary *dictionary = [self.issueData objectAtIndex: indexPath.row];
    cell.title.text = [dictionary objectForKey:@"title"];
    cell.author.text = [[dictionary objectForKey:@"user"] objectForKey: @"login"];
    cell.date.text = [dictionary objectForKey:@"updated_at"];
    NSString *state = [dictionary objectForKey: @"state"];
    if ([state isEqualToString:@"open"]) {
        cell.statusImage.image = [UIImage imageNamed: @"open.jpg"];
    }
    if([state isEqualToString:@"closed"]){
        cell.statusImage.image = [UIImage imageNamed: @"closed.jpg"];
    }
    return cell;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString: @"segueIssueDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSMutableDictionary *dictionary = [self.issueData objectAtIndex:indexPath.row];
        IssueDetailViewController *idvc = [segue destinationViewController];
        [idvc setCurrentDictionary: dictionary];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
