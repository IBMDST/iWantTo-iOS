//
//  CommentsViewController.m
//  iWantTo
//
//  Created by Josh on 3/27/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "CommentsViewController.h"
#import "CommentCell.h"
#import "HttpRequestUtility.h"
#import "PromptUtility.h"
#import "GlobalVariableManager.h"

@interface CommentsViewController ()

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _commentsListTable.rowHeight = UITableViewAutomaticDimension;
    _commentsListTable.estimatedRowHeight = 80;
    [self borderedTextView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_commentListArray count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"
                                                                forIndexPath:indexPath];
    
    commentCell.title.text = [NSString stringWithFormat:@"%@ Created on: %@", [[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"userName"], [self DateStringFromtimeInterval:[[[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"createdOn"] doubleValue]]];
    commentCell.content.text = [[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"comment"];
    return commentCell;
}



#pragma mark -
#pragma mark Custom methods

- (NSString *)DateStringFromtimeInterval:(double)timeInterval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

- (IBAction)commentButtonHandler:(id)sender
{
    if (_commentTV.text.length == 0) {
        return;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:2];
    NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    [params setObject: [GlobalVariableManager sharedInstance].userID forKey:@"userID"];
    [params setObject: _speechID forKey:@"speechID"];
    [params setObject: timestamp forKey:@"createdOn"];
    [params setObject: _commentTV.text forKey:@"comment"];
    [PromptUtility showHUDInController:self];
    
    [HttpRequestUtility sendPostFromAPIPath:@"speech-comments" withPath:@"" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
//        [_commentListArray addObject:params];
        [PromptUtility hideHUDInThreadWithController:self];
        
    } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
        [PromptUtility hideHUDInThreadWithController:self];
    }];
}
- (void)borderedTextView
{
    [_commentTV.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_commentTV.layer setBorderWidth:1.0];
    _commentTV.layer.cornerRadius = 5;
    _commentTV.clipsToBounds = YES;
}

@end
