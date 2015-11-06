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
    BOOL pOriginEnabled;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        pOriginEnabled = self.editable;
        self.editable = NO;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self p_setupHelper];
}
- (void)updateConstraints{
    [super updateConstraints];
}
#pragma mark - Methods
#pragma mark -- Private
- (void)p_setupHelper{
    [KFTextInputHelper setupHelperWithContainerView:self];
    if (pIsInit) {
        pIsInit = NO;
        self.editable = pOriginEnabled;
    }
}
#pragma mark - Setter & Getter | Lazy Config
#pragma mark -- Layer
- (void)setKfBorderColor:(UIColor *)mBorderColor{
    _kfBorderColor = mBorderColor;
    self.layer.borderColor = mBorderColor.CGColor;
}
- (void)setKfBorderWidth:(CGFloat)mBorderWidth{
    _kfBorderWidth = mBorderWidth;
    self.layer.borderWidth = mBorderWidth;
}

@end
