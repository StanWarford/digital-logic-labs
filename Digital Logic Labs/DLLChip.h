//
//  DLLChip.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"
#import "DLLPoint.h"

@interface DLLChip : DLLAComponent

@property BOOL isFunctional;
@property (nonatomic, strong) NSMutableArray * pins;
@property (nonatomic, strong) NSArray * outputPins;
@property (nonatomic, strong) NSArray * inputPins;
@property (nonatomic, assign) NSUInteger groundPin;
@property (nonatomic, assign) NSUInteger powerPin;
@property (nonatomic, assign) DLLPoint * loc;
@property (nonatomic, assign) NSUInteger size;

- (id)init;
- (id)initWithIdenfifier:(NSInteger)identifier;
- (DLLPoint *)powerPinCoordinate;
- (DLLPoint *)groundPinCoordinate;
- (NSArray *)coordinatesOfInputPins;
- (NSArray *)coordinatesOfOutputPins;

typedef enum
{
    PinValueOne, PinValueZero, PinValueUnknown
    
} PinValue;

@end
