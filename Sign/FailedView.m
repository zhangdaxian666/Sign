//
//  FailedView.m
//  Sign
//
//  Created by slcf888 on 2018/1/9.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "FailedView.h"

@interface FailedView ()
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *contentLB;
@end

@implementation FailedView

- (instancetype)initCustomFailedTitle:(NSString *)text contentStr:(NSString *)content andTop:(float)top Alpha:(float)alpha
{
    self = [super init];
    if (self) {
        CGFloat TitleH = 15;
        CGFloat contentH = 30;
        CGFloat selfH = 65;
        self.frame = CGRectMake(76, top, [[UIScreen mainScreen] bounds].size.width-76*2, selfH);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.titleLB = [[UILabel alloc]init];
        [self addSubview:self.titleLB];
        [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(13);
            make.right.mas_offset(-13);
            make.height.mas_offset(TitleH);
        }];
        self.titleLB.text = text;
        self.titleLB.textColor = [UIColor whiteColor];
        self.titleLB.font = [UIFont systemFontOfSize:16];
        self.titleLB.textAlignment = NSTextAlignmentCenter;
        self.titleLB.numberOfLines = 0;
        
        self.contentLB = [[UILabel alloc]init];
        [self addSubview:self.contentLB];
        [self.contentLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(13);
            make.right.mas_offset(-13);
            make.top.equalTo(self.titleLB.mas_bottom).offset(4.5);
            make.height.mas_offset(contentH);
        }];
        self.contentLB.text = content;
        self.contentLB.textColor = [[UIColor whiteColor]colorWithAlphaComponent:0.8];
        self.contentLB.font = [UIFont systemFontOfSize:14];
        self.contentLB.textAlignment =NSTextAlignmentCenter;
        self.contentLB.numberOfLines = 0;
    }
    return self;
}
- (void)show:(BOOL)animated
{     // 动画
    if (animated) {
        self.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
        self.alpha = 0.0f;
        __weak typeof(self) weakSelf = self;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.transform = CGAffineTransformIdentity;
            weakSelf.alpha = 1.0f;
        } completion:^(BOOL finished) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self hide:YES]; //yin cang
            });
        }];
    }
}
- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.transform = CGAffineTransformMakeScale(0.6f, 0.6f);
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
