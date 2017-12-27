//
//  ViewController.m
//  timeline
//
//  Created by 刘刚 on 2017/12/27.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "ViewController.h"
#import "Region.h"
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define RandColor RGBColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self drawTimeBlock];
}
- (void)drawTimeBlock {
    
    
     
//     NSArray *jsonArr = @[
//     @{@"start":@"30",@"end":@"150"},
//     @{@"start":@"540",@"end":@"600"},
//     @{@"start":@"560",@"end":@"620"},
//     @{@"start":@"610",@"end":@"670"},
//     ];
    
//     NSArray *jsonArr = @[
//     @{@"start":@"30",@"end":@"150"},
//     @{@"start":@"540",@"end":@"600"},
//     @{@"start":@"550",@"end":@"620"},
//     @{@"start":@"560",@"end":@"650"},
//     @{@"start":@"630",@"end":@"690"},
//     ];
    
    NSArray *jsonArr = @[
                         @{@"start":@"30",@"end":@"670"},
                         @{@"start":@"100",@"end":@"180"},
                         @{@"start":@"180",@"end":@"200"},
                         @{@"start":@"210",@"end":@"480"},
                         @{@"start":@"220",@"end":@"490"},
                         @{@"start":@"250",@"end":@"500"},
                         @{@"start":@"280",@"end":@"510"},
                         @{@"start":@"540",@"end":@"600"},
                         @{@"start":@"550",@"end":@"620"},
                         @{@"start":@"560",@"end":@"650"},
                         @{@"start":@"630",@"end":@"690"},
                         @{@"start":@"640",@"end":@"700"},
                         ];
    
    NSMutableArray *regionArr = [NSMutableArray array];
    NSMutableArray *beginArr = [NSMutableArray array];
    
    for (int i=0; i<jsonArr.count; i++) {//将区间读入数组
        Region *region = [[Region alloc] init];
        NSDictionary *dict = jsonArr[i];
        NSString *start = dict[@"start"];
        NSString *end = dict[@"end"];
        region.minNum = start.floatValue;
        region.maxNum = end.floatValue;
        [regionArr addObject:region];
        [beginArr addObject:[NSNumber numberWithFloat:start.floatValue]];
    }
    
    NSMutableArray *crossRegionArr = [NSMutableArray array];
    for (int i=0; i<beginArr.count; i++) {//将区间按重叠区域分组
        NSMutableArray *tempArr = [NSMutableArray array];
        for (int j=0; j<regionArr.count; j++) {
            Region *region = regionArr[j];
            NSNumber *start = beginArr[i];
            if ([region containNum:start.floatValue]) {
                [tempArr addObject:region];
            }
        }
        [tempArr sortUsingComparator:^NSComparisonResult(Region *obj1, Region *obj2) {//按照region起始y值排序
            return obj1.minNum > obj2.minNum;
        }];
        [crossRegionArr addObject:tempArr];
    }
    
    [crossRegionArr sortUsingComparator:^NSComparisonResult(NSArray *obj1, NSArray *obj2) {//数组按照count排序
        return obj1.count < obj2.count;
    }];
    
    for (int i=0; i<crossRegionArr.count; i++) {//遍历排序后的大数组
        NSMutableArray *sortRegionArr = crossRegionArr[i];
        NSInteger devideCount = sortRegionArr.count; //被平分的矩形个数
        CGFloat startX = 0;
        CGFloat endX = self.view.frame.size.width;
        for (int j=0; j<sortRegionArr.count; j++) {//遍历一行region数组
            Region *region = sortRegionArr[j];
            if (!region.associatedView) {//view还没有添加添加，创建view
                
                CGFloat ditance = endX - startX;//计算将要被平分的距离
                
                CGFloat regionX = startX+(j+devideCount-sortRegionArr.count)*ditance/devideCount;
                CGFloat regionY = region.minNum;
                CGFloat regionW = ditance/devideCount;
                CGFloat regionH = region.maxNum - region.minNum;
                
                UIView *addView = [[UIView alloc] initWithFrame:CGRectMake(regionX, regionY,regionW,regionH)];
                addView.backgroundColor = RandColor;
                region.associatedView = addView;
                [self.view addSubview:addView];
            }else{ //view已经添加
                if (region.associatedView.frame.origin.x == startX) {
                    startX += region.associatedView.frame.size.width;
                }else {
                    endX = endX-region.associatedView.frame.size.width;
                }
                devideCount = devideCount - 1;
            }
        }
    }
}

@end
