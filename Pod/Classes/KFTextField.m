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
    BOOL pIsInit;
    BOOL pOriginEnabled;
}
@synthesize kfBorderColor,kfBorderWidth,kfFocusBorderColor;
@synthesize kfLeftText,kfLeftColor,kfLeftBackgroundColor,kfLeftWidth;
@synthesize kfLeftBorderColor,kfLeftBorderWidth;
@synthesize kfVerifyFailedBorderColor,kfVerifyPassedBorderColor;

#pragma mark - Inherit

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        pOriginEnabled = self.enabled;
        self.enabled = NO;
    }
    return self;
}

-  (void)layoutSubviews{
    [super layoutSubviews];
    [self p_setupHelper];
}

- (void)updateConstraints{
    [super updateConstraints];
    [self p_drawLeftLabel];
}

#pragma mark - Methods
#pragma mark -- Private
- (void)p_setupHelper{
    [KFTextInputHelper setupHelperWithContainerView:self];
    if (pIsInit) {
        pIsInit = NO;
        self.enabled = pOriginEnabled;
    }
}

- (void)p_drawLeftLabel{
    // Check Left Label exist
    if (!_pLeftLabel) return;
    if (self.kfLeftColor) {
        self.pLeftLabel.textColor = self.kfLeftColor;
    }
    
    // Left Label Background Color
    if (self.kfLeftBackgroundColor)
    self.pLeftLabel.backgroundColor = self.kfLeftBackgroundColor;
    
    // Left Label Border color
    self.pLeftLabel.layer.borderColor = self.kfLeftBorderColor.CGColor;
    self.pLeftLabel.layer.borderWidth = self.kfLeftBorderWidth;
    
    // Left Label Border width
    self.pLeftLabel.layer.cornerRadius = 4.f;
    self.pLeftLabel.textAlignment = NSTextAlignmentRight;
    
    // Label width
    CGFloat mLabelWidth;
    if (self.kfLeftWidth) {
        mLabelWidth = self.kfLeftWidth;
    }else{
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.pLeftLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect mBounds = [self.kfLeftText boundingRectWithSize:CGSizeMake(999, 999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
        mLabelWidth = mBounds.size.width;
    }
    self.pLeftLabel.frame = CGRectMake(0, 0, mLabelWidth, self.bounds.size.height);
}


#pragma mark - Setter & Getter | Lazy Config
#pragma mark -- Layer
- (void)setKfBorderColor:(UIColor *)mBorderColor{
    kfBorderColor = mBorderColor;
    self.layer.borderColor = mBorderColor.CGColor;
}
- (void)setKfBorderWidth:(CGFloat)mBorderWidth{
    kfBorderWidth = mBorderWidth;
    self.layer.borderWidth = mBorderWidth;
}
#pragma mark -- Left SubView
-(void)setKfLeftText:(NSString *)mText{
    if (!mText) return;
    if ([mText isEqualToString:@""]) return;
    kfLeftText = mText;
    // load left label
    self.pLeftLabel.text = mText;
}
-(void)setKfLeftBackgroundColor:(UIColor *)mColor{
    if (!mColor) return;
    kfLeftBackgroundColor = mColor;
    self.leftView.backgroundColor = mColor;
}
- (void)setKfLeftWidth:(CGFloat)mWidth{
    kfLeftWidth = mWidth;
    CGRect mFrame = self.leftView.frame;
    mFrame.size.width = mWidth;
    self.leftView.frame = mFrame;
    [self setNeedsUpdateConstraints];
}

/** Left subview border width */
- (void)setKfLeftBorderWidth:(CGFloat)mLeftLabelBorderWidth{
    kfLeftBorderWidth = mLeftLabelBorderWidth;
    self.pLeftLabel.layer.borderWidth = mLeftLabelBorderWidth;
}
/** Left subview border color */
-(void)setKfLeftBorderColor:(UIColor *)mLeftLabelBorderColor{
    if (!mLeftLabelBorderColor) return;
    kfLeftBorderColor = mLeftLabelBorderColor;
    self.pLeftLabel.layer.borderColor = mLeftLabelBorderColor.CGColor;
}

#pragma mark -- Verify
- (void)setKfVerifed:(BOOL)kfVerifed{
    _kfVerifed = kfVerifed;
    self.layer.borderColor = (kfVerifed)? self.kfBorderColor.CGColor : self.kfVerifyFailedBorderColor.CGColor;
}
#pragma mark -- Lazy Config
- (UIColor *)kfFocusBorderColor{
    if (!kfFocusBorderColor) {
        kfFocusBorderColor = [UIColor colorWithRed:0.400 green:0.663 blue:0.984 alpha:1.0];
    }
    return kfFocusBorderColor;
}
- (UIColor *)kfLeftBorderColor{
    if (!kfLeftBorderColor) {
        kfLeftBorderColor = [UIColor clearColor];
    }
    return kfLeftBorderColor;
}
- (UIColor *)kfVerifyFailedBorderColor{
    if (!kfVerifyFailedBorderColor) {
        kfVerifyFailedBorderColor = [UIColor colorWithRed:0.984 green:0.400 blue:0.663 alpha:1.0];
    }
    return kfVerifyFailedBorderColor;
}
- (UIColor *)kfVerifyPassedBorderColor{
    if (!kfVerifyPassedBorderColor) {
        kfVerifyPassedBorderColor = [UIColor colorWithRed:0.984 green:0.400 blue:0.663 alpha:1.0];
    }
    return kfVerifyPassedBorderColor;
}

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
