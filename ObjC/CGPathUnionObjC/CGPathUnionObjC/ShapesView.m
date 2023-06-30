//
//  ShapesView.m
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import "ShapesView.h"

@interface ShapesView ()
{
	NSMutableArray <MyShape *>*theShapes;
	CAShapeLayer *shapeLayer;
	NSInteger activeIDX;
	CGPoint currentPT;
}
@end

@implementation ShapesView

- (instancetype)init
{
	self = [super init];
	if (self) {
		[self commonInit];
	}
	return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		[self commonInit];
	}
	return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		[self commonInit];
	}
	return self;
}

- (void)commonInit {
	shapeLayer = [CAShapeLayer new];
	shapeLayer.fillColor = UIColor.clearColor.CGColor;
	shapeLayer.strokeColor = UIColor.blueColor.CGColor;
	shapeLayer.lineWidth = 8.0;
	shapeLayer.lineJoin = kCALineJoinRound;
	[self.layer addSublayer:shapeLayer];
	
	theShapes = [NSMutableArray new];
	activeIDX = -1;
	currentPT = CGPointZero;
}

- (void)addShape: (MyShape *)shape {
	[theShapes addObject:shape];
	[self setNeedsLayout];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesBegan:touches withEvent:event];
	UITouch *touch = [touches anyObject];
	currentPT = [touch locationInView:self];
	activeIDX = -1;
	for (int i = 0; i < theShapes.count; i++) {
		MyShape *shape = theShapes[i];
		CGAffineTransform t = CGAffineTransformMakeTranslation(-shape.offset.x, -shape.offset.y);
		if (CGPathContainsPoint(shape.thePath, &t, currentPT, NO)) {
			activeIDX = i;
			break;
		}
	}
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	[super touchesMoved:touches withEvent:event];
	if (activeIDX == -1) { return; }
	UITouch *touch = [touches anyObject];
	CGPoint pt = [touch locationInView:self];
	CGPoint newOffset = theShapes[activeIDX].offset;
	newOffset.x += (pt.x - currentPT.x);
	newOffset.y += (pt.y - currentPT.y);
	theShapes[activeIDX].offset = newOffset;
	currentPT = pt;
	[self setNeedsLayout];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	shapeLayer.path = nil;
	
	if (theShapes.count == 0) {
		return;
	}
	
	CGPathRef pth = nil;
	for (MyShape *shape in theShapes) {
		// move the path based on the offset property of MyPath
		CGAffineTransform t = CGAffineTransformMakeTranslation(shape.offset.x, shape.offset.y);
		CGPathRef pr = CGPathCreateCopyByTransformingPath(shape.thePath, &t);
		if (pth == nil) {
			// this is the first path
			pth = pr;
		} else {
			// union the paths
			pth = CGPathCreateCopyByUnioningPath(pth, pr, NO);
		}
	}
	shapeLayer.path = pth;
}

@end
