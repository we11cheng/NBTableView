//
//  NBTextViewCell.m
//  LawMonkey
//
//  Created by 刘彬 on 16/4/23.
//  Copyright © 2016年 AiFa. All rights reserved.
//

#import "NBTextViewCell.h"

@implementation NBTextViewItem

- (id)initWithDefault {
    self = [super initWithDefault];
    if (self) {
        self.cellClass          = [NBTextViewCell class];
        self.selectionStyle     = UITableViewCellSelectionStyleNone;
        self.hiddenSeparateLine = YES;
        self.editEnable         = YES;
        self.textFont           = Normal_Font;
    }
    return self;
}

@end

@interface NBTextViewCell ()

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) NBTextViewItem *cellItem;

@end

@implementation NBTextViewCell

+ (BOOL)canFocusWithItem:(NBTableViewItem *)item{
    NBTextViewItem *cellItem = (NBTextViewItem *)item;
    return cellItem.editEnable;
}

- (void)cellDidLoad
{
    [super cellDidLoad];

    [self.contentView addSubview:self.textView];
}

- (void)cellWillAppear{
    [super cellWillAppear];
    self.cellItem = (NBTextViewItem*)self.item;
    
    self.textView.text                          = self.cellItem.value;
    self.textView.font                          = self.cellItem.textFont;
    self.textView.keyboardType                  = self.cellItem.keyboardType;
    self.textView.keyboardAppearance            = self.cellItem.keyboardAppearance;
    self.textView.returnKeyType                 = self.cellItem.returnKeyType;
    self.textView.editable                      = self.cellItem.editEnable;
    self.textView.nb_placeholder = self.cellItem.placeholder;
    self.actionBar.barStyle = self.cellItem.keyboardAppearance == UIKeyboardAppearanceAlert ? UIBarStyleBlack : UIBarStyleDefault;
    
}

- (UIResponder *)responder {
    return self.textView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected) {
        [self.textView becomeFirstResponder];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = self.contentView.bounds;
}

#pragma mark Text field events

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSIndexPath *indexPath = [self indexPathForNextResponder];
    if (indexPath) {
        textView.returnKeyType = UIReturnKeyNext;
    } else {
        textView.returnKeyType = self.cellItem.returnKeyType;
    }
    [self updateActionBarNavigationControl];
    [self.parentTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.rowIndex inSection:self.sectionIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (self.cellItem.onBeginEditing) {
        self.cellItem.onBeginEditing(self.cellItem);
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if (self.cellItem.onEndEditing)
        self.cellItem.onEndEditing(self.cellItem);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    BOOL shouldChange = YES;
    
    if (self.cellItem.charactersLimit) {
        NSUInteger newLength = textView.text.length + text.length - range.length;
        shouldChange = newLength <= self.cellItem.charactersLimit;
    }
    
    if (self.cellItem.onChangeCharacterInRange && shouldChange)
        shouldChange = self.cellItem.onChangeCharacterInRange(self.cellItem, range, text);
    
    return shouldChange;
}

- (void)textViewDidChange:(UITextView *)textView{
    if (self.cellItem.charactersLimit && textView.text.length > self.cellItem.charactersLimit) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0, self.cellItem.charactersLimit)];
    }
    self.self.cellItem.value = textView.text;
    if (self.cellItem.onChange) {
        self.cellItem.onChange(self.cellItem);
    }
}

#pragma mark - getter & setter
- (UITextView *)textView {
    if (_textView == nil) {
        _textView                    = [[UITextView alloc] init];
        _textView.textColor          = COLOR_NORMAL_TEXT;
        _textView.font               = Normal_Font;
        _textView.backgroundColor    = [UIColor clearColor];
        _textView.inputAccessoryView = self.actionBar;
        _textView.autoresizingMask   = UIViewAutoresizingFlexibleWidth;
        _textView.returnKeyType      = UIReturnKeyDone;
        _textView.contentInset       = UIEdgeInsetsMake(0, 0, 0, 0);
        _textView.delegate           = self;
    }
    return _textView;
}

@end
