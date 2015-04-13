//
//  CommentsViewController.h
//  iWantTo
//
//  Created by Josh on 3/27/15.
//  Copyright (c) 2015 Josh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentsViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *commentsListTable;

@property (nonatomic, strong) NSArray *commentListArray;

@end
