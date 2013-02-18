//
//  DLLAComponent.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"

@implementation DLLAComponent

@synthesize identifier = _identifier;
@synthesize type = _type;
@synthesize image = _image;

#pragma mark -
#pragma mark initialization methods
- (id)initWithIdenfifier:(NSInteger)identifier andType:(NSInteger)type
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return nil;
}

#pragma mark -
#pragma mark display methods
- (void)displayComponentInView:(UIView *)view atCoordinates:(CGPoint)loc
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (void)displayGhostInView:(UIView *)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

@end
