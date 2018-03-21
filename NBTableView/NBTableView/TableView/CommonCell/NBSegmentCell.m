//
//  NBSegmentCell.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/31.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBSegmentCell.h"

@implementation NBSegmentItem

- (id)initWithDefault {
    self = [super initWithDefault];
    if (self) {
        self.cellClass          = [NBSegmentCell class];
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        self.hiddenSeparateLine = YES;
    }
    return self;
}

@end

@interface NBSegmentCell ()

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) NBSegmentItem *cellItem;

@end

@implementation NBSegmentCell

- (void)cellDidLoad {
    [super cellDidLoad];
    [self.contentView addSubview:self.segmentedControl];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    self.cellItem = (NBSegmentItem*)self.item;
    [self.segmentedControl removeAllSegments];
    if (self.cellItem.segmentedControlTitles.count > 0) {
        [self.cellItem.segmentedControlTitles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithTitle:title atIndex:idx animated:NO];
        }];
    } else if (self.cellItem.segmentedControlImages.count > 0) {
        [self.cellItem.segmentedControlImages enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
            [self.segmentedControl insertSegmentWithImage:image atIndex:idx animated:NO];
        }];
    }
    self.segmentedControl.tintColor = self.cellItem.tintColor;
    self.segmentedControl.selectedSegmentIndex = self.cellItem.value;
    [self.segmentedControl setNeedsDisplay];
}

- (void)cellDidDisappear {
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutDetailView:self.segmentedControl];
    
    self.segmentedControl.nb_height = self.nb_height;//-2*kNormalPadding;
    self.segmentedControl.nb_width = self.contentView.nb_width-self.segmentedControl.nb_left*2;
    self.segmentedControl.nb_centerY = self.contentView.nb_centerY;
}

- (void)segmentValueDidChange:(UISegmentedControl *)segmentedControlView {
    self.cellItem.value = segmentedControlView.selectedSegmentIndex;
    if (self.cellItem.switchValueChangeHandler) {
        self.cellItem.switchValueChangeHandler(self.cellItem);
    }
}

- (UISegmentedControl *)segmentedControl {
    if (_segmentedControl == nil) {
        _segmentedControl = [[UISegmentedControl alloc] init];
        [_segmentedControl addTarget:self action:@selector(segmentValueDidChange:) forControlEvents:UIControlEventValueChanged];

    }
    return _segmentedControl;
}

@end
