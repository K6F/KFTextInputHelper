//
//  KFPickerField.m
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//

#import "KFPickerField.h"
#import "KFTextInputHelper.h"

@interface KFPickerField () <UIPickerViewDelegate, UIPickerViewDataSource>{
    KFTextFieldSelectBlock pCompletionBlock;
}
@property (nonatomic) NSArray* items;
@property (nonatomic, strong) UIPickerView *pPickerView;
@property (nonatomic, weak)KFTextInputHelper *pInputHelper;
@end



@implementation KFPickerField
@synthesize items,selectedIndex;
#pragma mark - Public Methods
-(void)setPickerItems:(NSArray *)mPickerItems{
    self.items = mPickerItems;
}
-(void)setPickerItems:(NSArray *)mPickerItems
            andSelect:(NSUInteger)mIndex{
    self.items = mPickerItems;
    [self kf_reloadDate];
    if (mPickerItems && mPickerItems.count > mIndex) {
        // 数组含有有效值
        self.selectedIndex = mIndex;
        self.text = [self.items objectAtIndex:0];
    }
}
-(void)setPickerItems:(NSArray *)mPickerItems
           completion:(KFTextFieldSelectBlock)mCompletion{
    pCompletionBlock = mCompletion;
    [self setPickerItems:mPickerItems];
}
-(void)setPickerItems:(NSArray *)mPickerItems
           completion:(KFTextFieldSelectBlock)mCompletion
            andSelect:(NSUInteger)mIndex{
    pCompletionBlock = mCompletion;
    [self setPickerItems:mPickerItems andSelect:mIndex];
}
- (void)kf_reloadDate{
    [self.pPickerView reloadAllComponents];
}
#pragma mark - Init

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [KFTextInputHelper setupHelperWithContainerView:self];
    if (![self.inputView isKindOfClass:[UIPickerView class]]) {
        self.inputView = self.pPickerView;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UIPickerViewDataSource
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([self.pickerDataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.pickerDataSource pickerView:pickerView numberOfRowsInComponent:component];
    }
    return self.items.count;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if ([self.pickerDataSource  respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [self.pickerDataSource numberOfComponentsInPickerView:pickerView];
    }
    return 1;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)mPickerView titleForRow:(NSInteger)mRow forComponent:(NSInteger)mComponent{
    if ([self.pickerDelegate  respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [self.pickerDelegate pickerView:mPickerView titleForRow:mRow forComponent:mComponent];
    }
    return self.items[mRow];
}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    self.selectedIndex = row;
    self.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    if (pCompletionBlock) {
        pCompletionBlock(row,component);
    }
    if ([self.pickerDelegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]) {
        [self.pickerDelegate pickerView:pickerView didSelectRow:row inComponent:component];
    }
}

- (BOOL)validate{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];  
    [self setBackgroundColor:[UIColor whiteColor]];
    return YES;
}
#pragma mark - Private methods
- (void)p_keyboardWasShown:(NSNotification*)aNotification{
    KFTextInputHelper *mHelper = [KFTextInputHelper helperWithContainerView:self];
    if (![mHelper.kfCurrentFirstResponder isEqual:self]) return;
    [self pickerView:self.pPickerView didSelectRow:self.selectedIndex inComponent:0];
}


#pragma mark - Setter & Getter
- (UIPickerView *)pPickerView {
    if (!_pPickerView) {
        _pPickerView = [[UIPickerView alloc] init];
        _pPickerView.delegate = self;
        _pPickerView.dataSource = self;
    }
    return _pPickerView;
}

@end
