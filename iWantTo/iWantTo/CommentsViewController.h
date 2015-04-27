//
//  CommentsViewController.h
//  iWantTo
//
//  Created by Josh on 3/27/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UITableView *commentsListTable;
@property (nonatomic, strong) IBOutlet UITextView *commentTV;

@property (nonatomic, strong) NSMutableArray *commentListArray;
@property (nonatomic, strong) NSString *speechID;

- (NSString *)dateStringFromtimeInterval:(double)timeInterval;

- (IBAction)commentButtonHandler:(id)sender;


- (void)borderedTextView;

- (void)registerForKeyboardNotifications;
- (void)deregisterFromKeyboardNotifications;
- (void)keyboardWasShown:(NSNotification*)notification;
- (void)keyboardWillBeHidden:(NSNotification*)notification;



@end
