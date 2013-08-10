//
//  UIView+Extensions.m
//

#import "UIView+Extensions.h"

@implementation UIView (Extensions)

- (void)setCenterX:(CGFloat)centerX
{
    self.frame = CGRectMake((centerX - (self.frame.size.width / 2)),
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    self.frame = CGRectMake(self.frame.origin.x,
                            (centerY - (self.frame.size.height / 2)),
                            self.frame.size.width,
                            self.frame.size.height);
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setHeight:(CGFloat)height
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setWidth:(CGFloat)width
{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

@end
