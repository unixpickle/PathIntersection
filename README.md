# Intersection of CGPathRefs

CGPaths can contain arcs, lines, rectangles, etc. These can then be stroked or filled on a CGContext, given a certain line color, thickness, and cap. In the case of this project, two paths are stroked on two separate contexts, and then any pixel based collisions are detected. This allows an application to programmatically check if two CGPaths intersect, and find where they intersect. This could be useful, for instance, for having a user work their finger around a maze, and checking if they hit a wall.

Although pixel-by-pixel collision detection is not the most efficient method, it is straight forward, and it gets the job done, possibly even better than raw mathematical detection would, since it emulates what the user would actually be seeing if the paths were drawn on screen.

# Usage

Given two CGPathRef variables, `lastPath` and `currentPath`, you could detect if and where they intersect as follows:

    ANPathBitmap * bm1 = [[ANPathBitmap alloc] initWithPath:lastPath];
    ANPathBitmap * bm2 = [[ANPathBitmap alloc] initWithPath:currentPath];
    bm1.lineCap = kCGLineCapRound;
    bm2.lineCap = kCGLineCapRound;
    bm1.lineThickness = 4;
    bm2.lineThickness = 4;
    [bm1 generateBitmap];
    [bm2 generateBitmap];
    CGPoint intPoint;
    ANPathIntersection * intersection = [[ANPathIntersection alloc] initWithPathBitmap:bm1
                                                                           anotherPath:bm2];
    if ([intersection pathLinesIntersect:&intPoint]) {
        NSLog(@"Point: %@", NSStringFromCGPoint(intPoint));
    } else {
        NSLog(@"No intersection");
    }

Since both paths are virtually stroked onto a CGContext, both the line thickness and the line cap must be explicitly specified for the detection to be accurate.

### An Example on Youtube

I have posted an example of this in the workings on Youtube so that all can see. [Check it out](http://www.youtube.com/watch?v=aFHJNh6iH8Y).