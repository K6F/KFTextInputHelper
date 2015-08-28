//
//  KFTextField.m
//  test001
//
//  Created by Fan.Khiyuan on 14-9-5.
//  Copyright (c) 2014年 K6F. All rights reserved.
//
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


#import "KFTextField.h"
#import "KFTextInputHelper.h"

@interface KFTextField()
@property (nonatomic) UILabel *pLeftLabel;

@end

@implementation KFTextField{
    CGColorRef originalBorderColor;
    float originalBorderWidth;
    KFTextInputHelper * _kfInputHelper;
    BOOL pIsInit;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        self.enabled = NO;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (pIsInit) {
        pIsInit = NO;
        self.enabled = YES;
    }
    
    if (!self.superview.kfInputViewHelper)
        self.superview.kfInputViewHelper = [KFTextInputHelper helperWithContainerView:self.superview];
}

- (void)layoutSubviews{
    [self p_drawLeftLabel];
}

#pragma mark - methods

- (void)p_drawLeftLabel{
    
    // Left label
    if (!_pLeftLabel) return;
    if (self.leftViewBackgroundcolor) {
        self.pLeftLabel.backgroundColor = self.leftViewBackgroundcolor;
    }
    // Border width
    float mBorderWidth = 1.f;
    if (self.leftViewBorderWidth) {
        mBorderWidth = [self.leftViewBorderWidth floatValue];
    }
    self.pLeftLabel.layer.borderWidth = mBorderWidth;
    
    // Border color
    CGColorRef mBorderColor = [UIColor brownColor].CGColor;
    if (self.leftViewBorderColor) {
        mBorderColor = self.leftViewBorderColor.CGColor;
    }
    self.pLeftLabel.layer.borderColor = mBorderColor;
    self.pLeftLabel.layer.cornerRadius = 4.f;
    self.pLeftLabel.textAlignment = NSTextAlignmentRight;
    
    // Label width
    CGFloat mLabelWidth;
    if (self.leftViewWidth) {
        mLabelWidth = [self.leftViewWidth floatValue];
    }else{
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.pLeftLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect mBounds = [_leftViewText boundingRectWithSize:CGSizeMake(999, 999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
        mLabelWidth = mBounds.size.width;
    }
    self.pLeftLabel.frame = CGRectMake(0, 0, mLabelWidth, self.bounds.size.height);
}

#pragma mark - LeftView

-(void)setLeftViewText:(NSString *)mText{
    if (!mText) return;
    if ([mText isEqualToString:@""]) return;
    _leftViewText = mText;
    // load left label
    self.pLeftLabel.text = mText;
    [self layoutIfNeeded];
}

-(void)setLeftViewWidth:(NSNumber *)leftViewWidth{
    if (!leftViewWidth) return;
    if (0.01 > leftViewWidth.floatValue) return;
    _leftViewWidth = leftViewWidth;
    CGRect frm = self.leftView.frame;
    frm.size.width = [leftViewWidth floatValue];
    self.leftView.frame = frm;
}

-(void)setLeftViewBackgroundcolor:(UIColor *)leftViewBackgroundcolor{
    if (!leftViewBackgroundcolor) return;
    _leftViewBackgroundcolor = leftViewBackgroundcolor;
    self.leftView.backgroundColor = _leftViewBackgroundcolor;
}

/**
 *  @author Khiyuan.Fan, 2015-12[3]
 *
 *  left view border width
 *
 *  @param leftViewBorderWidth NSNumber @...
 */
-(void)setLeftViewBorderWidth:(NSNumber *)leftViewBorderWidth{
    if (!leftViewBorderWidth) return;
    _leftViewBorderWidth = leftViewBorderWidth;
    self.pLeftLabel.layer.borderWidth = leftViewBorderWidth.floatValue;
}

-(void)setLeftViewBorderColor:(UIColor *)leftViewBorderColor{
    if (!leftViewBorderColor) return;
    _leftViewBorderColor = leftViewBorderColor;
    self.pLeftLabel.layer.borderColor = leftViewBorderColor.CGColor;
}

#pragma mark - Main View

- (void)setKfBorderColor:(UIColor *)mBorderColor{
    _kfBorderColor = mBorderColor;
    self.layer.borderColor = mBorderColor.CGColor;
}

- (void)setKfIsCorrect:(BOOL)mIsCorrect{
    _kfIsCorrect = mIsCorrect;
    if (mIsCorrect) {
        self.layer.borderColor = self.kfBorderColor.CGColor;
    }else{
        self.layer.borderColor = self.kfInCorrectBorderColor.CGColor;
    }
}

#pragma mark - Setter & Getter

- (UILabel *)pLeftLabel{
    if (!_pLeftLabel) {
        _pLeftLabel = [[UILabel alloc] init];
        _pLeftLabel.textColor = [UIColor darkGrayColor];
        _pLeftLabel.backgroundColor = [UIColor clearColor];
        self.leftView = _pLeftLabel;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return _pLeftLabel;
}

@end
