//
//  CGPathsView.m
//  Bussola
//
//  Created by Marano, Rob on 11/25/20.
//

#import "CGPathsView.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

@interface CGPathsView()
{
}
@end

@implementation CGPathsView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGContextRef context = [[NSGraphicsContext currentContext] CGContext];
    
    CGContextBeginPath(context);
    [self beginLinesDemo:context];
    CGContextClosePath(context);
}

- (void)beginLinesDemo:(CGContextRef)context
{
    //1.Line线
    
    CGContextSaveGState(context);
    cg_drawPentagramByLine(context, CGPointMake(150, 150), 100);
    NSColor *red = [NSColor redColor];
    CGContextSetFillColorWithColor(context, red.CGColor);
    CGContextSetStrokeColorWithColor(context, red.CGColor);
    CGContextSetLineWidth(context, 2);
    
//    CGMutablePathRef linePath = cg_drawLineByPath(CGPointZero, CGPointMake(100, 300));
//    CGContextAddPath(context, linePath);
//    cd_drawLines(context);
//    CGPathRelease(linePath);
    CGContextDrawPath(context, kCGPathFillStroke);
    CGContextRestoreGState(context);
}

#pragma mark - Drawing
void cg_drawPentagramByLine(CGContextRef context, CGPoint center,CGFloat radius)
{
    CGPoint p1 = CGPointMake(center.x, center.y - radius);
    
    CGContextMoveToPoint(context, p1.x, p1.y);
    
    CGFloat angle=4 * M_PI / 5.0;
    
    for (int i=1; i<=5; i++)
    {
        CGFloat x = center.x -sinf(i*angle)*radius;
        CGFloat y = center.y -cosf(i*angle)*radius;
        CGContextAddLineToPoint(context, x, y);
    }
    
    CGContextClosePath(context);
}

CGMutablePathRef cg_drawLineByPath(CGPoint fromPoint, CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddLineToPoint(path, nil, toPoint.x, toPoint.y);
    CGPathCloseSubpath(path);
    return path;
}

void cd_drawLines(CGContextRef context)
{
    CGPoint point2 = CGPointMake(100, 200);
    CGPoint point3 = CGPointMake(100, 300);
    CGPoint point4 = CGPointMake(200, 100);
    CGPoint points[3] = {point2, point3, point4};
    CGContextAddLines(context, points, 3);
}


#pragma mark - Arc
void cd_drawCircleByArc(CGContextRef context, CGPoint center, CGFloat radius)
{
    CGContextAddArc(context, center.x, center.y, radius, radians(0.0f), radians(360.0f), 0);
    
    //下面两种用法可以自行研究了
//    CGContextAddArcToPoint;
//    CGContextAddQuadCurveToPoint;
}

CGMutablePathRef cd_drawArcsByPath(CGPoint fromPoint,CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddArc(path, nil, fromPoint.x, fromPoint.y, 50, radians(-90.0f), radians((- 180.0f)), YES);
    CGPathCloseSubpath(path);
    //其他addArc方法同context创建arc的方法。
    return path;
}

#pragma mark - Curve
void cd_drawPinwheelByCurve(CGContextRef context,CGPoint refPoint1, CGPoint refPoint2, CGPoint fromPoint, CGPoint toPoint)
{
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddCurveToPoint(context, refPoint1.x, refPoint1.y, refPoint2.x, refPoint2.y, toPoint.x, toPoint.y);
    CGContextAddQuadCurveToPoint(context, refPoint1.x, refPoint1.y, toPoint.x, toPoint.y);
}

CGMutablePathRef cd_drawCurveByPath(CGPoint refPoint1, CGPoint refPoint2, CGPoint fromPoint, CGPoint toPoint)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, fromPoint.x, fromPoint.y);
    CGPathAddCurveToPoint(path, nil,refPoint1.x, refPoint1.y, refPoint2.x, refPoint2.y, toPoint.x, toPoint.y);
    CGPathCloseSubpath(path);
    return path;
}
#pragma mark - Ellipses
void cd_drawEllipses(CGContextRef context, CGRect rect)
{
    CGContextAddEllipseInRect(context, rect);
}

CGMutablePathRef cd_drawEllipsesByPath(CGRect rect)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddEllipseInRect(path, nil, rect);
    CGPathCloseSubpath(path);
    
    return path;
}

#pragma mark - Rectangle
void cd_drawRectangle(CGContextRef context, CGRect rect)
{
    CGContextAddRect(context, rect);
}

CGMutablePathRef cd_drawRectangleByPath(CGRect rect)
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddRect(path, nil, rect);
    CGPathCloseSubpath(path);
    
    return path;
}

void cd_drawRectangles(CGContextRef context)
{
    CGRect rect1 = CGRectMake(50, 20, 100, 100);
    CGRect rect2 = CGRectMake(50, 100, 200, 100);
    CGRect rect3 = CGRectMake(100, 200, 100, 100);
    CGRect rects[3] = {rect1, rect2, rect3};
    
    CGContextAddRects(context, rects, 3);
}

@end
