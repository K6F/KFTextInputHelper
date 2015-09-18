//
//  KFDatePickerTextField.m
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import "KFDatePickerTextField.h"

@interface KFDatePickerTextField ()
// UI
@property (nonatomic, strong) UIDatePicker *pDatePicker;

// Date
@property (nonatomic, strong) KFDateChangedBlock pChangedBlock; // block called after date changed
@end

@implementation KFDatePickerTextField

- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                  dateFormate:(NSString *)mDateFormate
                     dateMode:(UIDatePickerMode)mDateMode
                  dateChanged:(KFDateChangedBlock)mChangedBlock{
    self.kfStartDate = mStartDate;
    self.kfSelectedDate = mSelectedDate;
    self.pChangedBlock = mChangedBlock;
    self.pDatePicker.minimumDate = mStartDate;
    self.pDatePicker.date = mSelectedDate;
    self.pDatePicker.datePickerMode = mDateMode;
}

- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    if (![self.inputView isKindOfClass:[UIDatePicker class]]) {
        self.inputView = self.pDatePicker;
    }
}
#pragma mark - Methods
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
#pragma mark - Setter & Getter
- (void)setStartDate:(NSDate *)mDate{
    _kfStartDate = mDate;
    self.pDatePicker.minimumDate = mDate;
    if ([self.kfSelectedDate earlierDate:mDate])
        self.kfSelectedDate = mDate;
}
- (void)setSelectedDate:(NSDate *)mDate{
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
