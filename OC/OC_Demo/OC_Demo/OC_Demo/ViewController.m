//
//  ViewController.m
//  OC_Demo
//
//  Created by clarence on 16/8/30.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Model.h"
#import "Person.h"
#import "NSString+CGSize.h"
#import "NSString+Line.h"
#import "UIFont+FLUnits.h"
@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArr = [NSMutableArray array];
    NSArray *dictArr = @[@{@"name" : @"Jack",
                           @"userId" : @"11111",
                           @"classes" : @{@"className" : @"Chinese", @"time" : @"2016_03"},
                           @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                           @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                           @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]},
                         @{@"name" : @"Rose",
                           @"userId" : @"22222",
                           @"classes" : @{@"className" : @"Math", @"time" : @"2016_04"},
                           @"teachers" : @[@{@"teaName" : @"Lisa1", @"teaAge" : @"21"},
                                           @{@"teaName" : @"Lisa2", @"teaAge" : @"22"},
                                           @{@"teaName" : @"Lisa3", @"teaAge" : @"23"}]}];
    
    
    for (NSDictionary *dict in dictArr) {
        Person *p = [Person fl_modelWithDict:dict];
        [self.dataArr addObject:p];
    }
    
//    NSLog(@"dataArr = %@", self.dataArr);
    
    Person *person = self.dataArr.lastObject;
    NSLog(@"%@%@%lf",person.name,person.teachers,[UIFont systemFontSize]);
    
    NSLog(@"width = %lf---height = %lf",[person.name fl_textWidthWithFont:[UIFont systemFontOfSize:17]],[@"hjahdshajhdkjfhalkhdljfhafd" fl_textHeightWithMaxWidth:100.0f font:[UIFont systemFontOfSize:17]]);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, [person.name fl_textWidthWithFont:[UIFont systemFontOfSize:17]], 30)];
    label.text = person.name;
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 100, [@"hjahdshajhdkjfhalkhdljfhafd" fl_textHeightWithMaxWidth:100.0f font:[UIFont systemFontOfSize:[UIFont fl_systemFontSize]]])];
    label1.attributedText = @"hjahdshajhdkjfhalkhdljfhafd".fl_addCenterLine;
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    
    [UIFont systemFontSize];
    
    UIFont *newFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    UIFontDescriptor *ctfFont = newFont.fontDescriptor;
    NSNumber *fontString = [ctfFont objectForKey:@"NSFontSizeAttribute"];
    NSLog(@"fontSize = %lf--%lf--%lf--%lf--%lf",[UIFont systemFontSize],[UIFont labelFontSize],[UIFont buttonFontSize],[UIFont smallSystemFontSize],fontString.floatValue);
}

@end
