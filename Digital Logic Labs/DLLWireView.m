//
//  DLLWireView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireView.h"

@implementation DLLWireView

// increase to move wire image more right
#define WIRE_X_OFFSET -96
// increase to move wire image more down
#define WIRE_Y_OFFSET 0  // changed by Brooke to fix power point problem

#pragma mark -
#pragma mark initialization methods
// initialize a wire with default values to be used in dock
- (id)initWire
{
    if((self = [super init])){
        self.start = CGPointMake(0, 0);
        self.end = CGPointMake(0, 0);
        self.color = [UIColor redColor];
        self.size = 1;
        self.image = [UIImage imageNamed:@"wire-large"];
    }
    return self;
}

- (id)initWireWithStartAt:(CGPoint)coords withColor:(UIColor *)color inView:(UIView *)view
{
    if((self = [super init])){
        self.start = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
        self.end = CGPointMake(0, 0);
        self.color = color;
        self.size = 1;
        self.image = [UIImage imageNamed:@"wire-large"];
        self.targetView = view;
    }
    return self;
}

- (id)initWireWithStartAt:(CGPoint)sCoords andEndAt:(CGPoint)eCoords withColor:(UIColor *)color inView:(UIView *)view
{
    if((self = [super init])){
        self.start = CGPointMake(sCoords.x+WIRE_X_OFFSET, sCoords.y+WIRE_Y_OFFSET);
        self.end = CGPointMake(eCoords.x+WIRE_X_OFFSET, eCoords.y+WIRE_Y_OFFSET);
        self.color = color;
        self.size = 1;
        self.image = [UIImage imageNamed:@"wire-large"];
        self.targetView = view;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
// called when touches ended
- (void)displayComponent
{
    if(self.wireDrawing){
        [self removeGraphics];
    }
    
    self.wireDrawing = [[DLLWireDrawing alloc] initWithFrame:self.targetView.frame fromStart:self.start toEnd:self.end asGhost:NO withColor:self.color];
    
    [self.targetView addSubview:self.wireDrawing];
    [self.wireDrawing setNeedsDisplay];
}

// called when touches began
- (void)displayGhostWithHoleAvailable:(BOOL)available
{
    if(self.wireDrawing){
        [self removeGraphics];
    }
    
    self.wireDrawing = [[DLLWireDrawing alloc] initWithFrame:self.targetView.frame fromStart:self.start toEnd:self.end asGhost:YES withColor:self.color];
    
    [self.targetView addSubview:self.wireDrawing];
    [self.wireDrawing setNeedsDisplay];
}

// called when touches moved
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    self.start = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
    [UIView beginAnimations:@"WireStartMove Move" context:NULL];
    self.wireDrawing.start = self.start;
    [self.wireDrawing setNeedsDisplay];
    [UIView commitAnimations];
}

// called when touches moved
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    self.end = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
    [UIView beginAnimations:@"WireEndMove Move" context:NULL];
    self.wireDrawing.end = self.end;
    [self.wireDrawing setNeedsDisplay];
    [UIView commitAnimations];
}

- (void)removeGraphics
{
    [self.wireDrawing removeFromSuperview];
    [self.wireDrawing setNeedsDisplay];
    self.wireDrawing = nil;
}

- (CGPoint)getOffsetPointFrom:(CGPoint)coords
{
    return CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
}

@end
