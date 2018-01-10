//
//  FailedView.h
//  Sign
//
//  Created by slcf888 on 2018/1/9.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FailedView : UIView

- (instancetype)initCustomFailedTitle:(NSString *)text contentStr:(NSString *)content andTop:(float)top Alpha:(float)alpha;

- (void)show:(BOOL)animated;     //显示
- (void)hide:(BOOL)animated;     //隐藏

@end
