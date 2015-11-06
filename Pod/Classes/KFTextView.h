//
//  KFTextView.h
//  SocialHillHotel_iOS
//
//  Created by K6F on 15/3/19.
//  Copyright (c) 2015年 TLTech. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE
@interface KFTextView : UITextView

#pragma mark - Layout
@property (nonatomic) IBInspectable UIColor  *kfBorderColor;
@property (nonatomic) IBInspectable UIColor  *kfFocusBorderColor;
@property (nonatomic) IBInspectable CGFloat  kfBorderWidth;

@end
