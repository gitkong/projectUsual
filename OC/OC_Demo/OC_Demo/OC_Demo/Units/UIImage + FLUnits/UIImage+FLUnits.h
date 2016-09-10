//
//  UIImage+FLUnits.h
//
//  Created by 孔凡列 on 16/7/7.
//  Copyright © 2016年 czebd. All rights reserved.
//

/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 *
 * QQ 279761135
 */

#import <UIKit/UIKit.h>

@interface UIImage (FLUnits)
#pragma mark - 圆形图片裁剪
/**
 *  @author Clarence-lie, 16-07-07 00:07:13
 *
 *  获得圆形图片
 *
 *  @return 圆形图片
 */
- (instancetype)fl_circleImage;

/**
 *  @author Clarence-lie, 16-07-07 00:07:02
 *
 *  指定图片名字获得圆形图片
 *
 *  @param name 图片名字
 *
 *  @return 图片名字获得圆形图片
 */
+ (instancetype)fl_circleImageNamed:(NSString *)name;

/**
 *  @author 孔凡列, 16-09-11 01:09:11
 *
 *  图片添加毛玻璃滤镜效果
 *
 *  @param image image description
 *  @param blur  比例
 *
 *  @return return value description
 */
+ (UIImage *)fl_blurImage:(UIImage *)image blur:(CGFloat)blur;

+ (UIImage *)fl_imageWithColor:(UIColor *)color size:(CGSize)size;
/**
 *  @author 孔凡列, 16-09-11 01:09:52
 *
 *  获得圆形图片
 *
 *  @param originImage originImage description
 *  @param borderColor borderColor description
 *  @param borderWidth borderWidth description
 *
 *  @return return value description
 */
+ (UIImage *)fl_circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;






#pragma mark - 图片拉伸
/**
 *  类方法：对图片进行拉伸
 *
 *  @param imageName 需要拉伸的图片名称
 *
 *  @return 返回已经拉伸后的UIImage对象
 */
+ (instancetype)fl_resizeImageWithImageName:(NSString *)imageName;
/**
 *  对图片进行拉伸
 *
 *  @param imageName 需要拉伸的图片名称
 *  @param left      拉伸左边的系数（0-1）,有默认值为0.5
 *  @param top       拉伸上边的系数（0-1）,有默认值为0.5
 *
 *  @return 返回已经拉伸后的UIImage对象
 */
+ (instancetype)fl_resizeImageWithImageName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top;

#pragma mark - 利用颜色创建图片
/*
 *  使用UIColor创建UIImage
 */
+ (instancetype)fl_createImageWithColor: (UIColor *)color;

#pragma mark --从指定的路径加载GIF并创建UIImageView
// 从指定的路径加载GIF并创建UIImageView
+ (UIImageView *)fl_imageViewWithGIFFile:(NSString *)file frame:(CGRect)frame;

@end
