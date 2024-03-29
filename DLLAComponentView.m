//
//  DLLAComponentView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponentView.h"

@implementation DLLAComponentView

@synthesize image = _image;
@synthesize imageView = _imageView;
@synthesize wireDrawing = _wireDrawing;
@synthesize targetView = _targetView;
@synthesize color = _color;
@synthesize identifier = _identifier;
@synthesize start = _start;
@synthesize size = _size;
@synthesize end = _end;

#pragma mark -
#pragma mark display methods
- (void)displayComponent;
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)displayGhostWithHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)removeGraphics
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (CGPoint)getOffsetPointFrom:(CGPoint)coords
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return CGPointMake(0, 0);
}

@end
