//
//  DLLElectricalPoint.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLElectricalPoint.h"

@implementation DLLElectricalPoint

#pragma mark -
#pragma mark initialization methods
- (id)initWithType:(EPType)type
{
    if((self = [super init])){
        self.electricalPointType = type;
        self.electricalPointValue = EPValueUnknown;
        self.electricalPointPreviousValue = EPValueUnknown;
    }
    return self;
}

- (id)init
{
    if((self = [super init])){
        self.electricalPointType = EPTypeOther;
        self.electricalPointValue = EPValueUnknown;
        self.electricalPointPreviousValue = EPValueUnknown;
    }
    return self;
}

#pragma mark -
#pragma mark Utility methods
- (BOOL)isEqual:(id)otherPoint
{
    DLLElectricalPoint * comparePoint = (DLLElectricalPoint *) otherPoint;
    return self.setNumber == comparePoint.setNumber;
}


@end
