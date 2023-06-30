//
//  MyShape.h
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyShape : NSObject
@property (assign, readwrite) CGMutablePathRef thePath;
@property (assign, readwrite) CGPoint offset;
@end

NS_ASSUME_NONNULL_END
