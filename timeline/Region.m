//
//  region.m
//  timeline
//
//  Created by 刘刚 on 2017/12/27.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import "Region.h"

@implementation Region

- (BOOL)containNum:(CGFloat)num {
    return (num >= self.minNum && num < self.maxNum);
}
@end
