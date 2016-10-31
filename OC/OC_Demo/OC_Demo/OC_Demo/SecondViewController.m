//
//  SecondViewController.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+FLUnits.h"

#import "UIView+NOData.h"
//#import "UIView+FLUnits.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fl_navBarColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"second viewController";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
    view.backgroundColor = [UIColor grayColor];
    __weak typeof(view) weakView = view;
    [view fl_showNoDataViewOperation:^{
        NSLog(@"hello world");
        [weakView fl_hideNoDataView];
    }];
    [self.view addSubview:view];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.view fl_showNoDateView:^{
//        NSLog(@"hello world");
//    }];
    __weak typeof(self) weakSelf = self;
    [self.view fl_showNoDataViewOperation:^{
        NSLog(@"hello world");
        [weakSelf.view fl_hideNoDataView];
    }];
}

- (void)back {
    if (self.fl_judgeTranstion == FLTransitionStyleModal) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
