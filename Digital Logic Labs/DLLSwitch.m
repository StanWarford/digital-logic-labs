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

#pragma mark -
#pragma mark initialization methods
- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
        
        const CGFloat k90DegreeCounterClockwiseAngle = (CGFloat) -(90*M_PI/180.0);
        self.transform = CGAffineTransformRotate(CGAffineTransformIdentity, k90DegreeCounterClockwiseAngle);
    }
    return self;
}

@end
