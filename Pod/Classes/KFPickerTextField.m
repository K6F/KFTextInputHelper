//
//  KFPickerTextField.m
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//

#import "KFPickerTextField.h"
#import "KFTextInputHelper.h"

@interface KFPickerTextField () <UIPickerViewDelegate, UIPickerViewDataSource>{
    KFTextFieldCompletionBlock pCompletionBlock;
}
@property (nonatomic) NSArray* items;
@property (nonatomic, strong) UIPickerView *pPickerView;
@end



@implementation KFPickerTextField
@synthesize items,selectedIndex;

-(void)setPickerItems:(NSArray *)mPickerItems{
    [self setPickerItems:mPickerItems andSelect:0];
}
-(void)setPickerItems:(NSArray *)mPickerItems completion:(KFTextFieldCompletionBlock)mCompletion{
    pCompletionBlock = mCompletion;
    [self setPickerItems:mPickerItems];
}
-(void)setPickerItems:(NSArray *)pickerItems andSelect:(NSUInteger) idx{
    self.items = pickerItems;
    [self kf_reloadDate];
    if (pickerItems && pickerItems.count > 0) {
        // 数组含有有效值
        self.selectedIndex = idx;
        self.text = [self.items objectAtIndex:0];
    }
}
- (void)kf_reloadDate{
    [self.pPickerView reloadAllComponents];
}
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [KFTextInputHelper helperInContainerView:self];
    if (![self.inputView isKindOfClass:[UIPickerView class]]) {
        self.inputView = self.pPickerView;
    }
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
//- (UIView *)pickerView:(UIPickerView *)pickerView
//            viewForRow:(NSInteger)row
//          forComponent:(NSInteger)component
//           reusingView:(UIView *)view {
//    if ([self.pickerDelegate respondsToSelector:@selector(pickerView:viewForRow:forComponent:reusingView:)]) {
//        return [self.pickerDelegate pickerView:pickerView viewForRow:row forComponent:component reusingView:view];
//    }
//    UILabel *lblTitle = [[UILabel alloc] init];
//    lblTitle.frame = CGRectMake(0, 0,self.superview.bounds.size.width, 32);
//    lblTitle.textAlignment = NSTextAlignmentCenter;
//    lblTitle.backgroundColor = [UIColor clearColor];
//    lblTitle.text = [self.items objectAtIndex:row];
//    return lblTitle;
//}

-(void)pickerView:(UIPickerView *)pickerView
     didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component{
    self.selectedIndex = row;
    self.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    if (pCompletionBlock) {
        pCompletionBlock(row,component);
    }
}

- (BOOL)validate{
    self.backgroundColor = [UIColor colorWithRed:255 green:0 blue:0 alpha:0.5];  
    [self setBackgroundColor:[UIColor whiteColor]];
    return YES;
}

#pragma mark - UITextField inputView help
- (UIPickerView *)pPickerView {
    if (!_pPickerView) {
        _pPickerView = [[UIPickerView alloc] init];
        _pPickerView.delegate = self;
        _pPickerView.dataSource = self;
    }
    return _pPickerView;
}

@end
