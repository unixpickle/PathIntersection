//
//  ANPathIntersection.h
//  PathIntersection
//
//  Created by Alex Nichol on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANPathBitmap.h"

@interface ANPathIntersection : NSObject {
	ANPathBitmap * path1;
	ANPathBitmap * path2;
}

- (id)initWithPathBitmap:(ANPathBitmap *)aPath anotherPath:(ANPathBitmap *)anotherPath;
- (BOOL)pathLinesIntersect:(CGPoint *)iPoint;

@end
