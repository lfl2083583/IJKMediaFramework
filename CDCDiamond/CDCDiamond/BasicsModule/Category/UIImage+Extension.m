

#import "UIImage+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)autoStretchImage;
{
    NSInteger leftCap = ceilf(self.size.width / 2.0) - 1;
    NSInteger topCap = ceilf(self.size.height / 2.0) - 1;
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)decompressedImageWithSize:(CGSize)targetSize
{
    CGImageRef imageRef = self.CGImage;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
    
    BOOL sameSize = NO;
    
    if (CGSizeEqualToSize(targetSize, CGSizeMake(CGImageGetWidth(imageRef), CGImageGetHeight(imageRef)))) {
        targetSize = CGSizeMake(1, 1);
        sameSize = YES;
    }
    
    size_t imageWidth = (size_t)targetSize.width;
    size_t imageHeight = (size_t)targetSize.height;
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 imageWidth * 4,   // Just always return width * 4 will be enough
                                                 colorSpace,       // System only supports RGB, set explicitly
                                                 alphaInfo | kCGBitmapByteOrder32Little  // Makes system don't need to do extra conversion when displayed.
                                                 );
    
    
    CGColorSpaceRelease(colorSpace);
    
    if (!context) {
        return nil;
    }
    
    CGRect rect = (CGRect){CGPointZero, {imageWidth, imageHeight}};
    CGContextDrawImage(context, rect, imageRef);
    if (sameSize) {
        CGContextRelease(context);
        return self;
    }
    CGImageRef decompressedImageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage *decompressedImage = [[UIImage alloc] initWithCGImage:decompressedImageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(decompressedImageRef);
    
    return decompressedImage;
}


- (UIImage *)imageWithMask:(UIImage *)maskImage
{
    CGImageRef maskRef = maskImage.CGImage;
    
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef maskedImageRef = CGImageCreateWithMask([self CGImage], mask);
    UIImage *maskedImage = [UIImage imageWithCGImage:maskedImageRef];
    
    CGImageRelease(mask);
    CGImageRelease(maskedImageRef);
    
    return maskedImage;
}

- (UIImage *)tintedImageUsingColor:(UIColor *)tintColor
{
    CGRect drawRect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    [self drawInRect:drawRect];
    [tintColor set];
    UIRectFillUsingBlendMode(drawRect, kCGBlendModeSourceAtop);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

- (UIImage *)circleImageWithRect:(CGRect)rect radius:(CGFloat)radius
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, rect.size.width, rect.size.height) cornerRadius:radius];
    
    CGFloat imageRatio = self.size.width / self.size.height;
    CGSize imageSize = CGSizeMake(rect.size.height * imageRatio, rect.size.height);
    CGRect imageRect = CGRectMake(0, 0, ceilf(imageSize.width), ceilf(imageSize.height));
    
    [path addClip];
    [self drawInRect:imageRect];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)grayScaleImage;
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    // Create image rectangle with current image width/height
    CGRect imageRect = CGRectMake(0, 0, self.size.width * scale, self.size.height * scale);
    // Grayscale color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width * scale, self.size.height * scale, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    // Draw image into current context, with specified rectangle
    // using previously defined context (with grayscale colorspace)
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // Create bitmap image info from pixel data in current context
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    // release the colorspace and graphics context
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    // make a new alpha-only graphics context
    context = CGBitmapContextCreate(nil, self.size.width * scale, self.size.height * scale, 8, 0, nil, (CGBitmapInfo)kCGImageAlphaOnly);
    // draw image into context with no colorspace
    CGContextDrawImage(context, imageRect, [self CGImage]);
    // create alpha bitmap mask from current context
    CGImageRef mask = CGBitmapContextCreateImage(context);
    // release graphics context
    CGContextRelease(context);
    // make UIImage from grayscale image with alpha mask
    CGImageRef grayScale = CGImageCreateWithMask(grayImage, mask);
    UIImage *grayScaleImage = [UIImage imageWithCGImage:grayScale scale:self.scale orientation:self.imageOrientation];
    // release the CG images
    CGImageRelease(grayScale);
    CGImageRelease(grayImage);
    CGImageRelease(mask);
    // return the new grayscale image
    return grayScaleImage;
}

- (UIImage *)shadowCircleImageWithRect:(CGRect)rect radius:(CGFloat)radius offset:(CGSize)offset blur:(CGFloat)blur
{
    UIImage *sourceImage = [self circleImageWithRect:rect radius:radius];
    
    CGFloat targetX;
    CGFloat targetY;
    CGFloat targetWidth;
    CGFloat targetHeight;
    
    if (offset.width == 0) {
        targetX = blur;
        targetWidth = rect.size.width + 2 * blur;
    }
    else if (offset.width > 0) {
        targetX = 0;
        targetWidth = rect.size.width + blur + offset.width;
    }
    else {
        targetX = blur + offset.width;
        targetWidth = rect.size.width + blur + offset.width;
    }
    
    if (offset.height == 0) {
        targetY = blur;
        targetHeight = rect.size.height + 2 * blur;
    }
    else if (offset.height > 0) {
        targetY = 0;
        targetHeight = rect.size.height + blur + offset.height;
    }
    else {
        targetY = blur + offset.height;
        targetHeight = rect.size.height + blur + offset.height;
    }
    
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth * scale, targetHeight * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, 0.0, rect.size.height * scale);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGRect pathRect = CGRectMake(targetX * scale, targetY * scale, rect.size.width * scale, rect.size.height * scale);
    
    CGColorRef colorRef = CGColorCreateCopy([[UIColor colorWithRed:0 green:0 blue:0 alpha:0.75] CGColor]);
    CGContextSetShadowWithColor(context, CGSizeMake(offset.width * scale, offset.height * scale), blur * scale, colorRef);
    CGColorRelease(colorRef);
    
    CGContextDrawImage(context, pathRect, sourceImage.CGImage);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageWithName:(NSString *)imageName bundleName:(NSString *)bundleName
{
    if (!bundleName) {
        return [UIImage imageNamed:imageName];
    }
    
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *bundlePath = [resourcePath stringByAppendingPathComponent:bundleName];
    NSString *imagePath = [bundlePath stringByAppendingPathComponent:imageName];
    imagePath = [imagePath stringByAppendingPathExtension:@"png"];
    
    return [UIImage imageWithContentsOfFile:imagePath];
}


- (instancetype)circleImage
{
    // 开启图形上下文
    UIGraphicsBeginImageContext(self.size);
    
    // 获得上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 矩形框
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    
    // 添加一个圆
    CGContextAddEllipseInRect(ctx, rect);
    
    // 裁剪(裁剪成刚才添加的图形形状)
    CGContextClip(ctx);
    
    // 往圆上面画一张图片
    [self drawInRect:rect];
    
    // 获得上下文中的图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭图形上下文
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)circleImageNamed:(NSString *)name
{
    return [[self imageNamed:name] circleImage];
}

+ (UIImage *)graphicsImageWithColor:(UIColor*)color rect:(CGRect)rect
{
   
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
}

- (NSString *)MD5String
{
    NSData *imageData = UIImagePNGRepresentation(self);
    unsigned char result[16];
    const char *imageStr = [imageData bytes];
    CC_MD5(imageStr, (CC_LONG)([imageData length]), result);
    NSString *imageHash = [NSString stringWithFormat:
                           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                           result[0], result[1], result[2], result[3],
                           result[4], result[5], result[6], result[7],
                           result[8], result[9], result[10], result[11],
                           result[12], result[13], result[14], result[15]
                           ];
    return imageHash;
}

- (UIImage*)imageChangeColor:(UIColor*)color
{    //获取画布
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);    //画笔沾取颜色
    [color setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);    //绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];    //再绘制一次
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();    UIGraphicsEndImageContext();    return img;
}
@end
