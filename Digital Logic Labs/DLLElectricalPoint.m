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

- (id)initWithValue:(EPValue)value
{
    if((self = [super init])){
        self.electricalPointType = EPTypeOther;
        self.electricalPointValue = value;
        self.electricalPointPreviousValue = EPValueUnknown;
    }
    return self;
}

- (id)init
{
    if(self = [super init]){
        self.electricalPointType = EPTypeOther;
        self.electricalPointValue = EPValueUnknown;
        self.electricalPointPreviousValue = EPValueUnknown;
    }
    return self;
}

#pragma mark -
#pragma mark Utility methods
- (void)changePointTypeTo:(EPType)type
{
    self.electricalPointType = type;
}

- (BOOL)isEqual:(id)otherPoint
{
    DLLElectricalPoint * comparePoint = (DLLElectricalPoint *) otherPoint;
    return self.electricalPointType == comparePoint.electricalPointType;
}

- (DLLElectricalPoint *)NAND:(DLLElectricalPoint *)otherPoint
{
    DLLElectricalPoint *tempPoint = [[DLLElectricalPoint alloc] init];
    
    if ((self.electricalPointValue == EPValueZero) || (otherPoint.electricalPointValue == EPValueZero))
    {
        tempPoint.electricalPointValue = EPValueOne;
    }
    else if ((self.electricalPointValue == EPValueUnknown) || (otherPoint.electricalPointValue == EPValueUnknown))
    {
        tempPoint.electricalPointValue = EPValueUnknown;
    }
    else
    {
        tempPoint.electricalPointValue = EPValueZero;
    }
    return  tempPoint;
}

- (DLLElectricalPoint *)NOR:(DLLElectricalPoint *)otherPoint
{
    DLLElectricalPoint *tempPoint = [[DLLElectricalPoint alloc] init];
    
    if ((self.electricalPointValue == EPValueOne) || (otherPoint.electricalPointValue == EPValueOne))
    {
        tempPoint.electricalPointValue = EPValueZero;
    }
    else if(self.electricalPointValue == EPValueUnknown || otherPoint.electricalPointValue == EPValueUnknown)
    {
        tempPoint.electricalPointValue = EPValueUnknown;
    }
    else
    {
        tempPoint.electricalPointValue = EPValueOne;
    }
    
    return tempPoint;
}

- (DLLElectricalPoint *)NOT
{
    DLLElectricalPoint *tempPoint = [[DLLElectricalPoint alloc] init];
    
    if(self.electricalPointValue == EPValueUnknown)
    {
        tempPoint.electricalPointValue = EPValueUnknown;
    }
    else if (self.electricalPointValue == EPValueOne)
    {
        tempPoint.electricalPointValue = EPValueZero;
    }
    else
    {
        tempPoint.electricalPointValue = EPValueOne;
    }
    
    return tempPoint;

}

- (DLLElectricalPoint *)AND:(DLLElectricalPoint *)otherPoint
{
    DLLElectricalPoint *tempPoint = [[DLLElectricalPoint alloc] init];
    
    if (self.electricalPointValue == EPValueZero || otherPoint.electricalPointValue == EPValueZero)
    {
        tempPoint.electricalPointValue = EPValueZero;
    }
    else if(self.electricalPointValue == EPValueUnknown && otherPoint.electricalPointValue == EPValueUnknown)
    {
        tempPoint.electricalPointValue = EPValueUnknown;
    }
    else
    {
        tempPoint.electricalPointValue = EPValueOne;
    }
    
    return tempPoint;
    
}

- (DLLElectricalPoint *)OR:(DLLElectricalPoint *)otherPoint
{
    DLLElectricalPoint *tempPoint = [[DLLElectricalPoint alloc] init];
    
    if (self.electricalPointValue == EPValueOne || otherPoint.electricalPointValue == EPValueOne)
    {
        tempPoint.electricalPointValue = EPValueOne;
    }
    else if(self.electricalPointValue == EPValueUnknown && otherPoint.electricalPointValue == EPValueUnknown)
    {
        tempPoint.electricalPointValue = EPValueUnknown;
    }
    else
    {
        tempPoint.electricalPointValue = EPValueZero;
    }
    
    return tempPoint;
    
}


@end
