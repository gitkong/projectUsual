//
//  FLTranlucentRootViewController.h
//  OC_Demo
//
//  Created by clarence on 16/9/1.
//  Copyright © 2016年 clarence. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  @author 孔凡列, 16-09-01 09:09:27
 *
 *  使用方法：继承并设置fl_navBarColor
 */
@interface FLTranlucentRootViewController : UIViewController
/**
 *  @author 孔凡列, 16-09-01 09:09:44
 *
 *  默认clearColor，即透明，设置颜色为非透明
 */
@property (nonatomic,strong)UIColor *fl_navBarColor;

@end
