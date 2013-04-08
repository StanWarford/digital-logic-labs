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
    EPValueZero, EPValueOne, EPValueUnknown
    
} EPValue;

@property (nonatomic, assign) EPType electricalPointType;
@property (nonatomic, assign) NSUInteger setNumber;
@property (nonatomic, assign) EPValue electricalPointValue;
@property (nonatomic, assign) EPValue electricalPointPreviousValue;

- (id)initWithType:(EPType)type;
- (id)initWithType:(EPType)type andValue:(EPValue)value;
- (id)init;

- (void)changePointTypeTo:(EPType)type;
- (BOOL)isEqual:(id)otherPoint;
- (DLLElectricalPoint *)NAND:(DLLElectricalPoint *)point withOtherPoint:(DLLElectricalPoint *)otherPoint;

@end

//TODO: make an array of DLLElectricalPoints

