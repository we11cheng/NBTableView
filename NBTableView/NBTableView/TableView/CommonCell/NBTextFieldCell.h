//
//  NBTextFieldCell.h
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTableViewCell.h"

@interface NBTextFieldItem : NBTableViewItem

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, strong) UIColor *texeColor;
@property (nonatomic, strong) UIFont *tetxFont;
@property (nonatomic, strong) UIColor *placeholderColor;

// default is UITextFieldViewModeNever
@property (nonatomic, assign) UITextFieldViewMode clearButtonMode;
// default is NO
@property (nonatomic, assign) BOOL clearsOnBeginEditing;
@property (nonatomic, assign) NSUInteger charactersLimit;
// default is UITextAutocapitalizationTypeSentences
@property (nonatomic, assign) UITextAutocapitalizationType autocapitalizationType;
// default is UITextAutocorrectionTypeDefault
@property (nonatomic, assign) UITextAutocorrectionType autocorrectionType;
// default is UITextSpellCheckingTypeDefault;
@property (nonatomic, assign) UITextSpellCheckingType spellCheckingType NS_AVAILABLE_IOS(5_0);
// default is UIKeyboardTypeDefault
@property (nonatomic, assign) UIKeyboardType keyboardType;
// default is UIKeyboardAppearanceDefault
@property (nonatomic, assign) UIKeyboardAppearance keyboardAppearance;
// default is UIReturnKeyDefault (See note under UIReturnKeyType enum)
@property (nonatomic, assign) UIReturnKeyType returnKeyType;
// default is NO (when YES, will automatically disable return key when text widget has zero-length contents, and will automatically enable when text widget has non-zero-length contents)
@property (nonatomic, assign) BOOL enablesReturnKeyAutomatically;
// default is NO
@property (nonatomic, assign) BOOL secureTextEntry;
@property (nonatomic, assign) BOOL editEnable;

@property (nonatomic, copy) void (^onBeginEditing)(NBTextFieldItem *item);
@property (nonatomic, copy) void (^onEndEditing)(NBTextFieldItem *item);
@property (nonatomic, copy) void (^onChange)(NBTextFieldItem *item);
@property (nonatomic, copy) void (^onReturn)(NBTextFieldItem *item);
@property (nonatomic, copy) BOOL (^onChangeCharacterInRange)(NBTextFieldItem *item, NSRange range, NSString *replacementString);


@end

@interface NBTextFieldCell : NBTableViewCell<UITextFieldDelegate>

@end
