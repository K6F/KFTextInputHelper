//
//  KFDatePickerTextField.m
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import "KFDatePickerTextField.h"
#import "KFTextInputHelper.h"

@interface KFDatePickerTextField ()
// UI
@property (nonatomic, strong) UIDatePicker *pDatePicker;

// Date
@property (nonatomic, strong) KFDateChangedBlock pChangedBlock; // block called after date changed
@end

@implementation KFDatePickerTextField

- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                   dateFormat:(NSString *)mDateFormat
                     dateMode:(UIDatePickerMode)mDateMode
                  dateChanged:(KFDateChangedBlock)mChangedBlock{
    self.kfStartDate = mStartDate;
    self.kfSelectedDate = mSelectedDate;
    self.pChangedBlock = mChangedBlock;
    self.pDatePicker.datePickerMode = mDateMode;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (![self.inputView isKindOfClass:[UIDatePicker class]]) {
        self.inputView = self.pDatePicker;
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(p_keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Private methods
- (void)p_DatePickerValueChanged:(UIDatePicker *)mDatePicker{
    self.kfSelectedDate = mDatePicker.date;
    [self p_updateTextWithDate:self.kfSelectedDate];
}
- (void)p_updateTextWithDate:(NSDate *)mDate{
    NSDateFormatter *mDateFormatter = [[NSDateFormatter alloc] init];
    mDateFormatter.dateFormat = @"EEE MM月dd";
    self.text = [mDateFormatter stringFromDate:mDate];
    if (self.pChangedBlock) {
        self.pChangedBlock(mDate, self.text);
    }
}
- (void)p_keyboardWasShown:(NSNotification*)aNotification{
    KFTextInputHelper *mHelper = [KFTextInputHelper helperWithContainerView:self];
    if (![mHelper.kfCurrentFirstResponder isEqual:self]) return;
    [self p_DatePickerValueChanged:self.pDatePicker];
}
#pragma mark - Setter & Getter
- (void)setStartDate:(NSDate *)mDate{
    if (!mDate) return;
    _kfStartDate = mDate;
    self.pDatePicker.minimumDate = mDate;
    if ([self.kfSelectedDate earlierDate:mDate])
        self.kfSelectedDate = mDate;
}
- (void)setSelectedDate:(NSDate *)mDate{
    if (!mDate) return;
    _kfSelectedDate = mDate;
    self.pDatePicker.date = mDate;
    [self p_updateTextWithDate:mDate];
}

- (UIDatePicker *)pDatePicker{
    if (!_pDatePicker) {
        _pDatePicker = [[UIDatePicker alloc]init];
        _pDatePicker.locale = [NSLocale systemLocale];
        [_pDatePicker addTarget:self
                         action:@selector(p_DatePickerValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    }
    return _pDatePicker;
}
@end
