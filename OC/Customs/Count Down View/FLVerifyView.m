//
//  FLVerifyView.m
//  verifyButtonDemo
//
//  Created by 孔凡列 on 15/12/25.
//  Copyright © 2015年 czebd. All rights reserved.
//

#import "FLVerifyView.h"
#import "FLWeakTimer.h"
#define FLVerifyViewWidth self.bounds.size.width
#define FLverifyViewHeight self.bounds.size.height

@interface FLVerifyView ()<UIPickerViewDataSource,UIPickerViewDelegate>{
    NSTimer *timer;
}
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)NSInteger originalCount;
@property (nonatomic,assign)NSInteger num;
//@property (nonatomic,assign)NSInteger countDownTime;


@property (nonatomic,strong)UIPickerView *pickerView;
@property (nonatomic,strong)UILabel *countDownFinishLabel;
@property (nonatomic,strong)UILabel *unitLabel;

@end

@implementation FLVerifyView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.countDownFinishLabel.textAlignment = NSTextAlignmentCenter;
//        // 一开始显示的文本
//        NSString *normalText = FLVerifyViewNormalText;
//        if (_fl_normalLabel) {
//            normalText = _fl_normalLabel.text;
//        }
//        self.countDownFinishLabel.text = normalText;
        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(verifyViewClick)];
        [self addGestureRecognizer:tapGestureRecognizer];
        
        if (!_fl_countDownTime) {
            _fl_countDownTime = 60;
            _count = _fl_countDownTime - 1;
            _originalCount = _fl_countDownTime - 1;
        }
    }
    return self;
}

- (void)verifyViewClick{
    
    // 隐藏文本
    self.countDownFinishLabel.alpha = 0;
    // 创建时间倒计时显示
    [self addSubview:self.pickerView];
    [self addSubview:self.unitLabel];
    self.pickerView.hidden = NO;
    self.unitLabel.hidden = NO;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [timer invalidate];
    timer = nil;
    //开子线程
//    dispatch_async(dispatch_queue_create("verifyCodeTimer", NULL), ^{
//        
//    });
    if ([self.fl_delegate respondsToSelector:@selector(fl_didClickVerifyView:)]) {
        [self.fl_delegate fl_didClickVerifyView:self];
    }
//    NSTimer *oldTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
//    [[NSRunLoop currentRunLoop] addTimer:oldTimer forMode:NSRunLoopCommonModes];
    NSTimer *oldTimer = [FLWeakTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    timer = oldTimer;
    if (timer) {
        self.userInteractionEnabled = NO;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.pickerView.frame = CGRectMake(FLVerifyViewWidth / 2 - 25, 0, 40, FLverifyViewHeight);
    self.unitLabel.frame = CGRectMake(FLVerifyViewWidth / 2 - 6, 0, 40, FLverifyViewHeight);
    self.countDownFinishLabel.frame = self.bounds;
    
    // 一开始显示的文本
    NSString *normalText = FLVerifyViewNormalText;
    if (_fl_normalLabel) {
        normalText = _fl_normalLabel.text;
    }
    self.countDownFinishLabel.text = normalText;
    self.countDownFinishLabel.font = _fl_normalLabel.font;
    
//    NSString *countDownCompeteText = FLVerifyViewCountDownEndText;
//    if (_fl_countDownCompleteLabel) {
//        countDownCompeteText = _fl_countDownCompleteLabel.text;
//    }
//    self.countDownFinishLabel.text = countDownCompeteText;
}

#pragma mark - UIPickerViewDatasource & UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _count + 1;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return self.bounds.size.height + 10;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(12.0f, 0.0f, [pickerView rowSizeForComponent:component].width-12, self.bounds.size.height)];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:12];
    
    NSInteger num = _count - row ;
    NSString *numStr = [NSString stringWithFormat:@"%zd",num--];
//    self.countDownTime = num;
    label.text = numStr;
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}


- (void)countDown{
    _num = _num + 1;
    [self.pickerView selectRow:_num inComponent:0 animated:YES];
    if (_num == _count) {
        // 重置_num
        _num = 0;
        [timer invalidate];
        timer = nil;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //判断是否实现了代理方法
            if ([self.fl_delegate respondsToSelector:@selector(fl_countDownCompleteInVerifyView:)]) {
                [self.fl_delegate fl_countDownCompleteInVerifyView:self];
            }
            
            // 判断是否实现block
            if (self.fl_verifyCountDownCompete) {
                self.fl_verifyCountDownCompete();
            }
            // 添加动画
            [UIView animateWithDuration:1.0 animations:^{
                //隐藏pickerView
                self.pickerView.hidden = YES;
                self.unitLabel.hidden = YES;
                self.userInteractionEnabled = YES;
                
                NSString *countDownCompeteText = FLVerifyViewCountDownEndText;
                if (_fl_countDownCompleteLabel) {
                    countDownCompeteText = _fl_countDownCompleteLabel.text;
                }
                self.countDownFinishLabel.text = countDownCompeteText;
                
                [self layoutIfNeeded];
                
                self.countDownFinishLabel.alpha = 0.5;
                
            } completion:^(BOOL finished) {
                self.countDownFinishLabel.alpha = 1;
            }];
        });
    }
}

- (void)invalidateVeritifyView{
    [timer invalidate];
    timer = nil;
}

#pragma mark - setter & getter

- (void)setFl_countDownTime:(NSInteger)fl_countDownTime{
    _fl_countDownTime = fl_countDownTime;
    _count = fl_countDownTime - 1;
    _originalCount = fl_countDownTime - 1;
}

- (void)setFl_normalLabel:(UILabel *)fl_normalLabel{
    _fl_normalLabel = fl_normalLabel;
    [self.pickerView reloadAllComponents];
}

- (void)setFl_countDownCompleteLabel:(UILabel *)fl_countDownCompleteLabel{
    _fl_countDownCompleteLabel = fl_countDownCompleteLabel;
    [self.pickerView reloadAllComponents];
}

- (UIPickerView *)pickerView{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.showsSelectionIndicator = YES;
        _pickerView.userInteractionEnabled = NO;
    }
    return _pickerView;
}

- (UILabel *)countDownFinishLabel{
    if (_countDownFinishLabel == nil) {
        _countDownFinishLabel = [[UILabel alloc] init];
        _countDownFinishLabel.textColor = [UIColor whiteColor];
        [self addSubview:_countDownFinishLabel];
    }
    return _countDownFinishLabel;
}

- (UILabel *)unitLabel{
    if (_unitLabel == nil) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.text = FLVerifyViewCountDownUnitText;
        _unitLabel.textAlignment = NSTextAlignmentCenter;
        _unitLabel.font = [UIFont systemFontOfSize:12];
        _unitLabel.textColor = [UIColor whiteColor];
    }
    return _unitLabel;
}

@end
