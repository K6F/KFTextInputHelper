//
//  KFTextInputHelper.h
//  SocialHillHotel_iOS
//
//  Created by K6F on 15/3/19.
//  Copyright (c) 2015年 TLTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class KFTextInputHelper;
@interface UIView (KFTextInputHelper)
@property (atomic, retain)KFTextInputHelper *kfInputViewHelper;
@property (nonatomic, readonly)UIViewController *kfParentViewController;
@end

@interface KFTextInputHelper : NSObject
/** setup helper */
+ (void)setupHelperWithContainerView:(UIView *)mContainerView;
/** get helper instance */
+ (instancetype)helperWithContainerView:(UIView *)mContainerView;
- (instancetype)initWithContainerView:(UIView *)mContainerView;
/** setup id<UIInput> in containerView */
- (void)reloadInputs;

@property (weak, nonatomic) id kfCurrentFirstResponder;
@end