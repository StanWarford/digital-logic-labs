//
//  DLL7400DIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL74711DIP.h"

@implementation DLL74711DIP




// Note: chips must be defined so that the outputPins array and the coordinatesOfOutputPins array return the output pins in the same order for each output pin location.  Define to always return from lower index to higher index

- (id)initWithLocation: (DLLPoint *)loc
{
    if(self = [super init])
    {
        self.loc = loc;
        self.identifier = 74711;
        self.outputPins = @[];
        self.inputPins = @[@0, @1, @2, @6, @7, @8, @9, @10, @12, @13];
        self.size = 14;
        self.pins = [[NSMutableArray alloc] initWithObjects:[[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init], nil];
        
    }
    self.isFunctional = YES;
    return self;
}


- (NSArray *)coordinatesOfInputPins
{
    return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord andY:self.loc.yCoord], nil];
}
- (NSArray *)coordinatesOfOutputPins
{
    return [NSArray array];
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
