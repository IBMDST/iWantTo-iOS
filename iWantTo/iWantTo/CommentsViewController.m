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
    self.commentsListTable.rowHeight = UITableViewAutomaticDimension;
    self.commentsListTable.estimatedRowHeight = 160.0f;
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
    [self registerForKeyboardNotifications];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self deregisterFromKeyboardNotifications];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_commentsListTable reloadData];
    [_commentsListTable setNeedsLayout];
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

//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    return 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"
                                                                forIndexPath:indexPath];
    
    commentCell.title.text = [NSString stringWithFormat:@"%@ Created on: %@", [[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"userName"], [self dateStringFromtimeInterval:[[[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"createdOn"] doubleValue]]];
    commentCell.content.text = [[_commentListArray objectAtIndex:indexPath.row] objectForKey:@"comment"];
    
    return commentCell;
}



#pragma mark -
#pragma mark Custom methods

- (NSString *)dateStringFromtimeInterval:(double)timeInterval
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
        [self.navigationController popViewControllerAnimated:YES];
        
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


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [_commentTV resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification*)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect screenRect = self.view.frame;
    screenRect.size.height -= keyboardRect.size.height;
    if (CGRectContainsPoint(screenRect, _commentTV.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_commentTV.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


@end
