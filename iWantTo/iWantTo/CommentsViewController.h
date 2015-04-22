//
//  CommentsViewController.h
//  iWantTo
//
//  Created by Josh on 3/27/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *commentsListTable;
@property (nonatomic, strong) IBOutlet UITextView *commentTV;

@property (nonatomic, strong) NSMutableArray *commentListArray;
@property (nonatomic, strong) NSString *speechID;

- (NSString *)DateStringFromtimeInterval:(double)timeInterval;

- (IBAction)commentButtonHandler:(id)sender;
- (void)borderedTextView;

@end
