//
//  DLL14PinDIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL24PinDIP.h"

@implementation DLL24PinDIP

- (id)initWithIdentifier:(NSInteger)identifier
                Location:(DLLPoint *) loc
              OutputPins:(NSArray *)outputPins
               InputPins:(NSArray *)inputPins
               GroundPin:(NSUInteger)groundPin
             AndPowerPin:(NSUInteger)powerPin
{
    if(self = [super initWithIdentifier: identifier])
    {
        self.loc = loc;
        self.size = 24;
        self.outputPins = outputPins;
        self.inputPins = inputPins;
        self.groundPin = groundPin;
        self.powerPin = powerPin;
        
        [self.pins initWithCapacity: 24];
    }
    
    for(int i = 0; i < [self.pins count]; i++)
    {
        DLLElectricalPoint *newElectricalPoint = [[DLLElectricalPoint alloc] initWithValue:EPValueUnknown];
        [self.pins insertObject: newElectricalPoint atIndex: i];
    }
    
    return self;
}

@end


