

#import <UIKit/UIKit.h>

@interface UIView (Extension)

/** X */
@property (nonatomic, assign) CGFloat x;

/** Y */
@property (nonatomic, assign) CGFloat y;

/** Width */
@property (nonatomic, assign) CGFloat width;

/** Height */
@property (nonatomic, assign) CGFloat height;

/** right */
@property (nonatomic, assign) CGFloat right;

/** left */
@property (nonatomic, assign) CGFloat left;

/** bottom */
@property (nonatomic, assign) CGFloat bottom;

/** top */
@property (nonatomic, assign) CGFloat top;

/** size */
@property (nonatomic, assign) CGSize size;

/** centerX */
@property (nonatomic, assign) CGFloat centerX;

/** centerY */
@property (nonatomic, assign) CGFloat centerY;

/** tag */
@property (nonatomic, copy) NSString *tagStr;

@end
