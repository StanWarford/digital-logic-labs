//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@implementation DLLChip

- (id)init
{
    self.isFunctional = YES;
    
    return self;
}

- (id)initWithIdentifier:(NSInteger)identifier
{
    if(self = [super initWithIdentifier: identifier])
    {
        self.identifier = identifier;
        self.isFunctional = YES;
    }
    
    return self;
}

- (void)calculateOutputs
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

- (DLLPoint *)powerPinCoordinate
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return [[DLLPoint alloc] initWithIntX:0 andY:0];
}

- (DLLPoint *)groundPinCoordinate
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return [[DLLPoint alloc] initWithIntX:0 andY:0];
}

- (NSArray *)coordinatesOfInputPins
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return [NSArray array];
}

- (NSArray *)coordinatesOfOutputPins
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return [NSArray array];
}

- (void)setPin:(int)index to:(DLLElectricalPoint *)electricalPoint
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
}

@end
