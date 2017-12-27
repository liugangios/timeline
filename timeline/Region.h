//
//  region.h
//  timeline
//
//  Created by 刘刚 on 2017/12/27.
//  Copyright © 2017年 刘刚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Region : NSObject
@property(nonatomic, assign)CGFloat minNum;
@property(nonatomic, assign)CGFloat maxNum;

@property(nonatomic, weak)UIView *associatedView;

- (BOOL)containNum:(CGFloat)num;
@end
