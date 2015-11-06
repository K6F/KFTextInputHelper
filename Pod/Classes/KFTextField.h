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

IB_DESIGNABLE
@interface KFTextField : UITextField <UITextFieldDelegate>

#pragma mark - Layout
@property (nonatomic) IBInspectable UIColor  *kfBorderColor;
@property (nonatomic) IBInspectable UIColor  *kfFocusBorderColor;
@property (nonatomic) IBInspectable CGFloat  kfBorderWidth;

#pragma mark - Left SubView
@property (nonatomic) IBInspectable NSString *kfLeftText;
@property (nonatomic) IBInspectable UIColor  *kfLeftColor;
@property (nonatomic) IBInspectable UIColor  *kfLeftBackgroundColor;
@property (nonatomic) IBInspectable CGFloat  kfLeftWidth;
#pragma mark -- Border
@property (nonatomic) IBInspectable UIColor  *kfLeftBorderColor;
@property (nonatomic) IBInspectable CGFloat  kfLeftBorderWidth;

#pragma mark - Verify
/** TODO: add verify code */
@property (nonatomic) IBInspectable KFTextFieldVerifyType kfVerifyType;
@property (nonatomic) IBInspectable BOOL    kfVerifed;
@property (nonatomic) IBInspectable UIColor *kfVerifyPassedBorderColor;
@property (nonatomic) IBInspectable UIColor *kfVerifyFailedBorderColor;
@end

