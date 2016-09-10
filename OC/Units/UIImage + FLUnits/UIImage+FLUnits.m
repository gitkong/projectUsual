//
//  UIImage+FLUnits.m
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

#import "UIImage+FLUnits.h"
#import <ImageIO/ImageIO.h>
#import <Accelerate/Accelerate.h>
@implementation UIImage (FLUnits)
- (instancetype)fl_circleImage{
    // self -> 圆形图片
    
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 添加一个圆
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    
    // 裁剪
    CGContextClip(context);
    
    // 绘制图片到圆上面
    [self drawInRect:rect];
    
    // 获得图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 结束图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}


+ (instancetype)fl_circleImageNamed:(NSString *)name{
    return [[self imageNamed:name] fl_circleImage];
}

+ (UIImage *)fl_blurImage:(UIImage *)image blur:(CGFloat)blur;
{
    // 模糊度越界
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

+ (UIImage *)fl_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (color) {
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context,color.CGColor);
        CGContextFillRect(context, rect);
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
    return nil;
}

+ (UIImage *)fl_circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth
{
    //设置边框宽度
    CGFloat imageWH = originImage.size.width;
    
    //计算外圆的尺寸
    CGFloat ovalWH = imageWH + 2 * borderWidth;
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(originImage.size, NO, 0);
    
    //画一个大的圆形
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, ovalWH, ovalWH)];
    
    [borderColor set];
    
    [path fill];
    
    //设置裁剪区域
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, imageWH, imageWH)];
    [clipPath addClip];
    
    //绘制图片
    [originImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    //从上下文中获取图片
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    return resultImage;
}



/**
 *  类方法：对图片进行拉伸
 *
 *  @param imageName 需要拉伸的图片名称
 *
 *  @return 返回已经拉伸后的UIImage对象
 */
+ (instancetype)fl_resizeImageWithImageName:(NSString *)imageName{
    //    通过传入的图片名创建UIImage对象
    UIImage *image = [self imageNamed:imageName];
    //    设置以图片的中心点来拉伸点，而不是全部拉伸
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat top = imageH * 0.5;
    CGFloat left = imageW * 0.5;
    CGFloat bottom = top;
    CGFloat right = left;
    //    返回一个已经进行拉伸后的UIImage对象
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(top, left, bottom, right) resizingMode:UIImageResizingModeStretch];
    //        iOS (2.0 and later)Deprecated:Deprecated. Use the resizableImageWithCapInsets: instead, specifying cap insets such that the interior is a 1x1 area.
    //    return [image stretchableImageWithLeftCapWidth:left topCapHeight:top];
}
/**
 *  对图片进行拉伸
 *
 *  @param imageName 需要拉伸的图片名称
 *  @param left      拉伸左边的系数（0-1）,有默认值为0.5
 *  @param top       拉伸上边的系数（0-1）,有默认值为0.5
 *
 *  @return 返回已经拉伸后的UIImage对象
 */
+ (instancetype)fl_resizeImageWithImageName:(NSString *)imageName left:(CGFloat)left top:(CGFloat)top{
    //    通过传入的图片名创建UIImage对象
    UIImage *image = [self imageNamed:imageName];
    //    设置以图片的中心点来拉伸点，而不是全部拉伸
    CGFloat imageW = image.size.width;
    CGFloat imageH = image.size.height;
    CGFloat imageTop = imageH * 0.5;
    CGFloat imageLeft = imageW * 0.5;
    //    CGFloat bottom = imageTop;
    //    CGFloat right = imageLeft;
    //    返回一个已经进行拉伸后的UIImage对象
    //    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(imageTop, imageLeft, bottom, right) resizingMode:UIImageResizingModeStretch];
    //        iOS (2.0 and later)Deprecated:Deprecated. Use the resizableImageWithCapInsets: instead, specifying cap insets such that the interior is a 1x1 area.
    return [image stretchableImageWithLeftCapWidth:left ? left * imageW : imageLeft topCapHeight:top ? top * imageH : imageTop];
}

+ (instancetype)fl_createImageWithColor: (UIColor *)color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImageView *)fl_imageViewWithGIFFile:(NSString *)file frame:(CGRect)frame {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    
    // 加载gif文件数据
    NSData *gifData = [NSData dataWithContentsOfFile:file];
    
    // GIF动画图片数组
    NSMutableArray *frames = nil;
    // 图像源引用
    CGImageSourceRef src = CGImageSourceCreateWithData((__bridge CFDataRef)gifData, NULL);
    // 动画时长
    CGFloat animationTime = 0.f;
    
    if (src) {
        // 获取gif图片的帧数
        size_t count = CGImageSourceGetCount(src);
        // 实例化图片数组
        frames = [NSMutableArray arrayWithCapacity:count];
        
        for (size_t i = 0; i < count; i++) {
            // 获取指定帧图像
            CGImageRef image = CGImageSourceCreateImageAtIndex(src, i, NULL);
            
            // 获取GIF动画时长
            NSDictionary *properties = (__bridge NSDictionary *)CGImageSourceCopyPropertiesAtIndex(src, i, NULL);
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            
            if (image) {
                [frames addObject:[UIImage imageWithCGImage:image]];
                CGImageRelease(image);
            }
        }
        
        CFRelease(src);
    }
    
    [imageView setImage:[frames objectAtIndex:0]];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setAnimationImages:frames];
    [imageView setAnimationDuration:animationTime];
    [imageView startAnimating];
    
    return imageView;
}

@end
