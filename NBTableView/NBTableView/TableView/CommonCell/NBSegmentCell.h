//
//  NBSegmentCell.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/31.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTableViewCell.h"

@interface NBSegmentItem : NBTableViewItem

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, copy) NSArray *segmentedControlTitles;
@property (nonatomic, copy) NSArray *segmentedControlImages;
@property (nonatomic, strong) UIColor *tintColor;
@property (nonatomic, copy) void (^switchValueChangeHandler)(NBSegmentItem *item);

@end

@interface NBSegmentCell : NBTableViewCell

@end
