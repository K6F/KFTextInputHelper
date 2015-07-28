//
//  KFInputToolbarProtocol.h
//  
//
//  Created by K6F on 15/7/28.
//
//

#import <Foundation/Foundation.h>


@protocol KFInputToolbarProtocol <NSObject>
@optional
/** 输入开始 */
-(void)kf_didBeginEditing:(NSNotification *)notification;
/** 输入结束 */
-(void)kf_didEndEditing:(NSNotification *)notification;
@end