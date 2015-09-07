//
//  KFTextField.h
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, KFTextFieldVerifyType) {
    KFTextFieldNoVerify =0,
    KFTextFieldNickname,
    KFTextFieldNumberic,
    KFTextFieldEmail
};


@interface KFTextField : UITextField <UITextFieldDelegate>

#pragma mark - Left View
@property (nonatomic) NSNumber* kfLeftLabelWidth;
@property (nonatomic) NSString* kfLeftLabelText;
@property (nonatomic) UIColor*  kfLeftLabelBackgroundColor;
/** Border config for left view */
@property (nonatomic) NSNumber* kfLeftLabelBorderWidth;
@property (nonatomic) UIColor * kfLeftLabelBorderColor;

#pragma mark - Verify
/** TODO: add verify code */

@property (nonatomic) UIColor *kfBorderColor;
@property (nonatomic) UIColor *kfInCorrectBorderColor;
@property (nonatomic) BOOL kfIsCorrect;
@property (nonatomic) KFTextFieldVerifyType kfVerifyType;
@end

