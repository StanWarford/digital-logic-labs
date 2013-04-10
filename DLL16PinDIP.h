//
//  DLL14PinDIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"
#import "DLLPoint.h"
#import "DLLElectricalPoint.h"

@interface DLL16PinDIP : DLLChip

- (id)initWithIdentifier: (NSInteger)identifier
                Location: (DLLPoint *) loc
              OutputPins: (NSArray *)outputPins
               InputPins: (NSArray *)inputPins
               GroundPin: (NSUInteger)groundPin
             AndPowerPin: (NSUInteger)powerPin;

@end
