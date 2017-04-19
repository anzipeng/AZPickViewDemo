# AZPickViewDemo
### AZPickView是基于UIPickView封装，结构简单明了适合单行，多行PickView的实现。
##   一下是实现的部分代码
###

```
- (void) initUI{
    for (int i = 0; i < 3; i ++) {
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(50, 70 + i *150, SCREEN_WIDTH -100, 21)];
        [label setText:[NSString stringWithFormat:@"列数为%d的pickView",i+1]];
        
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(50, 100 + i *150, SCREEN_WIDTH -100, 44)];
        button.tag = i;
        NSString *btnTitle ;
        switch (i) {
            case 0:
                btnTitle = @"关闭";
                break;
                case 1:
                btnTitle = @"12:00";
                break;
            default:
                btnTitle = @"2017年-04月-19日 09时:59分";
                break;
        }
        [button setTitle:btnTitle forState:UIControlStateNormal];
        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:label];
        [self.view addSubview:button];
    }
}
```
###// 单列测试
```
- (void) test0:(UIButton *)btn{
    self.currentBtn = btn;
    AZPickView * pickView = [AZPickView loadView];
    pickView.pickWidth = 90;
    [pickView setFrame:CGRectMake(0, SCREEN_HEIGHT -250, SCREEN_WIDTH, 250)];
    pickView.delegate = (id)self;
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 360; i++) {
        NSString * str = [NSString stringWithFormat:@"%d分钟",i];
        [array addObject:str];
    }
    [array insertObject:@"关闭" atIndex:0];
    pickView.dataSource = @[array];
    pickView.pickInitArray  =  @[btn.currentTitle];
    [self.view addSubview:pickView];
  
}
```
/// 双列测试
```
- (void)test1:(UIButton *)btn1{
    self.currentBtn = btn1;
    AZPickView * pickView = [AZPickView loadView];
    [pickView setFrame:CGRectMake(0, SCREEN_HEIGHT -250, SCREEN_WIDTH, 250)];
    pickView.delegate = (id)self;
    NSMutableArray * arrayHour = [NSMutableArray array];
    NSMutableArray * arrayMin = [NSMutableArray array];
    
    for (int i = 0; i < 24; i++) {
        NSString * str = [NSString stringWithFormat:@"%.2d",i];
        [arrayHour addObject:str];
    }
    for (int i = 0 ; i<= 59; i ++) {
        NSString * str = [NSString stringWithFormat:@"%.2d",i];
        [arrayMin addObject:str];
    }
    pickView.dataSource = @[arrayHour,arrayMin];
    NSArray * array = [btn1.titleLabel.text componentsSeparatedByString:@":"];
    
    pickView.pickInitArray =  @[array[0],array[1]];;
    [self.view addSubview:pickView];

}
```
/// 五列测试
```
- (void)test2:(UIButton *)btn2{
    self.currentBtn = btn2;
    AZPickView * pickView = [AZPickView loadView];
    pickView.pickWidth = 80;
    [pickView setFrame:CGRectMake(0, SCREEN_HEIGHT -250, SCREEN_WIDTH, 250)];
    pickView.delegate = (id)self;
    NSMutableArray * arrayYear = [NSMutableArray array];
    NSMutableArray * arrayMonth = [NSMutableArray array];
    NSMutableArray * arrayDay = [NSMutableArray array];
    NSMutableArray * arrayHour = [NSMutableArray array];
    NSMutableArray * arrayMin = [NSMutableArray array];
    for (int i = 2000; i < 2100; i++) {
        NSString * str = [NSString stringWithFormat:@"%d年",i];
        [arrayYear addObject:str];
    }
    for (int i = 1; i < 13; i++) {
        NSString * str = [NSString stringWithFormat:@"%.2d月",i];
        [arrayMonth addObject:str];
    }
    for (int i = 1; i < 31; i++) {
        NSString * str = [NSString stringWithFormat:@"%.2d日",i];
        [arrayDay addObject:str];
    }
    for (int i = 0; i <= 24; i++) {
        NSString * str = [NSString stringWithFormat:@"%.2d时",i];
        [arrayHour addObject:str];
    }
    for (int i = 0; i <= 59; i++) {
        NSString * str = [NSString stringWithFormat:@"%.2d分",i];
        [arrayMin addObject:str];
    }
    pickView.dataSource = @[arrayYear,arrayMonth,arrayDay,arrayHour,arrayMin];
    NSString * str = btn2.currentTitle;
    NSArray * strArray = [str componentsSeparatedByString:@" "];
    NSString * yyMMdd = strArray[0];
    NSString * HHmm = strArray[1];
    NSArray * yyMMddA = [yyMMdd componentsSeparatedByString:@"-"];
    NSArray * HHmmA = [HHmm componentsSeparatedByString:@":"];
    pickView.pickInitArray  =  @[yyMMddA[0],yyMMddA[1],yyMMddA[2],HHmmA[0],HHmmA[1]];
    [self.view addSubview:pickView];

}
```
