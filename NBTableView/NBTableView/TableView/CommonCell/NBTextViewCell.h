//
//  NBTextViewCell.h
//  LawMonkey
//
//  Created by 刘彬 on 16/4/23.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTableViewCell.h"

@interface NBTextViewItem : NBTableViewItem

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, assign) NSUInteger charactersLimit;

// default is UIKeyboardTypeDefault
@property (nonatomic, assign) UIKeyboardType keyboardType;
// default is UIKeyboardAppearanceDefault
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;
// default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property (nonatomic, assign) UIReturnKeyType returnKeyType;

@property (nonatomic, assign) BOOL editEnable;

@property (nonatomic, copy) void (^onBeginEditing)(NBTextViewItem *item);
@property (nonatomic, copy) void (^onEndEditing)(NBTextViewItem *item);
@property (nonatomic, copy) void (^onChange)(NBTextViewItem *item);
@property (nonatomic, copy) BOOL (^onChangeCharacterInRange)(NBTextViewItem *item, NSRange range, NSString *replacementString);

@end

@interface NBTextViewCell : NBTableViewCell<UITextViewDelegate>

@end
