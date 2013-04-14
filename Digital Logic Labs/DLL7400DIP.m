//
//  DLL7400DIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL7400DIP.h"

@implementation DLL7400DIP

// Quad Two-Input NAND Gate need setPin: toValue:


// Note: chips must be defined so that the outputPins array and the coordinatesOfOutputPins array return the output pins in the same order for each output pin location.  Define to always return from lower index to higher index

- (id)initWithLocation: (DLLPoint *)loc
{
    if(self = [super init])
    {
        self.loc = loc;
        self.identifier = 7400;
        self.outputPins = @[@2, @5, @7, @10];
        self.inputPins = @[@0, @1, @3, @4, @8, @9, @11, @12];
        self.groundPin = 6;
        self.powerPin = 13;
        self.size = 14;
        self.pins = [[NSMutableArray alloc] initWithObjects:[[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                                                            [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init], nil];
        
    }
    return self;
}

- (void)calculateOutputs
{
    [self.pins replaceObjectAtIndex:2 withObject: [[self.pins objectAtIndex:0] NAND:[self.pins objectAtIndex:1]]];
    [self.pins replaceObjectAtIndex:5 withObject: [[self.pins objectAtIndex:3] NAND:[self.pins objectAtIndex:4]]];
    [self.pins replaceObjectAtIndex:7 withObject: [[self.pins objectAtIndex:8] NAND:[self.pins objectAtIndex:9]]];
    [self.pins replaceObjectAtIndex:10 withObject: [[self.pins objectAtIndex:11] NAND:[self.pins objectAtIndex:12]]];
}

- (DLLPoint *)powerPinCoordinate
{
    return self.loc;
}

- (DLLPoint *)groundPinCoordinate
{
    return [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord + 1];
}

- (NSArray *)coordinatesOfInputPins
{
    return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord], nil];
}
- (NSArray *)coordinatesOfOutputPins
{
    return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord + 1],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord],
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord], nil];
}

- (void)setPin:(int)index to:(DLLElectricalPoint *)electricalPoint
{
    if ((index < [self.pins count]) && (index >= 0))
    {
        [self.pins replaceObjectAtIndex:index withObject:electricalPoint];
    }
    else
    {
    //TODO: some sort of error message here
    }
}

@end


/* DLL7402DIP
 - (id)initWithLocation: (DLLPoint *)loc
 {
 if(self = [super init])
 {
 self.loc = loc;
 self.identifier = 7402;
 self.outputPins = @[@0, @3, @9, @12];
 self.inputPins = @[@1, @2, @4, @5, @7, @8, @10, @11];
 self.groundPin = 6;
 self.powerPin = 13;
 self.size = 14;
 self.pins = [[NSMutableArray alloc] initWithObjects:[[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
 [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init], nil];
 
 }
 return self;
 }
 
 - (void)calculateOutputs
 {
 [self.pins replaceObjectAtIndex:0 withObject: [[self.pins objectAtIndex:1] NOR:[self.pins objectAtIndex:2]]];
 [self.pins replaceObjectAtIndex:3 withObject: [[self.pins objectAtIndex:4] NOR:[self.pins objectAtIndex:5]]];
 [self.pins replaceObjectAtIndex:9 withObject: [[self.pins objectAtIndex:7] NOR:[self.pins objectAtIndex:8]]];
 [self.pins replaceObjectAtIndex:12 withObject: [[self.pins objectAtIndex:10] NOR:[self.pins objectAtIndex:11]]];
 }
 
 - (DLLPoint *)powerPinCoordinate
 {
 return self.loc;
 }
 
 - (DLLPoint *)groundPinCoordinate
 {
 return [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord + 1];
 }
 
 - (NSArray *)coordinatesOfInputPins
 {
 return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord], nil];
 }
 - (NSArray *)coordinatesOfOutputPins
 {
 return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord + 1],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord],
 [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord], nil];
 }
 
 - (void)setPin:(int)index to:(DLLElectricalPoint *)electricalPoint
 {
 if ((index < [self.pins count]) && (index >= 0))
 {
 [self.pins replaceObjectAtIndex:index withObject:electricalPoint];
 }
 else
 {
 //TODO: some sort of error message here
 }
 }
 */
