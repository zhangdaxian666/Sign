//
//  CollectionViewCell.h
//  Sign
//
//  Created by slcf888 on 2018/1/9.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"

@interface CollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconIV;      //任务图片
@property (nonatomic, strong) UIImageView *iconBorder;  //线圈
@property (nonatomic, strong) UILabel *nameLB;          //任务名字
@property (nonatomic, strong) UILabel *progressLB;      //进行中
@property (nonatomic, strong) UIView *topLine;          //上线
@property (nonatomic, strong) UIView *downLine;         //下线
@property (nonatomic, strong) UIView *leftLine;         //左线
@property (nonatomic, strong) UIView *rightLine;        //右线

- (void)cellIndexPathRow:(NSInteger)row rowCount:(NSInteger)count;

@property (nonatomic, strong) CollectionModel *dataModel;
@property (nonatomic, strong) CollectionModel *statueModel;

@end
