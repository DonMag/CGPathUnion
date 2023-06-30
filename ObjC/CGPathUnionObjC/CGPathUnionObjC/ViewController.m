//
//  ViewController.m
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import "ViewController.h"
#import "BasicsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	UIAction *tapAction;
	UIButtonConfiguration *cfg;

	cfg = [UIButtonConfiguration filledButtonConfiguration];
	cfg.title = @"The Basics";
	tapAction = [UIAction actionWithHandler:^(UIAction* action){
		[self basicsTapped];
	}];
	
	UIButton *b1 = [UIButton buttonWithConfiguration:cfg primaryAction:tapAction];
	
	cfg = [UIButtonConfiguration filledButtonConfiguration];
	cfg.title = @"Dragging Demo";
	tapAction = [UIAction actionWithHandler:^(UIAction* action){
		[self demoTapped];
	}];
	
	UIButton *b2 = [UIButton buttonWithConfiguration:cfg primaryAction:tapAction];
	
	for (UIButton *b in @[b1, b2]) {
		b.translatesAutoresizingMaskIntoConstraints = NO;
		[self.view addSubview:b];
	}
	
	UILayoutGuide *g = self.view.safeAreaLayoutGuide;
	
	[NSLayoutConstraint activateConstraints:@[
		
		[b1.topAnchor constraintEqualToAnchor:g.topAnchor constant:120.0],
		[b1.centerXAnchor constraintEqualToAnchor:g.centerXAnchor constant:0.0],
		[b1.widthAnchor constraintEqualToConstant:200.0],
		
		[b2.topAnchor constraintEqualToAnchor:b1.bottomAnchor constant:40.0],
		[b2.centerXAnchor constraintEqualToAnchor:g.centerXAnchor constant:0.0],
		[b2.widthAnchor constraintEqualToConstant:200.0],
		
	]];
	
}
- (void)basicsTapped {
	BasicsViewController *vc = [BasicsViewController new];
	[self.navigationController pushViewController:vc animated:YES];
}
- (void)demoTapped {
	
}

@end
