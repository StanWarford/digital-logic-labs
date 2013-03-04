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
-(id)initWireAtLocation:(CGPoint)coords withColor:(UIColor *)color
{
    if((self = [super init])){
        self.start = coords;
        self.color = color;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
- (void)displayComponentInView:(UIView*)view atCoordinates:(CGPoint)loc
{
    
}

- (void)displayGhostInView:(UIView*)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available
{
    
}

- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    
}

- (void)removeImageView
{
    
}

@end
