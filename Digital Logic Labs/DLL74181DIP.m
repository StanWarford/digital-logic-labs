//
//  DLL7400DIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL74181DIP.h"

@implementation DLL74181DIP

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
