//
//  DLL14PinDIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@interface DLL14PinDIP : DLLChip

@property NSMutableArray * pins;
@property NSMutableArray * outputPins;
@property NSMutableArray * inputPins;
@property NSUInteger groundPin;
@property NSUInteger powerPin;

- (id)initWithIdentifier: (NSInteger)identifier
              OutputPins: (NSMutableArray *)outputPins
               InputPins: (NSMutableArray *)inputPins
               GroundPin: (NSUInteger)groundPin
             AndPowerPin: (NSUInteger)powerPin;

@end
