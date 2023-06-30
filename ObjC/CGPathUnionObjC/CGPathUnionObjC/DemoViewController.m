//
//  DemoViewController.m
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import "DemoViewController.h"
#import "PathGen.h"
#import "ShapesView.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

- (void)viewDidLoad {
	[super viewDidLoad];

	self.title = @"Drag the Shapes!";
	self.view.backgroundColor = UIColor.systemBackgroundColor;
	
	ShapesView *shapesView = [ShapesView new];
	shapesView.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:shapesView];
	
	UILayoutGuide *g = self.view.safeAreaLayoutGuide;
	
	[NSLayoutConstraint activateConstraints:@[
		
		[shapesView.topAnchor constraintEqualToAnchor:g.topAnchor constant:20.0],
		[shapesView.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[shapesView.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		[shapesView.bottomAnchor constraintEqualToAnchor:g.bottomAnchor constant:-20.0],
		
	]];
	
	CGRect r = CGRectMake(40.0, 20.0, 100.0, 100.0);
	
	// create and arrange Square, Diamond, Triangle, Circle and PacMan shapes
	//	and add them to pathsView
	for (NSInteger i = kFirstShape; i < kPolygon; i++) {
		CGMutablePathRef p = [PathGen buildShape:(ShapeType)i rect:r];
		MyShape *shape = [MyShape new];
		shape.thePath = p;
		[shapesView addShape:shape];
		if (r.origin.x > 40.0) {
			r.origin.x = 40.0;
			r.origin.y += r.size.height + 30.0;
		} else {
			r.origin.x += r.size.width + 60.0;
		}
	}
	
	// create and arrange a few polygons (5, 6, 7, 8 and 9 sides)
	//	and add them to pathsView
	for (NSInteger i = 5; i < 10; i++) {
		CGMutablePathRef p = [PathGen buildShape:kPolygon rect:r numSides:i];
		MyShape *shape = [MyShape new];
		shape.thePath = p;
		[shapesView addShape:shape];
		if (r.origin.x > 40.0) {
			r.origin.x = 40.0;
			r.origin.y += r.size.height + 30.0;
		} else {
			r.origin.x += r.size.width + 60.0;
		}
	}
	
	shapesView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
}

@end
