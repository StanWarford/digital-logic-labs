//
//  DLLWireView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireView.h"

@implementation DLLWireView

@synthesize end = _end;

#pragma mark -
#pragma mark initialization methods
// initialize a wire with default values to be used in dock
- (id)initWire
{
    if((self = [super init])){
        self.start = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        self.color = [UIColor redColor];
        self.image = [UIImage imageNamed:@"wire"];
    }
    return self;
}

-(id)initWireWithStartAt:(CGPoint)coords withColor:(UIColor *)color inView:(UIView *)view
{
    if((self = [super init])){
        self.start = coords;
        self.end = CGPointMake(0, 0);
        self.color = color;
        self.image = [UIImage imageNamed:@"wire"];
        self.targetView = view;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
// called when touches ended
- (void)displayComponent
{
    // assume both start and end are in valid positions.
    // draw 2 solid <self.color> dots at start and end
    // connect the two dots with a solid <self.color> line
}

// called when touches began
- (void)displayGhostWithHoleAvailable:(BOOL)available
{
    // assume start is a valid point
    // if end is (0,0) only draw ghost circle for start point
    // otherwise draw ghost circle for start point and end point, and connect with ghost line
}

// called when touches moved
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    // assume ghost image has already been drawn
    self.start = coords;
    [UIView beginAnimations:@"Start Move" context:NULL];
    // if end is (0, 0) only redraw start dot in a new position
    // otherwise redraw start dot, and connect start and end with ghost line
    [UIView commitAnimations];
}

// called when touches moved
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    // assume ghost image has already been drawn
    // assume start is in a valid position
    self.end = coords;
    [UIView beginAnimations:@"End Move" context:NULL];
    // redraw end dot and connect to start with ghost line
    [UIView commitAnimations];
}

// called when touches began
- (void)removeImageView
{
    // remove drawing from view
}

@end
