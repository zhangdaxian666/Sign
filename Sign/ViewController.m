//
//  ViewController.m
//  Sign
//
//  Created by slcf888 on 2018/1/9.
//  Copyright © 2018年 slcf888. All rights reserved.
//

#import "ViewController.h"
#import "CollectionModel.h"
#import "CollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_collectionView;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *changeIndexArr;

@property (nonatomic, assign) NSInteger currentSelectCount; //选择天数

@end
static NSString *cellId = @"CollectionViewCell";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];   //数据处理
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(self.view.frame.size.width/3, self.view.frame.size.width/3);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:cellId];
    
    self.currentSelectCount = 0;
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.dataSource.count) {
        return self.dataSource.count;
    }
    return 0;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    NSString *index = [NSString stringWithFormat:@"%@",self.changeIndexArr[indexPath.row]];
    CollectionModel *model = [self.dataSource objectAtIndex:[index intValue]];
    
    [cell cellIndexPathRow:indexPath.row rowCount:self.dataSource.count -1];  //cell里的判断语句
    cell.dataModel = model;  //赋值
    cell.statueModel = model; //签到
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *index = [NSString stringWithFormat:@"%@",self.changeIndexArr[indexPath.row]];
    self.currentSelectCount = [index intValue];
    NSInteger indexUnSelecr = [self firstUnCompleteIndex]; //找到第一个未签到的
    if (indexUnSelecr == [index intValue]) {
        [self taskModel];
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSString *failed_msg = @"签到失败";
            NSString *failed_order_msg;
            if (indexUnSelecr >= [index intValue]) {  //判断点击
                failed_order_msg = @"请误重复签到";
            }else{
                failed_order_msg = @"请依次签到";
            }
            [self showFailed:failed_msg withMessage:failed_order_msg];
        });
    }
}


- (void)taskModel
{
    if (self.currentSelectCount +1 <self.dataSource.count) {
        CollectionModel *statue = [self.dataSource objectAtIndex:self.currentSelectCount +1];
        statue.isSelected = YES;
        [self.dataSource replaceObjectAtIndex:self.currentSelectCount+1 withObject:statue];
    }
    CollectionModel *statueModel = [self.dataSource objectAtIndex:self.currentSelectCount];
    statueModel.isComplete = YES;
    [self.dataSource replaceObjectAtIndex:self.currentSelectCount withObject:statueModel];
    
    [_collectionView reloadData];
    NSInteger haveComplete = [self haveCheckCount];
    if (haveComplete == self.dataSource.count) {
        [self showFailed:@"恭喜你" withMessage:@"全部已签到"];
    }else{
        [self showFailed:@"恭喜你" withMessage:@"签到成功"];
    }
}

//弹出的view
- (void)showFailed:(NSString *)failed_msg  withMessage:(NSString *)message
{
    FailedView *failed = [[FailedView alloc]initCustomFailedTitle:failed_msg contentStr:message andTop:240 Alpha:0.5];
    [failed show:YES];
}

//数据处理
- (void)initData
{
    self.dataSource = [NSMutableArray array];
    self.changeIndexArr = [NSMutableArray array];
    for (NSInteger i =0; i<9; i++) {
        CollectionModel *model = [[CollectionModel alloc]init];
        model.isComplete = NO;
        if (i == 0) {
            model.isSelected = YES;
        }else{
            model.isSelected = NO;
        }
        model.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",i]];
        model.text = [NSString stringWithFormat:@"第%ld天",i+1];
        [self.dataSource addObject:model];
        [self.changeIndexArr addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    if (self.dataSource.count == 9) {   //替换位置
        for (int i=0; i<self.dataSource.count; i++) {
            NSInteger a = i%3;    //i%6 ！=0 第三行不交换
            if (i>2 && a==0 && i+2<self.dataSource.count && i%6 != 0) {
                [self.changeIndexArr exchangeObjectAtIndex:i withObjectAtIndex:i+2];
            }
        }
    }
    [_collectionView reloadData];
}


//找到第一个未签到的
- (NSInteger)firstUnCompleteIndex
{
    NSInteger index = 10000;
    for (NSInteger i =0; i<self.dataSource.count; i++) {
        CollectionModel *model =self.dataSource[i];
        if (!model.isComplete) {
            index = i;
            break;
        }
    }
    return index;
}
//计算已签到数
- (NSInteger)haveCheckCount
{
    NSInteger allPoint =0;
    for (int i =0; i<self.dataSource.count; i++) {
        CollectionModel *model =[self.dataSource objectAtIndex:i];
        if (model.isComplete) {
            allPoint ++;
        }
    }
    return allPoint;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
