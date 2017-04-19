//
//  AZPickView.h
//  线程测试
//
//  Created by northcom on 17/3/13.
//  Copyright © 2017年 安自鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AZPickViewDeleagte<NSObject>
- (void) AZPickResoultWithArray:(NSArray *) array;
@end
/**
 <#Description#>
 */
@interface AZPickView : UIView
@property (nonatomic , strong) NSArray * dataSource;
@property (nonatomic , weak) id<AZPickViewDeleagte> delegate;
// PickView的宽，默认是60，如果界面仍然不能显示完全，适当增大。
@property (nonatomic , assign) float pickWidth;
// PickView的高，默认是35，如果不满足，可适当增大
@property (nonatomic ,assign) float rowHeight;
// // 设置初始化时所对应的数据，可为空。
@property (nonatomic ,strong) NSArray * pickInitArray;
+ (instancetype) loadView;

@end
