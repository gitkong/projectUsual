//
//  FLDashedLine.m
//  FLToolDemo
//
//  Created by 孔凡列 on 16/7/24.
//  Copyright © 2016年 czebd. All rights reserved.
//

#import "FLDashedLine.h"

@implementation FLDashedLine

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
+ (instancetype)fl_createDashedLineWithFrame:(CGRect)viewFrame lineLength:(int)lineLength lineSpace:(int)lineSpace lineColor:(UIColor *)lineColor{
    FLDashedLine *dashedLine = [[self alloc] initWithFrame:viewFrame];
    dashedLine.backgroundColor = [UIColor clearColor];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.bounds = dashedLine.bounds;
    shapeLayer.position = CGPointMake(CGRectGetWidth(dashedLine.frame) / 2, CGRectGetHeight(dashedLine.frame));
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = lineColor.CGColor;
    shapeLayer.lineWidth = CGRectGetHeight(dashedLine.frame);
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineDashPattern = [NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength],[NSNumber numberWithInt:lineSpace],nil];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(dashedLine.frame), 0);
    shapeLayer.path = path;
    CGPathRelease(path);
    [dashedLine.layer addSublayer:shapeLayer];
    return dashedLine;
}

@end
