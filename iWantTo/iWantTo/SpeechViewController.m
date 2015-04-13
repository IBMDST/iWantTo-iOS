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
}


- (IBAction)publishButtonHandler:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initializeTextComponents
{
    if (_viewType == SpeechViewTypeReadonly) {
        _descTV.text = [_speechItem objectForKey:@"description"];
        _subjectTF.text = [_speechItem objectForKey:@"subject"];
        _speakerLab.text = [_speechItem objectForKey:@"speakerName"];
        [_descTV setEditable:NO];
        [_subjectTF setEnabled:NO];
    }
    else if(_viewType == SpeechViewTypeNew){
        _descTV.text = @"";
        _subjectTF.text = @"";
        _speakerLab.text = [GlobalVariableManager sharedInstance].username;
        [_descTV setEditable:YES];
        [_subjectTF setEnabled:YES];
    }
    else{
        _descTV.text = [_speechItem objectForKey:@"description"];
        _subjectTF.text = [_speechItem objectForKey:@"subject"];
        _speakerLab.text = [_speechItem objectForKey:@"speakerName"];
        [_descTV setEditable:YES];
        [_subjectTF setEnabled:YES];
    }
}



@end
