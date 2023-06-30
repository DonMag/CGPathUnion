//
//  PathGen.h
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSInteger {
	kFirstShape = 0,
	kSquare = kFirstShape, kDiamond, kTriangle, kCircle, kPacMan, kPolygon,
	kEndOfShapes
} ShapeType;

@interface PathGen : NSObject
+ (CGMutablePathRef)buildShape:(ShapeType)s rect:(CGRect)rect;
+ (CGMutablePathRef)buildShape:(ShapeType)s rect:(CGRect)rect numSides:(NSInteger)numSides;
@end

NS_ASSUME_NONNULL_END
