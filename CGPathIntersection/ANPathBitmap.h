//
//  ANPathBitmap.h
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANImageBitmapRep.h"

@interface ANPathBitmap : NSObject {
	CGRect boundingBox;
	CGRect originalBounds;
	ANImageBitmapRep * bitmap;
	
	CGFloat lineThickness;
	CGLineCap lineCap;
	
	CGPathRef path;
}

@property (readonly) CGRect boundingBox;
@property (readwrite) CGFloat lineThickness;
@property (readwrite) CGLineCap lineCap;

- (id)initWithPath:(CGPathRef)aPath;
- (void)generateBitmap;

- (BOOL)isTransparentAtPoint:(CGPoint)aPoint;

@end
