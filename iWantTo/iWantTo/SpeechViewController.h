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

@interface SpeechViewController : UIViewController<UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *likeButton;
@property (nonatomic, strong) IBOutlet UITextField *subjectTF;
@property (nonatomic, strong) IBOutlet UILabel *subjectLab;
@property (nonatomic, strong) IBOutlet UITextView *descTV;
@property (nonatomic, strong) IBOutlet UILabel *speakerLab;
@property (nonatomic, strong) IBOutlet UINavigationItem *publishButton;
@property (nonatomic, strong) IBOutlet UIButton *viewCommentsButton;

@property (nonatomic, assign) SpeechViewType viewType;
@property (nonatomic, strong) NSDictionary *speechItem;
@property (nonatomic, assign) BOOL likedSpeech;
@property (nonatomic, strong) NSMutableDictionary *currentInterest;

- (IBAction)publishButtonHandler:(id)sender;

- (void)initializeTextComponents;
- (void)initializeLikeButton;
- (void)borderedTextView;
- (void)displayingHTMLContentInTextView;
- (IBAction)likeButtonHandler:(id)sender;
- (BOOL)isLikedSpeech;

@end
