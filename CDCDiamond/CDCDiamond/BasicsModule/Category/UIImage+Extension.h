

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
+ (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)grayScaleImage;
- (UIImage *)autoStretchImage;
- (UIImage *)imageWithMask:(UIImage *)maskImage;
- (UIImage *)decompressedImageWithSize:(CGSize)targetSize;
- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor;
- (UIImage *)circleImageWithRect:(CGRect)rect radius:(CGFloat)radius;
- (UIImage *)shadowCircleImageWithRect:(CGRect)rect radius:(CGFloat)radius offset:(CGSize)offset blur:(CGFloat)blur;

+ (UIImage *)imageWithName:(NSString *)imageName bundleName:(NSString *)bundleName;

/**
 * 返回一张圆形图片
 */
- (instancetype)circleImage;

/**
 * 返回一张圆形图片
 */
+ (instancetype)circleImageNamed:(NSString *)name;

/**
 * 用rgb绘制图片
 */
+ (UIImage *)graphicsImageWithColor:(UIColor*)color rect:(CGRect)rect;

/**
 图片MD5

 @return 返回MD5值
 */
- (NSString *)MD5String;

//绘图
- (UIImage*)imageChangeColor:(UIColor*)color;
@end
