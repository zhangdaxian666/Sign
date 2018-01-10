//
//  CollectionModel.h
//  Sign
//
//  Created by slcf888 on 2018/1/9.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CollectionModel : NSObject

@property (nonatomic, assign) BOOL isSelected;   //是否选中
@property (nonatomic, assign) BOOL isComplete;  //是否完成
@property (nonatomic, copy) NSString *text;     //第几天
@property (nonatomic, strong) UIImage *image;   //图片。 pch

@end
