//
//  FLDashedLine.h
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/24.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FLDashedLine : UIView
/**
 *  @author Clarence-lie, 16-07-24 15:07:31
 *
 *  创建虚线的view（就是虚线啦）
 *
 *  @param viewFrame  虚线的frame
 *  @param lineLength 每一节线的长度
 *  @param lineSpace  俩一节线之间的间隔
 *  @param lineColor  每一节线的颜色
 *
 *  @return 返回创建好的虚线
 */
+ (instancetype)fl_createDashedLineWithFrame:(CGRect)viewFrame lineLength:(int)lineLength lineSpace:(int)lineSpace lineColor:(UIColor *)lineColor;

@end
