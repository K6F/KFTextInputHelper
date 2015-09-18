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
+ (void)helperInContainerView:(UIView *)mContainerView;
- (instancetype)initWithContainerView:(UIView *)mContainerView;
@end
@interface KFTextInputHelper(Deprecated)
+ (instancetype)helperWithContainerView:(UIView *)mContainerView __deprecated_msg("Method deprecated in 0.2.0 User `helperInContainerView:`");
@end