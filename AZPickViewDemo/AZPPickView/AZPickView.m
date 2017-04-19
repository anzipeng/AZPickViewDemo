//
//  AZPickView.m
//  线程测试
//
//  Created by northcom on 17/3/13.
//  Copyright © 2017年 安自鹏. All rights reserved.
//

#import "AZPickView.h"
// 屏幕 SCREEN_WIDTH
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
//屏幕 SCREEN_HEIGHT
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

@interface AZPickView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *AZPickView;

@property (nonatomic ,strong) UIView * modaView;
@property (nonatomic ,strong) NSMutableArray * dataArray;
@property (nonatomic ,assign) NSInteger row;
@property (nonatomic ,assign) NSInteger component;
@end
@implementation AZPickView

/**
 初始化数据，默认选择第一个作为数据源

 @return 此数据将会作为返回的默认初始化数据
 */
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:5];
        for (NSArray * array in self.dataSource) {
            [self.dataArray addObject:[NSString stringWithFormat:@"%@",[array objectAtIndex:0]]];
        }
      }
   
    return _dataArray;
}

/**
 加载界面

 @return 视图
 */
+ (instancetype) loadView{
    AZPickView * view = [[[NSBundle mainBundle] loadNibNamed:@"AZPickView" owner:nil options:nil]lastObject];
    return view;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.AZPickView.delegate = (id)self;
    self.AZPickView.dataSource = (id) self;
  
    [self addModaView];
    if(self.pickInitArray !=nil  && self.pickInitArray.count > 0){
        [self setInitPickViewDataWithArray:self.pickInitArray];
    }
    
}

/**
 数据处理，遍历数据源，找到数据源和初始化的pickViewArray里面的数据进行匹配，查询并记录pickViewArray存储的初始化值在数据源的位置

 @param array 用户初始化的数据源
 */
- (void) setInitPickViewDataWithArray:(NSArray *) array{
    for (int i = 0; i < array.count; i ++) {
        NSInteger com = i;
        NSString * row = array[i];
        __block NSInteger selectRow = 0;
        
        [self.dataSource[i] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            if ([row isEqualToString:obj]) {
              
                selectRow = idx;
                * stop = YES;
                
            }
        }];
   
        [self.dataArray replaceObjectAtIndex:com withObject:row];
        [self.AZPickView selectRow:selectRow inComponent:com animated:YES];
        
    }
   
    
}

/**
 增加蒙泰模板
 */
- (void) addModaView{
    self.modaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.frame.size.height)];
    self.modaView.backgroundColor = [UIColor lightGrayColor];
    self.modaView.alpha = 0.6;
    [self.superview addSubview:self.modaView];
  
}

/**
 去除蒙泰模板
 */
- (void) removeModaView{
    
    [self removeFromSuperview];
    [_modaView removeFromSuperview];
    _modaView =  nil;
}

/**
 确定按钮点击时间

 @param sender 确定按钮点击时间
 */
- (IBAction)OkButtonOnclick:(id)sender {
    [self removeModaView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(AZPickResoultWithArray:)]) {
        [self.delegate AZPickResoultWithArray:[NSArray arrayWithArray:self.dataArray]];
    }
}

/**
 取消按钮点击事件

 @param sender <#sender description#>
 */
- (IBAction)cancleButtonOnclick:(id)sender {
    [self removeModaView];
}

#pragma mark -- UIPickViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.dataSource.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSArray * array = self.dataSource[component];
    return array.count;
}

#pragma mark -- UIPickViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray * array =  self.dataSource[component];
    return [NSString stringWithFormat:@"%@",array[row]];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray * array = self.dataSource[component];
    [self.dataArray replaceObjectAtIndex:component withObject:[NSString stringWithFormat:@"%@",array[row]]];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (!_pickWidth ) {
          return 60;
    }else{
        return _pickWidth;
    }
  
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    if(!_rowHeight){
        return  35;
    }else{
        return _rowHeight;
    }
}
@end
