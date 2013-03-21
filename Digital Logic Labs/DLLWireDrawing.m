//
//  DLLWireDrawing.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireDrawing.h"

@implementation DLLWireDrawing

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
    if(self.isGhost){
        // draw ghost
    }else{
        // draw solid
    }
}


@end
