//
//  TopicListViewController.h
//  iWantTo
//
//  Created by Josh on 3/23/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeechItemCell.h"

@interface SpeechListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) NSArray *speechListArray;

@property(nonatomic, strong) IBOutlet UITableView *speechListTable;

- (IBAction)newTopicButtonHandler:(id)sender;

@end
