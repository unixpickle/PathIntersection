//
//  ANPathBitmap.m
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANPathBitmap.h"

@implementation ANPathBitmap

@synthesize boundingBox;
@synthesize lineThickness;
@synthesize lineCap;

- (id)initWithPath:(CGPathRef)aPath {
	if ((self = [super init])) {
		path = CGPathRetain(aPath);
		boundingBox = CGPathGetBoundingBox(aPath);
		originalBounds = boundingBox;
		lineThickness = 1;
		lineCap = kCGLineCapRound;
	}
	return self;
}

- (void)generateBitmap {
	boundingBox = originalBounds;
	boundingBox.size.width += lineThickness;
	boundingBox.size.height += lineThickness;
	boundingBox.origin.x -= lineThickness / 2.0;
	boundingBox.origin.y -= lineThickness / 2.0;
	boundingBox.size.width = ceil(boundingBox.size.width);
	boundingBox.size.height = ceil(boundingBox.size.height);
	boundingBox.origin.x = round(boundingBox.origin.x);
	boundingBox.origin.y = round(boundingBox.origin.y);
	
	BMPoint sizePoint = BMPointMake(boundingBox.size.width, boundingBox.size.height);
	bitmap = [[ANImageBitmapRep alloc] initWithSize:sizePoint];
	if (!bitmap) return;
	CGContextRef context = [bitmap context];
	
	CGContextSaveGState(context);
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
	// flip the context, translate to fit its bounding box.
	CGContextScaleCTM(context, 1, -1);
	CGContextTranslateCTM(context, -boundingBox.origin.x, -boundingBox.size.height - boundingBox.origin.y);
	
	CGContextSetLineWidth(context, lineThickness);
	CGContextSetLineCap(context, lineCap);
	
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	
	CGContextRestoreGState(context);
	
	[bitmap setNeedsUpdate:YES];
}

- (BOOL)isTransparentAtPoint:(CGPoint)aPoint {
	if (!bitmap) {
		[self generateBitmap];
		if (!bitmap) return YES;
	}
	CGPoint localPoint = aPoint;
	localPoint.x -= boundingBox.origin.x;
	localPoint.y -= boundingBox.origin.y;
	BMPoint bmPoint = BMPointMake(round(localPoint.x), round(localPoint.y));
	if (bmPoint.x < 0 || bmPoint.y < 0 || bmPoint.x >= bitmap.bitmapSize.x || bmPoint.y >= bitmap.bitmapSize.y) {
		return YES;
	}
	BMPixel pixel = [bitmap getPixelAtPoint:bmPoint];
	if (pixel.alpha > 0.5) return NO;
	return YES;
}

- (void)dealloc {
	CGPathRelease(path);
}

@end
