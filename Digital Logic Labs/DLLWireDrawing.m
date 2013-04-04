//
//  DLLWireDrawing.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireDrawing.h"

@implementation DLLWireDrawing

#define LINE_WIDTH 2.0
#define GHOST_TRANSPARENCY 0.5
#define SOLID_CIRCLE_DIAMETER 12
#define GHOST_CIRCLE_DIAMETER 20
// original circle diameter = 12

@synthesize color = _color;
@synthesize isGhost = _isGhost;
@synthesize start = _start;
@synthesize end = _end;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.color = [UIColor redColor];
        self.start = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        self.isGhost = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame fromStart:(CGPoint)start toEnd:(CGPoint)end asGhost:(BOOL)isGhost withColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = color;
        self.start = start;
        self.end = end;
        self.isGhost = isGhost;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // if start is invalid, throw an error
    if(self.start.x <= 0 && self.start.y <= 0){
        [NSException raise:NSInternalInconsistencyException format:@"Start point is invalid."];
    }
    // if only start point is valid, just draw that point as a dot
    // if 2 points are valid, draw 2 dots and connect with a line
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // set color
    const CGFloat *components = CGColorGetComponents(self.color.CGColor);
    CGFloat RGBA[] = {components[0], components[1], components[2], self.isGhost ? GHOST_TRANSPARENCY : 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorspace, RGBA);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetFillColorWithColor(context, color);
    // set line width
    CGContextSetLineWidth(context, LINE_WIDTH);
    // draw circle at start
    CGRect startRect = CGRectMake(self.start.x - (self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER)/2 , self.start.y - (self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER)/2, self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER, self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER);
    CGContextAddEllipseInRect(context, startRect);
    //CGContextStrokePath(context);
    CGContextFillEllipseInRect(context, startRect);
    // draw line to end and circle at end if end is valid
    if(self.end.x > 0 || self.end.y > 0){
        CGContextMoveToPoint(context, self.start.x, self.start.y);
        CGContextAddLineToPoint(context, self.end.x, self.end.y);
        CGContextStrokePath(context);
        CGRect endRect = CGRectMake(self.end.x - (self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER)/2, self.end.y - (self.isGhost ?GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER)/2, self.isGhost ? GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER, self.isGhost ?GHOST_CIRCLE_DIAMETER : SOLID_CIRCLE_DIAMETER);
        CGContextAddEllipseInRect(context, endRect);
        CGContextFillEllipseInRect(context, endRect);
    }
    // release colorspace
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}


@end
