//
//  NBTextFieldCell.m
//  LawMonkey
//
//  Created by 刘彬 on 16/3/26.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTextFieldCell.h"

@implementation NBTextFieldItem

- (id)initWithDefault {
    self = [super initWithDefault];
    if (self) {
        self.cellClass      = [NBTextFieldCell class];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.editEnable     = YES;
        self.texeColor      = self.titleColor;
        self.tetxFont       = self.titleFont;
    }
    return self;
}

@end

@interface NBTextFieldCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NBTextFieldItem *cellItem;

@end

@implementation NBTextFieldCell

+ (BOOL)canFocusWithItem:(NBTableViewItem *)item{
    NBTextFieldItem *cellItem = (NBTextFieldItem *)item;
    return cellItem.editEnable;
}

- (void)cellDidLoad
{
    [super cellDidLoad];
    [self.contentView addSubview:self.textField];
}

- (void)cellWillAppear{
    [super cellWillAppear];
    self.cellItem = (NBTextFieldItem*)self.item;

    self.textField.text                          = self.cellItem.value;
    self.textField.placeholder                   = self.cellItem.placeholder;
    self.textField.font                          = self.cellItem.titleFont;
    self.textField.autocapitalizationType        = self.cellItem.autocapitalizationType;
    self.textField.autocorrectionType            = self.cellItem.autocorrectionType;
    self.textField.spellCheckingType             = self.cellItem.spellCheckingType;
    self.textField.keyboardType                  = self.cellItem.keyboardType;
    self.textField.keyboardAppearance            = self.cellItem.keyboardAppearance;
    self.textField.returnKeyType                 = self.cellItem.returnKeyType;
    self.textField.enablesReturnKeyAutomatically = self.cellItem.enablesReturnKeyAutomatically;
    self.textField.secureTextEntry               = self.cellItem.secureTextEntry;
    self.textField.clearButtonMode               = self.cellItem.clearButtonMode;
    self.textField.clearsOnBeginEditing          = self.cellItem.clearsOnBeginEditing;
    self.textField.enabled                       = self.cellItem.editEnable;
    self.textField.textColor                     = self.cellItem.texeColor ? self.cellItem.texeColor :  self.cellItem.titleColor;
    [self.textField setValue:self.cellItem.placeholderColor ? self.cellItem.placeholderColor :  COLOR_COMMON_NORMAL_TEXT forKeyPath:@"_placeholderLabel.textColor"];
        self.actionBar.barStyle = self.cellItem.keyboardAppearance == UIKeyboardAppearanceAlert ? UIBarStyleBlack : UIBarStyleDefault;
    
}

- (UIResponder *)responder {
    return self.textField;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.textField becomeFirstResponder];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self layoutDetailView:self.textField];
}

#pragma mark Text field events

- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.cellItem.charactersLimit && textField.text.length > self.cellItem.charactersLimit) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.cellItem.charactersLimit)];
    }
    self.cellItem.value = textField.text;
    if (self.cellItem.onChange) {
        self.cellItem.onChange(self.cellItem);
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = self.cellItem.returnKeyType;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (self.cellItem.onBeginEditing) {
        self.cellItem.onBeginEditing(self.cellItem);
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (self.cellItem.onEndEditing)
        self.cellItem.onEndEditing(self.cellItem);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.cellItem.onReturn)
        self.cellItem.onReturn(self.cellItem);
    if (self.cellItem.onEndEditing)
        self.cellItem.onEndEditing(self.cellItem);
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (!indexPath) {
        [self endEditing:YES];
        return YES;
    }
    NBTableViewCell *cell = (NBTableViewCell *)[self.parentTableView cellForRowAtIndexPath:indexPath];
    [cell.responder becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL shouldChange = YES;
    
    if (self.cellItem.charactersLimit) {
        NSUInteger newLength = textField.text.length + string.length - range.length;
        shouldChange = newLength <= self.cellItem.charactersLimit;
    }
    
    if (self.cellItem.onChangeCharacterInRange && shouldChange)
        shouldChange = self.cellItem.onChangeCharacterInRange(self.cellItem, range, string);
    
    return shouldChange;
}

#pragma mark - getter & setter
- (UITextField *)textField {
    if (_textField == nil) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _textField.inputAccessoryView = self.actionBar;
        _textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _textField;
}

@end
