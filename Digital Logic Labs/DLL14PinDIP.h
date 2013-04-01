//
//  DLL14PinDIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@interface DLL14PinDIP : DLLChip

@property (nonatomic, strong) NSMutableArray * pins;
@property (nonatomic, strong) NSMutableArray * outputPins;
@property (nonatomic, strong) NSMutableArray * inputPins;
@property (nonatomic, assign) NSUInteger groundPin;
@property (nonatomic, assign) NSUInteger powerPin;

- (id)initWithIdentifier: (NSInteger)identifier
              OutputPins: (NSMutableArray *)outputPins
               InputPins: (NSMutableArray *)inputPins
               GroundPin: (NSUInteger)groundPin
             AndPowerPin: (NSUInteger)powerPin;

@end
