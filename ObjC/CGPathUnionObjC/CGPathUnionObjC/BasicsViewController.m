//
//  BasicsViewController.m
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import "BasicsViewController.h"

@interface BasicsViewController ()

@end

@implementation BasicsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.title = @"The Basics...";
	self.view.backgroundColor = UIColor.systemBackgroundColor;
	
	UIStackView *sv = [UIStackView new];
	sv.axis = UILayoutConstraintAxisVertical;
	sv.spacing = 4.0;
	sv.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:sv];
	
	UILayoutGuide *g = self.view.safeAreaLayoutGuide;
	
	[NSLayoutConstraint activateConstraints:@[
		
		[sv.topAnchor constraintEqualToAnchor:g.topAnchor constant:20.0],
		[sv.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:20.0],
		[sv.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-20.0],
		
	]];

	NSArray *pathRects = [NSArray arrayWithObjects:
						  [NSValue valueWithCGRect:CGRectMake(60, 20, 100, 100)],
						  [NSValue valueWithCGRect:CGRectMake(200, 60, 100, 100)],
						  [NSValue valueWithCGRect:CGRectMake(100, 20, 100, 100)],
						  [NSValue valueWithCGRect:CGRectMake(160, 60, 100, 100)],
						  [NSValue valueWithCGRect:CGRectMake(100, 20, 100, 100)],
						  [NSValue valueWithCGRect:CGRectMake(160, 60, 100, 100)],
						  nil];
	
	NSInteger i = 0, j = 0;
	
	for (NSString *s in @[@"Two Paths", @"Overlapped", @"Union"]) {
		UILabel *label = [UILabel new];
		label.text = s;
		label.textAlignment = NSTextAlignmentCenter;
		[sv addArrangedSubview:label];
		UIView *v = [UIView new];
		v.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
		[v.heightAnchor constraintEqualToConstant:180.0].active = YES;
		CAShapeLayer *sl = [CAShapeLayer new];
		sl.fillColor = UIColor.clearColor.CGColor;
		sl.strokeColor = UIColor.blueColor.CGColor;
		sl.lineWidth = 8.0;
		sl.lineJoin = kCALineJoinRound;
		[v.layer addSublayer:sl];
		[sv addArrangedSubview:v];
		[sv setCustomSpacing:12.0 afterView:v];
		
		CGRect r1 = [[pathRects objectAtIndex:i++] CGRectValue];
		CGRect r2 = [[pathRects objectAtIndex:i++] CGRectValue];
		CGPathRef pthA = CGPathCreateWithRect(r1, nil);
		CGPathRef pthB = CGPathCreateWithRect(r2, nil);

		if (j == 0 || j == 1) {
			CGMutablePathRef pth = CGPathCreateMutable();
			CGPathAddPath(pth, nil, pthA);
			CGPathAddPath(pth, nil, pthB);
			sl.path = pth;
		} else {
			// union the paths
			CGPathRef pth = CGPathCreateCopyByUnioningPath(pthA, pthB, NO);
			sl.path = pth;
		}
		++j;
	}
	
}

@end
