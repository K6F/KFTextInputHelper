//
//  KFTextView.m
//  SocialHillHotel_iOS
//
//  Created by K6F on 15/3/19.
//  Copyright (c) 2015年 TLTech. All rights reserved.
//

#import "KFTextView.h"
#import "KFTextInputHelper.h"
@implementation KFTextView{
    KFTextInputHelper *_kfInputHelper;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (!self.superview.kfInputViewHelper)
        self.superview.kfInputViewHelper = [KFTextInputHelper helperWithContainerView:self.superview];
}

@end
