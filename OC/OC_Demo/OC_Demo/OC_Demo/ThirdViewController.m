//
//  ThirdViewController.m
//  OC_Demo
//
//  Created by clarence on 16/11/2.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "ThirdViewController.h"
#import "Macros.h"
#import "UINavigationBar+NavigationBarBackground.h"
@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)loadView{
    [super loadView];
    [self.navigationController.navigationBar fl_setBackgroundViewWithColor:[UIColor redColor]];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.navigationController.navigationBar fl_setBackgroundViewWithColor:[UIColor redColor]];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar fl_resetBackgroundDefaultStyle];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar fl_setBackgroundViewWithColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
