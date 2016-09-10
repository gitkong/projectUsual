/*
 * author 孔凡列
 *
 * gitHub https://github.com/gitkong
 * cocoaChina http://code.cocoachina.com/user/
 * 简书 http://www.jianshu.com/users/fe5700cfb223/latest_articles
 * QQ 279761135
 * 喜欢就给个like 和 star 喔~
 */

#import <Foundation/Foundation.h>

@interface NSString (Separate)
/**
 *  @author 孔凡列, 16-09-11 01:09:41
 *
 *  指定分割字符串分割，可多个例如：@"hello,world!haha" ->分割characters可以为@","OR @",!"
 *
 *  @param characters 指定分割符
 *
 *  @return 字符串数组
 */
- (NSArray<NSString *> *)fl_separateByCharacters:(NSString *)characters;

@end
