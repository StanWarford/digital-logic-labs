//
//  DLLElectricalPoint.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLElectricalPoint : NSObject

typedef enum
{
    EPTypePower, EPTypeGround, EPTypeSwitch, EPTypeDebouncedSwitch, EPTypeLight, EPTypeInput, EPTypeOutput, EPTypeClockInput, EPTypeOther
} EPType;

typedef enum
{
    EPValueOne, EPValueZero, EPValueUnknown
    
} EPValue;

@property (nonatomic)EPType electricalPointType;
@property (nonatomic)NSUInteger setNumber;
@property (nonatomic)EPValue electricalPointValue;
@property (nonatomic)EPValue electricalPointPreviousValue;

- (id)initWithType:(EPType)type;
- (id)init;

- (BOOL)isEqual:(id)otherPoint;

@end
