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
}

#pragma mark - Inherit

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        pIsInit = YES;
        self.enabled = NO;
    }
    return self;
}
-  (void)layoutSubviews{
    [super layoutSubviews];
    [self p_setupHelper];
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
}
- (void)p_setupHelper{
    [KFTextInputHelper setupHelperWithContainerView:self];
    if (pIsInit) {
        pIsInit = NO;
        self.enabled = YES;
    }
}

     
     
- (void)updateConstraints{
    [super updateConstraints];
    [self p_drawLeftLabel];
}

#pragma mark - methods

- (void)p_drawLeftLabel{
    // Left label
    if (!_pLeftLabel) return;
    if (self.kfLeftLabelBackgroundColor) {
        self.pLeftLabel.backgroundColor = self.kfLeftLabelBackgroundColor;
    }
    // Border width
    float mBorderWidth = 1.f;
    if (self.kfLeftLabelBorderWidth) {
        mBorderWidth = [self.kfLeftLabelBorderWidth floatValue];
    }
    self.pLeftLabel.layer.borderWidth = mBorderWidth;
    
    // Border color
    CGColorRef mBorderColor = [UIColor brownColor].CGColor;
    if (self.kfLeftLabelBorderColor) {
        mBorderColor = self.kfLeftLabelBorderColor.CGColor;
    }
    self.pLeftLabel.layer.borderColor = mBorderColor;
    self.pLeftLabel.layer.cornerRadius = 4.f;
    self.pLeftLabel.textAlignment = NSTextAlignmentRight;
    
    // Label width
    CGFloat mLabelWidth;
    if (self.kfLeftLabelWidth) {
        mLabelWidth = [self.kfLeftLabelWidth floatValue];
    }else{
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:self.pLeftLabel.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGRect mBounds = [self.kfLeftLabelText boundingRectWithSize:CGSizeMake(999, 999)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attributes
                                                     context:nil];
        mLabelWidth = mBounds.size.width;
    }
    self.pLeftLabel.frame = CGRectMake(0, 0, mLabelWidth, self.bounds.size.height);
}


#pragma mark - Left View
-(void)setKfLeftLabelText:(NSString *)mText{
    if (!mText) return;
    if ([mText isEqualToString:@""]) return;
    _kfLeftLabelText = mText;
    // load left label
    self.pLeftLabel.text = mText;
}

-(void)setkfLeftLabelWidth:(NSNumber *)mLeftLabelWidth{
    if (!mLeftLabelWidth) return;
    if (0.01 > mLeftLabelWidth.floatValue) return;
    _kfLeftLabelWidth = mLeftLabelWidth;
    CGRect frm = self.leftView.frame;
    frm.size.width = [mLeftLabelWidth floatValue];
    self.leftView.frame = frm;
    [self setNeedsUpdateConstraints];
}

-(void)setKfLeftLabelBackgroundColor:(UIColor *)mLeftLabelBackgroundColor{
    if (!mLeftLabelBackgroundColor) return;
    _kfLeftLabelBackgroundColor = mLeftLabelBackgroundColor;
    self.leftView.backgroundColor = mLeftLabelBackgroundColor;
}

/**
 *  @author Khiyuan.Fan, 2015-12[3]
 *
 *  left view border width
 *
 *  @param leftViewBorderWidth NSNumber @...
 */
-(void)setKfLeftLabelBorderWidth:(NSNumber *)mLeftLabelBorderWidth{
    if (!mLeftLabelBorderWidth) return;
    _kfLeftLabelBorderWidth = mLeftLabelBorderWidth;
    self.pLeftLabel.layer.borderWidth = mLeftLabelBorderWidth.floatValue;
}

-(void)setKfLeftLabelBorderColor:(UIColor *)mLeftLabelBorderColor{
    if (!mLeftLabelBorderColor) return;
    _kfLeftLabelBorderColor = mLeftLabelBorderColor;
    self.pLeftLabel.layer.borderColor = mLeftLabelBorderColor.CGColor;
}

#pragma mark - Verify

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
