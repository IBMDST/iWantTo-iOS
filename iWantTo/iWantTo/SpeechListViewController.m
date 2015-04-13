//
//  TopicListViewController.m
//  iWantTo
//
//  Created by Josh on 3/23/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "SpeechListViewController.h"
#import "HttpRequestUtility.h"
#import "PromptUtility.h"
#import "SpeechViewController.h"
#import "GlobalVariableManager.h"

@interface SpeechListViewController ()

@end

@implementation SpeechListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [PromptUtility showLoadingHUDInController:self];
    [HttpRequestUtility sendGetFromAPIPath:@"speeches" withPath:@"" parameters:nil runOnSuccess:^(MKNetworkOperation *completedOperation) {
        _speechListArray = completedOperation.responseJSON;
        [_speechListTable reloadData];
       [PromptUtility hideLoadingHUDInThreadWithController:self];
    } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
        [PromptUtility hideLoadingHUDInThreadWithController:self];
        [PromptUtility showServerErrorMessage];
    }];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"speechView"]) {
        SpeechViewController *svc = [segue destinationViewController];
        if ([(UIView*)sender tag] == 9) {
            svc.viewType = SpeechViewTypeNew;
        }
        else if ([(UIView*)sender tag] == 8) {
            NSIndexPath *indexPath = [self.speechListTable indexPathForCell:(UITableViewCell*)sender];
            NSDictionary *speechItem = [_speechListArray objectAtIndex:indexPath.row];
            svc.speechItem = speechItem;
            
            if ([[GlobalVariableManager sharedInstance].userID isEqualToString: [speechItem objectForKey:@"speakerID"]]) {
                svc.viewType = SpeechViewTypeEditable;
            }
            else{
                svc.viewType = SpeechViewTypeReadonly;
            }
            
        }
    }
}

- (IBAction)newTopicButtonHandler:(id)sender
{
    [self performSegueWithIdentifier:@"speechView" sender:sender];
}


#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_speechListArray count];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeechItemCell *topicCell = [tableView dequeueReusableCellWithIdentifier:@"SpeechItemCell"
                                                                  forIndexPath:indexPath];
    topicCell.subjectLab.text = [[_speechListArray objectAtIndex:indexPath.row] objectForKey:@"subject"];
    topicCell.descriptionLab.text = [[_speechListArray objectAtIndex:indexPath.row] objectForKey:@"description"];
    
    return topicCell;
}

#pragma mark -
#pragma mark TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SpeechItemCell *selectedCell = (SpeechItemCell *)[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"speechView" sender:selectedCell];
}





@end
