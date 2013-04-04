//
//  DLL14PinDIP.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL14PinDIP.h"

@implementation DLL14PinDIP

- (id)initWithIdentifier:(NSInteger)identifier
                Location:(DLLPoint *) loc
                    Size:(NSUInteger) size
              OutputPins:(NSArray *)outputPins
               InputPins:(NSArray *)inputPins
               GroundPin:(NSUInteger)groundPin
             AndPowerPin:(NSUInteger)powerPin
{
    if(self = [super initWithIdenfifier: identifier])
    {
        self.loc = loc;
        self.size = 14;
        self.outputPins = outputPins;
        self.inputPins = inputPins;
        self.groundPin = groundPin;
        self.powerPin = powerPin;
        
        [self.pins initWithCapacity: 14];
    }
    
    for(int i = 0; i < [self.pins count]; i++)
    {
        [self.pins insertObject: [NSNumber numberWithInt: PinValueUnknown] atIndex: i];
    }
    
    return self;
}

@end


