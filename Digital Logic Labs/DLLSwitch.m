//
//  DLLSwitch.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLSwitch.h"

@implementation DLLSwitch

@synthesize identifier = _identifier;

// RGB values for ON switch color
#define ON_RED 0
#define ON_GRN 0
#define ON_BLU 0

// RGB values for OFF switch color
#define OFF_RED 200
#define OFF_GRN 200
#define OFF_BLU 200

#pragma mark -
#pragma mark initialization methods
- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
        
        [self setOnTintColor:[UIColor colorWithRed:ON_RED/255 green:ON_GRN/255 blue:ON_BLU/255 alpha:1.0]];
        [self setTintColor:[UIColor colorWithRed:OFF_RED/255 green:OFF_GRN/255 blue:OFF_BLU/255 alpha:1.0]];
        
        const CGFloat k90DegreeCounterClockwiseAngle = (CGFloat) -(90*M_PI/180.0);
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, k90DegreeCounterClockwiseAngle);
    }
    return self;
}

@end
