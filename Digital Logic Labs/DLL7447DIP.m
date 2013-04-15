//
//  DLL7400DIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL7447DIP.h"

@implementation DLL7447DIP

// Quad Two-Input NAND Gate need setPin: toValue:


// Note: chips must be defined so that the outputPins array and the coordinatesOfOutputPins array return the output pins in the same order for each output pin location.  Define to always return from lower index to higher index

- (id)initWithLocation: (DLLPoint *)loc
{
    if(self = [super init])
    {
        self.loc = loc;
        self.identifier = 7447;
        self.outputPins = @[@8, @9, @10, @11, @12, @13, @14];
        self.inputPins = @[@0, @1, @2, @3, @4, @5, @6];
        self.groundPin = 7;
        self.powerPin = 15;
        self.size = 16;
        self.pins = [[NSMutableArray alloc] initWithObjects:[[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
                     [[DLLElectricalPoint alloc] init], [[DLLElectricalPoint alloc] init],
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
    DLLElectricalPoint * pin0 = [self.pins objectAtIndex:0];
    DLLElectricalPoint * pin1 = [self.pins objectAtIndex:1];
    DLLElectricalPoint * pin2 = [self.pins objectAtIndex:2];
    DLLElectricalPoint * pin3 = [self.pins objectAtIndex:3];
    DLLElectricalPoint * pin4 = [self.pins objectAtIndex:4];
    DLLElectricalPoint * pin5 = [self.pins objectAtIndex:5];
    DLLElectricalPoint * pin6 = [self.pins objectAtIndex:6];
    
    if(pin3.electricalPointValue == EPValueZero)
    {
        for(int i = 8; i < 15; i++)
        {
            DLLElectricalPoint *newPoint = [[DLLElectricalPoint alloc] initWithValue:EPValueOne];
            [self.pins replaceObjectAtIndex:i withObject: newPoint];
        }
    } else if (pin3.electricalPointValue == EPValueOne)
    {
        if(pin2.electricalPointValue == EPValueZero)
        {
            for(int i = 8; i < 15; i++)
            {
                DLLElectricalPoint *newPoint = [[DLLElectricalPoint alloc] initWithValue:EPValueZero];
                [self.pins replaceObjectAtIndex:i withObject: newPoint];
            }
        }
        else if (pin4.electricalPointValue == EPValueOne && pin0.electricalPointValue == EPValueZero &&
                 pin1.electricalPointValue == EPValueZero && pin5.electricalPointValue == EPValueZero &&
                 pin6.electricalPointValue == EPValueZero)
        {
            for(int i = 8; i < 15; i++)
            {
                DLLElectricalPoint *newPoint = [[DLLElectricalPoint alloc] initWithValue:EPValueZero];
                [self.pins replaceObjectAtIndex:i withObject: newPoint];
            }
            DLLElectricalPoint *newPoint = [[DLLElectricalPoint alloc] initWithValue:EPValueOne];
            [self.pins replaceObjectAtIndex:13 withObject: newPoint];
        }
        else if (pin5.electricalPointValue == EPValueZero)
        {//A3-ZERO
            if(pin1.electricalPointValue == EPValueZero)
            {//A2-ZERO
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueOne) 
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)  
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)  
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)  
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
            }
            else if (pin1.electricalPointValue == EPValueOne)
            {//A2-ONE
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                    }
                }
            }
            if(pin1.electricalPointValue == EPValueZero)
            {//A2-ZERO
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
            }
            else if (pin1.electricalPointValue == EPValueOne)
            {//A2-ONE
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                    }
                }
            }

        } else if (pin5.electricalPointValue == EPValueOne)
        {//A3-ONE
            if(pin1.electricalPointValue == EPValueZero)
            {//A2-ZERO
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
            }
            else if (pin1.electricalPointValue == EPValueOne)
            {//A2-ONE
                if(pin0.electricalPointValue == EPValueZero)
                {//A1-ZERO
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                }
                else if (pin0.electricalPointValue == EPValueOne)
                {//A1-ONE
                    if(pin6.electricalPointValue == EPValueZero)
                    {//A0-ZERO
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueZero]];
                    }
                    else if(pin6.electricalPointValue == EPValueOne)
                    {//A0-ONE
                        [self.pins replaceObjectAtIndex:12 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:11 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:10 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:9 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:8 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:14 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                        [self.pins replaceObjectAtIndex:13 withObject:[[DLLElectricalPoint alloc] initWithValue:EPValueOne]];
                    }
                }
            }
        }
    }
}

- (DLLPoint *)powerPinCoordinate
{
    return self.loc;
}

- (DLLPoint *)groundPinCoordinate
{
    return [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 7 andY:self.loc.yCoord + 1];
}

- (NSArray *)coordinatesOfInputPins
{
    return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord + 1],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord + 1], nil];
}
- (NSArray *)coordinatesOfOutputPins
{
    return [NSArray arrayWithObjects:[[DLLPoint alloc] initWithIntX:self.loc.xCoord + 1 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 2 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 3 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 4 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 5 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 6 andY:self.loc.yCoord],
            [[DLLPoint alloc] initWithIntX:self.loc.xCoord + 7 andY:self.loc.yCoord], nil];
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
