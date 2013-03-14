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
@synthesize color = _color; // only used in wire
@synthesize start = _start;
@synthesize size = _size;

#pragma mark -
#pragma mark display methods
- (void)displayComponentInView:(UIView *)view;
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)displayGhostInView:(UIView *)view withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)translateImageViewTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)removeImageView
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

@end
