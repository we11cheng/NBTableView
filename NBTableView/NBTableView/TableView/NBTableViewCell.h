//
//  NBTableViewCell.h
//  NBTableView
//
//  Created by 刘彬 on 16/3/10.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBActionBar.h"
#import "NBTableViewAdaptor.h"

@class NBTableViewSection;
@class NBTableViewAdaptor;
@class NBTableViewItem;

typedef NS_ENUM(NSInteger, NBTableViewCellType) {
    NBTableViewCellTypeFirst,
    NBTableViewCellTypeMiddle,
    NBTableViewCellTypeLast,
    NBTableViewCellTypeSingle,
    NBTableViewCellTypeAny
};

@interface NBTableViewCell : UITableViewCell<NBActionBarDelegate>

@property (nonatomic, weak) UITableView *parentTableView;
@property (nonatomic, weak) NBTableViewAdaptor *tableViewAdaptor;
@property (nonatomic, weak) NBTableViewSection *section;

@property (nonatomic, assign, readonly) BOOL loaded;
@property (nonatomic, strong) NBTableViewItem *item;
@property (nonatomic, strong) NBActionBar *actionBar;

// 可响应的控件
@property (nonatomic, strong, readonly) UIResponder *responder;
// 上一个控件的位置
@property (nonatomic, strong, readonly) NSIndexPath *indexPathForPreviousResponder;
// 下一个控件的位置
@property (nonatomic, strong, readonly) NSIndexPath *indexPathForNextResponder;

@property (nonatomic, assign) NSInteger rowIndex;
@property (nonatomic, assign) NSInteger sectionIndex;
@property (nonatomic, assign, readonly) NBTableViewCellType type;

///-----------------------------
/// @name Handling Cell Events
///-----------------------------

- (void)cellDidLoad; 
- (void)cellWillAppear;
- (void)cellDidDisappear;

+ (CGFloat)tableView:(UITableView*)tableView heightForRowByItem:(NBTableViewItem*)item;

- (void)updateActionBarNavigationControl;
- (void)layoutDetailView:(UIView *)view;
+ (BOOL)canFocusWithItem:(NBTableViewItem *)item;

@end
