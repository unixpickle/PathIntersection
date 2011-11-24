//
//  PathDrawView.m
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PathDrawView.h"

@implementation PathDrawView

- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor whiteColor];
		label = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, 320, 24)];
		[label setBackgroundColor:[UIColor clearColor]];
		[label setText:@"Drag anywhere"];
		[label setTextAlignment:UITextAlignmentCenter];
		[self addSubview:label];
	}
	return self;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	[self addPoint:[[touches anyObject] locationInView:self]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self fingerLifted];
}

- (void)addPoint:(CGPoint)aPoint {
	intPoint = CGPointZero;
	if (shouldClear) {
		lastPath = NULL;
		currentPath = NULL;
		shouldClear = NO;
	}
	if (currentPath) {
		CGPathAddLineToPoint(currentPath, NULL, aPoint.x, aPoint.y);
		[self setNeedsDisplay];
	} else {
		currentPath = CGPathCreateMutable();
		CGPathMoveToPoint(currentPath, NULL, aPoint.x, aPoint.y);
	}
}

- (void)fingerLifted {
	if (!currentPath) return;
	if (!lastPath) {
		lastPath = currentPath;
		currentPath = NULL;
		[self setNeedsDisplay];
	} else {
		// TODO: check for intersection
		ANPathBitmap * bm1 = [[ANPathBitmap alloc] initWithPath:lastPath];
		ANPathBitmap * bm2 = [[ANPathBitmap alloc] initWithPath:currentPath];
		bm1.lineCap = kCGLineCapRound;
		bm2.lineCap = kCGLineCapRound;
		bm1.lineThickness = 4;
		bm2.lineThickness = 4;
		[bm1 generateBitmap];
		[bm2 generateBitmap];
		ANPathIntersection * intersection = [[ANPathIntersection alloc] initWithPathBitmap:bm1
																			   anotherPath:bm2];
		if ([intersection pathLinesIntersect:&intPoint]) {
			[label setText:@"Intersection"];
			[self setNeedsDisplay];
			shouldClear = YES;
		} else {
			[label setText:@"No Intersection"];
			intPoint = CGPointZero;
			lastPath = NULL;
			currentPath = NULL;
			[self setNeedsDisplay];
		}
	}
}

- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 4);
	CGContextSetLineCap(context, kCGLineCapRound);
	
	CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	
	if (lastPath) {
		CGContextSetRGBStrokeColor(context, 0.65, 0.65, 0.65, 1);
		CGContextAddPath(context, lastPath);
		CGContextStrokePath(context);
	}
	if (currentPath) {
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
		CGContextAddPath(context, currentPath);
		CGContextStrokePath(context);
	}
	
	if (shouldClear) {
		CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
		CGContextStrokeEllipseInRect(context, CGRectMake(intPoint.x - 3, intPoint.y - 3, 6, 6));
	}
}

@end
