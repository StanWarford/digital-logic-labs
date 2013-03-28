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
              OutputPins:(NSMutableArray *)outputPins
               InputPins:(NSMutableArray *)inputPins
               GroundPin:(NSUInteger)groundPin
             AndPowerPin:(NSUInteger)powerPin
{
    if(self = [super initWithIdenfifier: identifier])
    {
        self.outputPins = outputPins;
        self.inputPins = inputPins;
        self.groundPin = groundPin;
        self.powerPin = powerPin;
        
        [self.pins initWithCapacity: 14];
    }
    
    return self;
}

@end


