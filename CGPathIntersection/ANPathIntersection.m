//
//  ANPathIntersection.m
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ANPathIntersection.h"

@implementation ANPathIntersection

- (id)initWithPathBitmap:(ANPathBitmap *)aPath anotherPath:(ANPathBitmap *)anotherPath {
	if ((self = [super init])) {
		path1 = aPath;
		path2 = anotherPath;
	}
	return self;
}

- (BOOL)pathLinesIntersect:(CGPoint *)iPoint; {
	NSInteger minX = MIN(floor(path1.boundingBox.origin.x), floor(path2.boundingBox.origin.x));
	NSInteger minY = MIN(floor(path1.boundingBox.origin.y), floor(path2.boundingBox.origin.y));
	NSInteger maxX = MAX(floor(path1.boundingBox.origin.x + path1.boundingBox.size.width),
						  floor(path2.boundingBox.origin.x + path2.boundingBox.size.width));
	NSInteger maxY = MAX(floor(path1.boundingBox.origin.y + path1.boundingBox.size.height),
						  floor(path2.boundingBox.origin.y + path2.boundingBox.size.height));
	
	for (NSInteger x = minX; x <= maxX; x++) {
		for (NSInteger y = minY; y <= maxY; y++) {
			CGPoint point = CGPointMake(x, y);
			BOOL clear1 = [path1 isTransparentAtPoint:point];
			BOOL clear2 = [path2 isTransparentAtPoint:point];
			if (!clear1 && !clear2) {
				if (iPoint) *iPoint = point;
				return YES;
			}
		}
	}
	return NO;
}

@end
