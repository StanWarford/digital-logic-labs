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
        self.start = CGPointMake(0.0, 0.0);
        self.color = [UIColor redColor];
        self.image = [UIImage imageNamed:@"wire"];
    }
    return self;
}

-(id)initWireWithStartAt:(CGPoint)coords withColor:(UIColor *)color
{
    if((self = [super init])){
        self.start = coords;
        self.color = color;
        self.image = [UIImage imageNamed:@"wire"];
    }
    return self;
}

#pragma mark -
#pragma mark display methods
// called when touches ended
- (void)displayComponentInView:(UIView*)view atCoordinates:(CGPoint)loc
{
    
}

// called when touches began
- (void)displayGhostInView:(UIView*)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available
{
    
}

// called when touches moved
- (void)translateImageViewTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    
}

// called when touches began
- (void)removeImageView
{
    
}

@end
