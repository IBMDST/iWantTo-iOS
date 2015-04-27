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
#import "DatetimeUtility.h"

@interface SpeechViewController ()

@end

@implementation SpeechViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeLikeButton];
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
    NSString *timestamp = [DatetimeUtility currentTimestampStringSince1970] ;
    NSString *pedDesc = [NSString stringWithFormat:@"<p>%@</p>", _descTV.text];
    [params setObject:_subjectTF.text forKey:@"subject"];
    [params setObject:pedDesc forKey:@"description"];
    [params setObject:[GlobalVariableManager sharedInstance].userID forKey:@"speakerID"];
    [params setObject:timestamp forKey:@"createdOn"];
    
    [PromptUtility showHUDInController:self];
    
    if (_viewType == SpeechViewTypeEditable) {
//        [params setObject:[_speechItem objectForKey:@"id"] forKey:@"id"];
        [params setObject: _descTV.text forKey:@"description"];
        [HttpRequestUtility sendPutFromAPIPath:@"speeches" withPath:[_speechItem objectForKey:@"id"] parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
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
//        _descTV.text = [_speechItem objectForKey:@"description"];
        [self displayingHTMLContentInTextView];
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
        [_viewCommentsButton setHidden:YES];
        [_likeButton setHidden:YES];
        self.navigationItem.rightBarButtonItem.title = @"Publish";
        [self borderedTextView];
    }
    else{
        _descTV.text = [_speechItem objectForKey:@"description"];
//        [self displayingHTMLContentInTextView];
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

- (void)displayingHTMLContentInTextView
{
    NSString * htmlString = [_speechItem objectForKey:@"description"];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    _descTV.attributedText = attributedString;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [_descTV resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)likeButtonHandler:(id)sender{
    [PromptUtility showHUDInController:self];
    if (!_likedSpeech) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithCapacity:3];
        NSString *timestamp = [DatetimeUtility currentTimestampStringSince1970];
        [params setObject:timestamp forKey:@"createdOn"];
        [params setObject:[GlobalVariableManager sharedInstance].userID forKey:@"userID"];
        [params setObject:[_speechItem objectForKey:@"id"] forKey:@"speechID"];
        
        [HttpRequestUtility sendPostFromAPIPath:@"speech-interested" withPath:@"" parameters:params runOnSuccess:^(MKNetworkOperation *completedOperation) {
            _likedSpeech = YES;
            [_likeButton setSelected:YES];
            [PromptUtility hideHUDInThreadWithController:self];
        } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
            [PromptUtility hideHUDInThreadWithController:self];
        }];
    }
    else{
        if (_currentInterest) {
            NSString *interestID = [_currentInterest objectForKey:@"id"];
            [HttpRequestUtility sendDeleteFromAPIPath:@"speech-interested" withPath:interestID parameters:nil runOnSuccess:^(MKNetworkOperation *completedOperation) {
                _likedSpeech = NO;
                [_likeButton setSelected:NO];
                [PromptUtility hideHUDInThreadWithController:self];
            } runOnFailed:^(MKNetworkOperation *completedOperation, NSError *error) {
                [PromptUtility hideHUDInThreadWithController:self];
            }];

        }
    }
}

- (void)initializeLikeButton{
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"unlike.png"] forState:UIControlStateNormal];
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateHighlighted];
    [_likeButton setBackgroundImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateSelected];
    
    if ([self isLikedSpeech]) {
        [_likeButton setSelected:YES];
    }else{
        [_likeButton setSelected:NO];
    }
}


- (BOOL)isLikedSpeech{
    
    NSArray *interestedList = [_speechItem objectForKey:@"interests"];
    
    for (NSMutableDictionary *interestedUser in interestedList) {
        if ([[interestedUser objectForKey:@"userID"] isEqualToString:[GlobalVariableManager sharedInstance].userID]) {
            _likedSpeech = YES;
            _currentInterest = interestedUser;
            return _likedSpeech;
        }
    }
    
    return _likedSpeech;
}

@end
