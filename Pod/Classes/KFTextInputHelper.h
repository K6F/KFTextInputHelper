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
@end

@interface KFTextInputHelper : NSObject
+ (instancetype)helperWithContainerView:(UIView *)mContainerView;
- (instancetype)initWithContainerView:(UIView *)mContainerView;

@end