//
//  PathDrawView.h
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANPathIntersection.h"

@interface PathDrawView : UIView {
	CGMutablePathRef lastPath;
	CGMutablePathRef currentPath;
	UILabel * label;
	CGPoint intPoint;
	BOOL shouldClear;
}

- (void)addPoint:(CGPoint)aPoint;
- (void)fingerLifted;

@end
