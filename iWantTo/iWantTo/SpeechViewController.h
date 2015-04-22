//
//  SpeechViewController.h
//  iWantTo
//
//  Created by Josh on 3/26/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SpeechViewType) {
    SpeechViewTypeNew = 0,
    SpeechViewTypeReadonly = 1,
    SpeechViewTypeEditable = 2
};

@interface SpeechViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *likeButton;
@property (nonatomic, strong) IBOutlet UITextField *subjectTF;
@property (nonatomic, strong) IBOutlet UILabel *subjectLab;
@property (nonatomic, strong) IBOutlet UITextView *descTV;
@property (nonatomic, strong) IBOutlet UILabel *speakerLab;
@property (nonatomic, strong) IBOutlet UINavigationItem *publishButton;

@property (nonatomic, assign) SpeechViewType viewType;
@property (nonatomic, strong) NSDictionary *speechItem;

- (IBAction)publishButtonHandler:(id)sender;

- (void)initializeTextComponents;
- (void)borderedTextView;

@end
