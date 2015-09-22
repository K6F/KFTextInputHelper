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
    BOOL pIsInit;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        self.editable = NO;
    }
    return self;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (pIsInit) {
        pIsInit = NO;
        self.editable = YES;
    }
    [KFTextInputHelper setupHelperWithContainerView:self];
}

@end
