//

#import <Foundation/Foundation.h>

@interface FLBundleVersion : NSObject

@property (nonatomic,copy)NSString *appId;

+ (instancetype)shareBundleVersion;

/**
 *  @author 孔凡列, 16-08-24 18:08:35
 *
 *  本地的bundleVersion 是否最新
 *
 *  @return 最新返回YES，否则NO
 */
- (BOOL)isLocalBundleVersionRecently;

/**
 *  @author 孔凡列, 16-08-24 18:08:35
 *
 *  app stone的bundleVersion 是否最新
 *
 *  @return 最新返回YES，否则NO
 */

- (BOOL)isNetworkBundleVersionRecently;


@end
