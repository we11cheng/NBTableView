//
//  NBImageCell.h
//  LawMonkey
//
//  Created by 刘彬 on 16/7/31.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTableViewCell.h"

@interface NBImageItem : NBTableViewItem

@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, strong) NSString *imageURL;

@end

@interface NBImageCell : NBTableViewCell

@end
