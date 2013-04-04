//
//  DLL14PinDIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"
#import "DLLPoint.h"

@interface DLL14PinDIP : DLLChip

@property (nonatomic, strong) NSMutableArray * pins;
@property (nonatomic, strong) NSArray * outputPins;
@property (nonatomic, strong) NSArray * inputPins;
@property (nonatomic, assign) NSUInteger groundPin;
@property (nonatomic, assign) NSUInteger powerPin;
@property (nonatomic, assign) DLLPoint * loc;
@property (nonatomic, assign) NSUInteger size;

- (id)initWithIdentifier: (NSInteger)identifier
                Location: (DLLPoint *) loc
              OutputPins: (NSArray *)outputPins
               InputPins: (NSArray *)inputPins
               GroundPin: (NSUInteger)groundPin
             AndPowerPin: (NSUInteger)powerPin;

@end
