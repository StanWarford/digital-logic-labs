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

- (id)initWithLocation: (DLLPoint *)loc
{
    if(self = [super initWithIdentifier: 7400
                               Location: loc
                             OutputPins: @[@2, @5, @7, @10]
                              InputPins: @[@0, @1, @3, @4, @8, @9, @11, @12]
                              GroundPin: 6
                            AndPowerPin: 13])
    {
        self.loc = loc;
    }
    return self;
}

- (void)calculateOutputs
{
   /* if(!([self.pins objectAtIndex: 0] == [NSNumber numberWithInt: PinValueUnknown]
         || [self.pins objectAtIndex: 1] == [NSNumber numberWithInt: PinValueUnknown])){   // why the if statement here?
        
        [self.pins  insertObject:[NSNumber numberWithInt:
                                  !((NSInteger)[self.pins objectAtIndex: 0] &
                                    (NSInteger)[self.pins objectAtIndex: 1])]
                                    atIndex: 2];
    }*/
    DLLElectricalPoint *pin3 = [self.pins objectAtIndex:3];
    DLLElectricalPoint *pin4 = [self.pins objectAtIndex:4];
    
    [self.pins  insertObject:
     [NSNumber numberWithInt: !((NSInteger)[self.pins objectAtIndex: 3] & (NSInteger)[self.pins objectAtIndex: 4])]
                     atIndex: 5];
    
    [self.pins  insertObject:
     [NSNumber numberWithInt: !((NSInteger)[self.pins objectAtIndex: 8] & (NSInteger)[self.pins objectAtIndex: 9])]
                     atIndex: 7];
    
    [self.pins  insertObject:
     [NSNumber numberWithInt: !((NSInteger)[self.pins objectAtIndex: 12] & (NSInteger)[self.pins objectAtIndex: 11])]
                     atIndex: 10];
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
                                    [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord],
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

@end
