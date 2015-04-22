//
//  SpeechViewController.m
//  iWantTo
//
//  Created by Josh on 3/26/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import "SpeechViewController.h"
#import "GlobalVariableManager.h"
#import "CommentsViewController.h"
#import "HttpRequestUtility.h"
#import "PromptUtility.h"

@interface SpeechViewController ()

@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeTextComponents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    CommentsViewController *cvc = [segue destinationViewController];
    cvc.commentListArray = [_speechItem objectForKey:@"comments"];
    cvc.speechID = [_speechItem objectForKey:@"id"];
}


- (IBAction)publishButtonHandler:(id)sender
{
    [_descTV resignFirstResponder];
    [_subjectTF resignFirstResponder];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:4];
    NSString *timestamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]] ;
    [params setObject:_subjectTF.text forKey:@"subject"];
    [params setObject:_descTV.text forKey:@"description"];
    [params setObject:[GlobalVariableManager sharedInstance].userID forKey:@"speakerID"];
    [params setObject:timestamp forKey:@"createdOn"];
    
    [PromptUtility showHUDInController:self];
    
    if (_viewType == SpeechViewTypeEditable) {
        [params setObject:[_speechItem objectForKey:@"id"] forKey:@"id"];
        [HttpRequestUtility sendPutFromAPIPath:@"speeches" withPath:@"" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
            NSLog(@"add speeche%@",completedOperation.readonlyResponse);
            [self.navigationController popViewControllerAnimated:YES];
            [PromptUtility hideHUDInThreadWithController:self];
            
        } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
            [PromptUtility showServerErrorMessage];
            [PromptUtility hideHUDInThreadWithController:self];
        }];
    }
    else
    {
        [HttpRequestUtility sendPostFromAPIPath:@"speeches" withPath:@"" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
            NSLog(@"add speeche%@",completedOperation.readonlyResponse);
            [self.navigationController popViewControllerAnimated:YES];
            [PromptUtility hideHUDInThreadWithController:self];
            
        } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
            [PromptUtility showServerErrorMessage];
            [PromptUtility hideHUDInThreadWithController:self];
        }];
    }
    
    
    
    
}

- (void)initializeTextComponents
{
    if (_viewType == SpeechViewTypeReadonly) {
        _descTV.text = [_speechItem objectForKey:@"description"];
        _subjectLab.text = [_speechItem objectForKey:@"subject"];
        _speakerLab.text = [_speechItem objectForKey:@"speakerName"];
        [_descTV setEditable:NO];
        [_subjectTF setHidden:YES];
        [_subjectLab setHidden:NO];
        [self.navigationItem.rightBarButtonItem setEnabled:NO];
        
    }
    else if(_viewType == SpeechViewTypeNew){
        _descTV.text = @"";
        _subjectTF.text = @"";
        _speakerLab.text = [GlobalVariableManager sharedInstance].username;
        [_descTV setEditable:YES];
        [_subjectTF setHidden:NO];
        [_subjectLab setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"Publish";
        [self borderedTextView];

    }
    else{
        _descTV.text = [_speechItem objectForKey:@"description"];
        _subjectTF.text = [_speechItem objectForKey:@"subject"];
        _speakerLab.text = [_speechItem objectForKey:@"speakerName"];
        [_descTV setEditable:YES];
        [_subjectTF setHidden:NO];
        [_subjectLab setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"Update";
        [self borderedTextView];
    }
}
- (void)borderedTextView
{
    [_descTV.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_descTV.layer setBorderWidth:1.0];
    _descTV.layer.cornerRadius = 5;
    _descTV.clipsToBounds = YES;
}


@end
