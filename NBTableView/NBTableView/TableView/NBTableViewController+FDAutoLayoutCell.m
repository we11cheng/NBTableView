//
//  NBTableViewController+FDAutoLayoutCell.m
//  NBTableView
//
//  Created by 刘彬 on 16/3/12.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NBTableViewController+FDAutoLayoutCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "NBTableViewCell.h"

typedef NS_ENUM(NSInteger, FDSimulatedCacheMode) {
    FDSimulatedCacheModeNone = 0,
    FDSimulatedCacheModeCacheByIndexPath,
    FDSimulatedCacheModeCacheByKey
};

@implementation NBTableViewController (FDAutoLayoutCell)

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NBTableViewSection *section = [self.tableViewAdaptor.sections objectAtIndex:indexPath.section];
    NBTableViewItem *item = [section.items objectAtIndex:indexPath.row];
    FDSimulatedCacheMode mode = FDSimulatedCacheModeCacheByIndexPath;
    NSString *cellIdentifier = [self identifierForCellAtIndexPath:indexPath];
    switch (mode) {
        case FDSimulatedCacheModeNone:
            return [tableView fd_heightForCellWithIdentifier:cellIdentifier configuration:^(NBTableViewCell *cell) {
                [cell cellDidLoad];
                cell.item = item;
                [cell cellWillAppear];
            }];
        case FDSimulatedCacheModeCacheByIndexPath:
            return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByIndexPath:indexPath configuration:^(NBTableViewCell *cell) {
                [cell cellDidLoad];
                cell.item = item;
                [cell cellWillAppear];
            }];
        case FDSimulatedCacheModeCacheByKey: {
            return [tableView fd_heightForCellWithIdentifier:cellIdentifier cacheByKey:[NSString stringWithFormat:@"%@,%ld",cellIdentifier,(long)(indexPath.section+indexPath.row)] configuration:^(NBTableViewCell *cell) {
                [cell cellDidLoad];
                cell.item = item;
                [cell cellWillAppear];
            }];
        };
        default:
            break;
    }
}

- (NSString *)identifierForCellAtIndexPath:(NSIndexPath *)indexPath{
    NBTableViewSection *section = [self.tableViewAdaptor.sections objectAtIndex:indexPath.section];
    NBTableViewItem *item       = [section.items objectAtIndex:indexPath.row];
    NSString *cellIdentifier    = [NSString stringWithFormat:@"NBTableViewAdaptor_%@", [item class]];
    if ([item respondsToSelector:@selector(cellIdentifier)] && item.cellIdentifier) {
        cellIdentifier = item.cellIdentifier;
    }
    return cellIdentifier;
}

@end
