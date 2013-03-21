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
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // if only one point is valid, just draw that point as a dot
    // if 2 points are valid, draw 2 dots and connect with a line
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    // set color
    const CGFloat *components = CGColorGetComponents(self.color.CGColor);
    CGFloat RGBA[] = {components[0], components[1], components[2], self.isGhost ? GHOST_TRANSPARENCY : 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
}


@end
