//
//  NBTableViewCellStyle.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/27.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTableViewCellStyle.h"

@interface NBTableViewCellStyle ()

@end

@implementation NBTableViewCellStyle

- (id)init {
    self = [super init];
    if (!self)
        return nil;
    
    self.backgroundImages = [[NSMutableDictionary alloc] init];
    self.selectedBackgroundImages = [[NSMutableDictionary alloc] init];
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    NBTableViewCellStyle *style = [[self class] allocWithZone:zone];
    if (style) {
        style.cellHeight                = self.cellHeight;
        style.contentViewMargin         = self.contentViewMargin;
        style.backgroundImageMargin     = self.backgroundImageMargin;

        style.backgroundColor           = self.backgroundColor;
        style.selectedBackgroundColor   = self.selectedBackgroundColor;

        style.backgroundImages          = [NSMutableDictionary dictionaryWithDictionary:[self.backgroundImages copyWithZone:zone]];
        style.selectedBackgroundImages  = [NSMutableDictionary dictionaryWithDictionary:[self.selectedBackgroundImages copyWithZone:zone]];
        style.separateLineColor         = self.separateLineColor;
        style.separateLineHeight        = self.separateLineHeight;
        style.separateLineLeftPadding   = self.separateLineLeftPadding;
        style.separateLineRightPadding  = self.separateLineRightPadding;
    }
    return style;
}

- (BOOL)hasCustomBackgroundImage
{
    return [self backgroundImageForCellType:NBTableViewCellTypeAny]
    || [self backgroundImageForCellType:NBTableViewCellTypeFirst]
    || [self backgroundImageForCellType:NBTableViewCellTypeMiddle]
    || [self backgroundImageForCellType:NBTableViewCellTypeLast]
    || [self backgroundImageForCellType:NBTableViewCellTypeSingle];
}

- (UIImage *)backgroundImageForCellType:(NBTableViewCellType)cellType
{
    UIImage *image = [self.backgroundImages objectForKey:@(cellType)];
    if (!image && cellType != NBTableViewCellTypeAny) {
        image = [self.backgroundImages objectForKey:@(NBTableViewCellTypeAny)];
    }
    return image;
}

- (void)setBackgroundImage:(UIImage *)image forCellType:(NBTableViewCellType)cellType
{
    if (image) {
        [self.backgroundImages setObject:image forKey:@(cellType)];
    }
}

- (BOOL)hasCustomSelectedBackgroundImage
{
    return [self selectedBackgroundImageForCellType:NBTableViewCellTypeAny]
    ||[self selectedBackgroundImageForCellType:NBTableViewCellTypeFirst]
    || [self selectedBackgroundImageForCellType:NBTableViewCellTypeMiddle]
    || [self selectedBackgroundImageForCellType:NBTableViewCellTypeLast]
    || [self selectedBackgroundImageForCellType:NBTableViewCellTypeSingle];
}

- (UIImage *)selectedBackgroundImageForCellType:(NBTableViewCellType)cellType
{
    UIImage *image = [self.selectedBackgroundImages objectForKey:@(cellType)];
    if (!image && cellType != NBTableViewCellTypeAny) {
        image = [self.selectedBackgroundImages objectForKey:@(NBTableViewCellTypeAny)];
    }
    return image;
}

- (void)setSelectedBackgroundImage:(UIImage *)image forCellType:(NBTableViewCellType)cellType
{
    if (image) {
        [self.selectedBackgroundImages setObject:image forKey:@(cellType)];
    }
}

@end
