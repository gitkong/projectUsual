//
//  SecondViewController.m
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+FLUnits.h"
#import "Macros.h"
#import "UIView+NOData.h"
#import "ThirdViewController.h"
#import "UINavigationBar+NavigationBarBackground.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SecondViewController{
    BOOL _flage;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _flage = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.fl_navBarColor = [UIColor orangeColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"second viewController";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 400)];
//    view.backgroundColor = [UIColor grayColor];
//    __weak typeof(view) weakView = view;
//    [view fl_showNoDataViewOperation:^{
//        NSLog(@"hello world");
//        [weakView fl_hideNoDataView];
//    }];
//    [self.view addSubview:view];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [self.navigationController.navigationBar fl_setBackgroundViewWithColor:[UIColor clearColor]];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!_flage) {
//        CGPoint offset = scrollView.contentOffset;
        [self.navigationController.navigationBar fl_setBackgroundViewWithColor:RANDOM_RGB];
    }
    
}

#pragma mark - Table view data source & delegate
static NSString * resueId = @"cell";

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resueId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resueId];
    }
    cell.textLabel.text = @"hello world";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[ThirdViewController alloc] init] animated:YES];
//    [self.navigationController.navigationBar fl_resetBackgroundDefaultStyle];
    _flage = YES;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    [self.view fl_showNoDateView:^{
////        NSLog(@"hello world");
////    }];
//    __weak typeof(self) weakSelf = self;
//    [self.view fl_showNoDataViewOperation:^{
//        NSLog(@"hello world");
//        [weakSelf.view fl_hideNoDataView];
//    }];
//}

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
