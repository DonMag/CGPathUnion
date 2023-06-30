//
//  PathGen.m
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import "PathGen.h"

@implementation PathGen

+ (CGMutablePathRef)buildShape:(ShapeType)s rect:(CGRect)rect {
	return [self buildShape:s rect:rect numSides:0];
}
+ (CGMutablePathRef)buildShape:(ShapeType)s rect:(CGRect)rect numSides:(NSInteger)numSides {
	CGMutablePathRef newPath = CGPathCreateMutable();
	
	switch (s) {
		case kSquare:
			newPath = CGPathCreateMutableCopy(CGPathCreateWithRect(rect, nil));
			break;
			
		case kCircle:
			newPath = CGPathCreateMutableCopy(CGPathCreateWithEllipseInRect(rect, nil));
			break;
			
		case kDiamond:
			CGPathMoveToPoint(newPath, nil, CGRectGetMidX(rect), CGRectGetMinY(rect));
			CGPathAddLineToPoint(newPath, nil, CGRectGetMaxX(rect), CGRectGetMidY(rect));
			CGPathAddLineToPoint(newPath, nil, CGRectGetMidX(rect), CGRectGetMaxY(rect));
			CGPathAddLineToPoint(newPath, nil, CGRectGetMinX(rect), CGRectGetMidY(rect));
			CGPathCloseSubpath(newPath);
			break;
			
		case kTriangle:
			CGPathMoveToPoint(newPath, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect));
			CGPathAddLineToPoint(newPath, nil, CGRectGetMidX(rect), CGRectGetMinY(rect));
			CGPathAddLineToPoint(newPath, nil, CGRectGetMaxX(rect), CGRectGetMaxY(rect));
			CGPathCloseSubpath(newPath);
			break;
			
		case kPacMan:
		{
			CGRect r = rect;
			r.origin = CGPointZero;
			r.size.height = r.size.width;
			CGPoint cntr = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
			CGPathMoveToPoint(newPath, nil, cntr.x, cntr.y);
			CGPathAddArc(newPath, nil, cntr.x, cntr.y, r.size.width * 0.5, M_PI * 0.25, M_PI * 1.75, NO);
			CGPathCloseSubpath(newPath);
			CGAffineTransform t1 = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, rect.size.height / rect.size.width);
			CGAffineTransform t2 = CGAffineTransformTranslate(t1, rect.origin.x, rect.origin.y);
			newPath = CGPathCreateMutableCopyByTransformingPath(newPath, &t2);
		}
			break;
			
		case kPolygon:
			if (numSides < 1) break;
		{
			// we'll base the polygon on a 1:1 circle
			CGRect r = rect;
			r.origin = CGPointZero;
			r.size.height = r.size.width;
			CGFloat radius = r.size.width * 0.5;
			CGPoint cntr = CGPointMake(CGRectGetMidX(r), CGRectGetMidY(r));
			// we *could* use maths to calculate the polygon points, but instead
			//	let's "cheat" by adding arcs, and get the points from each arc endPoint
			CGMutablePathRef arcPath = CGPathCreateMutable();
			CGMutablePathRef ptPath = CGPathCreateMutable();
			// start at "12 o'clock"
			double startA = M_PI * 1.5;
			double radianInc = (M_PI * 2.0) / (double)numSides;
			CGPoint pt = CGPointMake(CGRectGetMidX(r), CGRectGetMinY(r));
			CGPathMoveToPoint(arcPath, nil, pt.x, pt.y);
			CGPathMoveToPoint(ptPath, nil, pt.x, pt.y);
			for (int i = 0; i < (numSides - 1); i++) {
				CGPathAddArc(arcPath, nil, cntr.x, cntr.y, radius, startA, startA + radianInc, YES);
				CGPoint curPT = CGPathGetCurrentPoint(arcPath);
				CGPathAddLineToPoint(ptPath, nil, curPT.x, curPT.y);
				startA += radianInc;
			}
			CGPathCloseSubpath(ptPath);
			// now we need to scale the polygon to the desired rect
			CGAffineTransform t1 = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, rect.size.height / rect.size.width);
			CGAffineTransform t2 = CGAffineTransformTranslate(t1, rect.origin.x, rect.origin.y);
			newPath = CGPathCreateMutableCopyByTransformingPath(ptPath, &t2);
		}
			break;
			
		default:
			break;
	}
	
	return newPath;
}

@end
