//
//  DLLWireView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireView.h"

@implementation DLLWireView

#define WIRE_X_OFFSET -24.4
#define WIRE_Y_OFFSET 0

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
        self.start = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
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
    if(self.wireDrawing){
        [self removeGraphics];
    }
    
    self.wireDrawing = [[DLLWireDrawing alloc] initWithFrame:self.targetView.frame fromStart:self.start toEnd:self.end asGhost:NO withColor:self.color];
    //[self.wireDrawing setNeedsDisplay];
    
    [self.targetView addSubview:self.wireDrawing];
}

// called when touches began
- (void)displayGhostWithHoleAvailable:(BOOL)available
{
    if(self.wireDrawing){
        [self removeGraphics];
    }
    
    self.wireDrawing = [[DLLWireDrawing alloc] initWithFrame:self.targetView.frame fromStart:self.start toEnd:self.end asGhost:YES withColor:self.color];
    //[self.wireDrawing setNeedsDisplay];
    
    [self.targetView addSubview:self.wireDrawing];
}

// called when touches moved
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    self.start = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
    self.wireDrawing.start = self.start;
    [self.wireDrawing setNeedsDisplay];
}

// called when touches moved
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    self.end = CGPointMake(coords.x+WIRE_X_OFFSET, coords.y+WIRE_Y_OFFSET);
    self.wireDrawing.end = self.end;
    [self.wireDrawing setNeedsDisplay];
}

- (void)removeGraphics
{
    [self.wireDrawing removeFromSuperview];
    self.wireDrawing = nil;
}

@end
