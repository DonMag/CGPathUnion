//
//  ShapesView.h
//  CGPathUnionObjC
//
//  Created by Don Mag on 6/30/23.
//

#import <UIKit/UIKit.h>
#import "MyShape.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShapesView : UIView
- (void)addShape: (MyShape *)shape;
@end

NS_ASSUME_NONNULL_END
