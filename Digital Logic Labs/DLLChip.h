//
//  DLLChip.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//


// Note: chips must be defined so that the outputPins array and the coordinatesOfOutputPins array return the output pins in the same order for each output pin location.  Define to always return from lower index to higher index
#import "DLLAComponent.h"
#import "DLLPoint.h"
#import "DLLElectricalPoint.h"

@interface DLLChip : DLLAComponent

@property (strong, nonatomic) DLLPoint * loc;
@property (strong, nonatomic) NSArray * outputPins;
@property (strong, nonatomic) NSArray * inputPins;
@property (assign, nonatomic) NSUInteger powerPin;
@property (assign, nonatomic) NSUInteger groundPin;
@property (assign, nonatomic) BOOL isFunctional;
@property (nonatomic, strong) NSMutableArray * pins;
@property (nonatomic, assign) NSUInteger size;

- (id)init;
- (id)initWithIdentifier:(NSInteger)identifier;
- (void)calculateOutputs;
- (DLLPoint *)powerPinCoordinate;
- (DLLPoint *)groundPinCoordinate;
- (NSArray *)coordinatesOfInputPins;
- (NSArray *)coordinatesOfOutputPins;
- (void)setPin:(int)index to:(DLLElectricalPoint *)electricalPoint;  

@end
