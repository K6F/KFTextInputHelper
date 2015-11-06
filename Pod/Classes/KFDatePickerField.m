//
//  KFDatePickerField.m
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import "KFDatePickerField.h"
#import "KFTextInputHelper.h"

@interface KFDatePickerField ()
// UI
@property (nonatomic, strong) UIDatePicker *pDatePicker;

// Date
@property (nonatomic, strong) KFDateChangedBlock pChangedBlock; // block called after date changed
@end

@implementation KFDatePickerField
@synthesize kfStartDate,kfEndDate,kfSelectedDate,kfDateFormat;
@synthesize pDatePicker;

- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                   dateFormat:(NSString *)mDateFormat
                     dateMode:(UIDatePickerMode)mDateMode
                  dateChanged:(KFDateChangedBlock)mChangedBlock{
    self.kfStartDate                = mStartDate;
    self.kfSelectedDate             = mSelectedDate;
    self.kfDateFormat = kfDateFormat;
    self.pChangedBlock              = mChangedBlock;
    self.pDatePicker.datePickerMode = mDateMode;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (![self.inputView isKindOfClass:[UIDatePicker class]]) {
        self.inputView = self.pDatePicker;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(p_keyboardWasShown:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private methods
- (void)p_datePickerValueChanged:(UIDatePicker *)mDatePicker{
    self.kfSelectedDate = mDatePicker.date;
    [self p_updateTextWithDate:self.kfSelectedDate];
}
- (void)p_updateTextWithDate:(NSDate *)mDate{
    NSDateFormatter *mDateFormatter = [[NSDateFormatter alloc] init];
    mDateFormatter.dateFormat = self.kfDateFormat;
    self.text = [mDateFormatter stringFromDate:mDate];
    if (self.pChangedBlock) {
        self.pChangedBlock(mDate, self.text);
    }
}
- (void)p_keyboardWasShown:(NSNotification*)aNotification{
    KFTextInputHelper *mHelper = [KFTextInputHelper helperWithContainerView:self];
    if (![mHelper.kfCurrentFirstResponder isEqual:self]) return;
    [self p_datePickerValueChanged:self.pDatePicker];
}
#pragma mark - Setter & Getter | Lazy Config
- (void)setStartDate:(NSDate *)mDate{
    if (!mDate) return;
    kfStartDate = mDate;
    self.pDatePicker.minimumDate = mDate;
    if ([self.kfSelectedDate earlierDate:mDate])
    self.kfSelectedDate = mDate;
}
-(void)setEndDate:(NSDate *)mEndDate{
    kfEndDate = mEndDate;
    self.pDatePicker.maximumDate = mEndDate;
}
- (void)setSelectedDate:(NSDate *)mDate{
    if (!mDate) return;
    kfSelectedDate = mDate;
    self.pDatePicker.date = mDate;
    [self p_updateTextWithDate:mDate];
}
- (void)setDateFormat:(NSString *)mDateFormat{
    kfDateFormat = mDateFormat;
}
- (NSString *)kfDateFormat{
    if (!kfDateFormat) {
        kfDateFormat = @"EEE MM/dd";
    }
    return kfDateFormat;
}
- (UIDatePicker *)pDatePicker{
    if (!pDatePicker) {
        pDatePicker = [[UIDatePicker alloc]init];
        NSUserDefaults *mUserDefaults = [NSUserDefaults standardUserDefaults];
        NSArray *mLanguages = [mUserDefaults objectForKey:@"AppleLanguages"];
        NSString *mLocalization = mLanguages.firstObject;
        pDatePicker.locale = [NSLocale localeWithLocaleIdentifier:mLocalization];
        [pDatePicker addTarget:self
                        action:@selector(p_datePickerValueChanged:)
              forControlEvents:UIControlEventValueChanged];
    }
    return pDatePicker;
}
@end
