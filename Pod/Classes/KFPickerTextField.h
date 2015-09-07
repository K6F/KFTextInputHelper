//
//  KFPickerTextField.h
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KFTextField.h"

typedef void(^KFTextFieldCompletionBlock)(NSInteger row,NSInteger component);

@interface KFPickerTextField : KFTextField
@property (nonatomic) NSUInteger selectedIndex;
@property (nonatomic,assign) CGPoint rectInsetPoint; // default is (10, 5)
@property (nonatomic,assign) NSInteger maxTextLength; // default is  140
@property (nonatomic,assign) id<UIPickerViewDataSource> pickerDataSource;
@property (nonatomic,assign) id <UIPickerViewDelegate>  pickerDelegate;

-(void)setPickerItems:(NSArray *)pickerItems;
-(void)setPickerItems:(NSArray *)pickerItems completion:(KFTextFieldCompletionBlock) completion;
@end
