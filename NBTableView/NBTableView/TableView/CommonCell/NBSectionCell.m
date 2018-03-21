//
//  NBSectionCell.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/19.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBSectionCell.h"

@implementation NBSectionCellItem

+ (instancetype)section {
    NBSectionCellItem *item = [[NBSectionCellItem alloc] initWithDefault];
    item.cellHeight = 12;
    return item;
}

- (id)initWithDefault {
    self = [super initWithDefault];
    if (self) {
        self.cellClass              = [NBSectionCell class];
        self.backgroundColor        = COLOR_TABLE_SECTION;
        self.hiddenSeparateLine     = NO;
        self.titleFont                   = Normal_Font;
        self.titleColor                  = COLOR_NORMAL_TEXT;
        self.textAlignment          = NSTextAlignmentLeft;
        self.userInteractionEnabled = NO;
    }
    
    return self;
}

@end

@interface NBSectionCell ()

@end

@implementation NBSectionCell

- (void)cellDidLoad {
    [super cellDidLoad];
}

- (void)cellWillAppear {
    [super cellWillAppear];
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowByItem:(NBTableViewItem *)item {
    NBSectionCellItem *celltem = (NBSectionCellItem*)item;
    if (celltem.cellHeight > 0) {
        return item.cellHeight;
    }
    if (![NSString nb_isEmpty:celltem.title]) {
        return 2*kNormalPadding + celltem.titleFont.lineHeight;
    }
    return 10;
}

- (void)cellDidDisappear {
}

@end
