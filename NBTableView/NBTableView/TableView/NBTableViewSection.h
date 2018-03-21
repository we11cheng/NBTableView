//
//  NBTableViewSection.h
//  NBTableView
//
//  Created by 刘彬 on 16/3/11.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NBTableViewCellStyle.h"

@class NBTableViewAdaptor;
@class NBTableViewItem;

extern CGFloat const NBTableViewSectionHeaderHeightAutomatic;
extern CGFloat const NBTableViewSectionFooterHeightAutomatic;

@interface NBTableViewSection : NSObject

// item集合，只读，如需操作item请调用实例方法，好处是可以保证类型安全
@property (nonatomic, strong, readonly) NSArray<NBTableViewItem*> *items;
// 头部标题
@property (nonatomic, copy            ) NSString           *headerTitle;
// 底部标题
@property (nonatomic, copy            ) NSString           *footerTitle;
// 头部高度
@property (nonatomic, assign          ) CGFloat            headerHeight;
// 底部高度
@property (nonatomic, assign          ) CGFloat            footerHeight;
// 头部自定义view
@property (nonatomic, strong          ) UIView             *headerView;
// 底部自定义View
@property (nonatomic, strong          ) UIView             *footerView;
// 索引title
@property (nonatomic, copy            ) NSString           *indexTitle;
// cell的默认样式
@property (nonatomic, strong          ) NBTableViewCellStyle *cellStyle;
// tableview数据适配器
@property (nonatomic, weak            ) NBTableViewAdaptor *tableViewAdaptor;
// 在tableView中的位置
@property (nonatomic, assign, readonly) NSUInteger         indexAtTableView;

///-----------------------------
/// @name Initializes Methoh
///-----------------------------
+ (instancetype)section;

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle;

+ (instancetype)sectionWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

+ (instancetype)sectionWithHeaderView:(UIView *)headerView;

+ (instancetype)sectionWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

- (id)initWithHeaderTitle:(NSString *)headerTitle;

- (id)initWithHeaderTitle:(NSString *)headerTitle footerTitle:(NSString *)footerTitle;

- (id)initWithHeaderView:(UIView *)headerView;

- (id)initWithHeaderView:(UIView *)headerView footerView:(UIView *)footerView;

///-----------------------------
/// @name Add Item Methoh
///-----------------------------
- (void)addItem:(NBTableViewItem *)item;

- (void)addItemsFromArray:(NSArray<NBTableViewItem *> *)array;

- (void)insertItem:(NBTableViewItem *)item atIndex:(NSUInteger)index;

- (void)insertItems:(NSArray<NBTableViewItem *> *)items atIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Remove Item Method
///-----------------------------
- (void)removeItem:(NBTableViewItem *)item;

- (void)removeAllItems;

- (void)removeItemIdenticalTo:(NBTableViewItem *)item inRange:(NSRange)range;

- (void)removeItemIdenticalTo:(NBTableViewItem *)item;

- (void)removeItemsInArray:(NSArray<NBTableViewItem *> *)otherArray;

- (void)removeItemsInRange:(NSRange)range;

- (void)removeItem:(NBTableViewItem *)item inRange:(NSRange)range;

- (void)removeLastItem;

- (void)removeItemAtIndex:(NSUInteger)index;

- (void)removeItemsAtIndexes:(NSIndexSet *)indexes;

///-----------------------------
/// @name Replace Item Method
///-----------------------------
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(NBTableViewItem *)item;

- (void)replaceItemsWithItemsFromArray:(NSArray<NBTableViewItem *> *)otherArray;

- (void)replaceItemsAtIndexes:(NSIndexSet *)indexes withItems:(NSArray<NBTableViewItem *> *)items;

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<NBTableViewItem *> *)otherArray range:(NSRange)otherRange;

- (void)replaceItemsInRange:(NSRange)range withItemsFromArray:(NSArray<NBTableViewItem *> *)otherArray;

///-----------------------------
/// @name Exchange Item
///-----------------------------
- (void)exchangeItemAtIndex:(NSUInteger)idx1 withItemAtIndex:(NSUInteger)idx2;

///-----------------------------
/// @name Sort Item
///-----------------------------
- (void)sortItemsUsingFunction:(NSInteger (*)(NBTableViewItem *item1, NBTableViewItem *item2, void *))compare context:(void *)context;

- (void)sortItemsUsingSelector:(SEL)comparator;

- (void)reloadSectionWithAnimation:(UITableViewRowAnimation)animation;

@end
