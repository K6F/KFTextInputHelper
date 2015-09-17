//
//  KFDatePickerTextField.h
//  Pods
//
//  Created by FanKhiyuan on 15/9/17.
//
//

#import <UIKit/UIKit.h>

typedef void(^KFDateChangedBlock) (NSDate *bDate, NSString *bDateString);

@interface KFDatePickerTextField : UITextField
@property (nonatomic) NSDate *kfStartDate;
@property (nonatomic) NSDate *kfSelectedDate;
- (void)kf_setupWithStartDate:(NSDate *)mStartDate
                 selectedDate:(NSDate *)mSelectedDate
                  dateChanged:(KFDateChangedBlock)mChangedBlock;
@end
