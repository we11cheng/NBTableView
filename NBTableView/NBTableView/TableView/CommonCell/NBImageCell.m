//
//  NBImageCell.m
//  LawMonkey
//
//  Created by 刘彬 on 16/7/31.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBImageCell.h"

@implementation NBImageItem

- (id)initWithDefault {
    self = [super initWithDefault];
    if (self) {
        self.cellClass      = [NBImageCell class];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.hiddenSeparateLine = YES;
    }
    return self;
}

@end

@interface NBImageCell ()

@property (nonatomic, strong) NBImageItem *cellItem;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation NBImageCell

- (void)cellDidLoad {
    [super cellDidLoad];
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}

- (void)cellWillAppear {
    [super cellWillAppear];
    self.cellItem = (NBImageItem*)self.item;
    if (![NSString nb_isEmpty:self.cellItem.imageName]) {
        self.imgView.image = [UIImage imageNamed:self.cellItem.imageName];
        self.imgView.size = self.imgView.image.size;
    }else{
        self.imgView.image = nil;
    }
}

+ (CGFloat)tableView:(UITableView *)tableView heightForRowByItem:(NBTableViewItem *)item{
    NBImageItem *cellItem = (NBImageItem*)item;
    if (![NSString nb_isEmpty:cellItem.imageName]) {
        return [UIImage imageNamed:cellItem.imageName].size.height;
    }else{
        return 0;
    }
}

#pragma mark - getter
- (UIImageView *)imgView{
    if (_imgView == nil){
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

@end
