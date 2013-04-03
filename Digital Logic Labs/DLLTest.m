//
//  DLLTest.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

//Testing to get project on Brooke's laptop

#import "DLLTest.h"

@interface DLLTest()
@property (nonatomic, strong) NSMutableArray *electricalPointArray;

@end

@implementation DLLTest

- (NSMutableArray *)electricalPointArray
{
    if (!_electricalPointArray){
        _electricalPointArray = [[NSMutableArray alloc] initWithCapacity:274];
    }
    return _electricalPointArray;
}

- (id) init
{/*
    for(int x = 0; x < 252; x++)
    {
        [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] init] atIndex:x];
    }
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeGround] atIndex:252];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypePower] atIndex:253];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:254];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeDebouncedSwitch] atIndex:255];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:256];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeDebouncedSwitch] atIndex:257];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:258];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:259];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:260];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:261];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:262];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:263];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:264];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeSwitch] atIndex:265];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:266];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:267];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:268];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:269];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:270];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:271];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:272];
    [self.electricalPointArray insertObject:[[DLLElectricalPoint alloc] initWithType:EPTypeLight] atIndex:273];
    */
    return self;
}

- (void) runSimulation
{
    [self determineChipFunctionality];
    if (![self illegalConnectionExists])
    {
        [self simulateInitialState];
    }
    
    
}

- (void) determineChipFunctionality
{
    
}

- (BOOL) illegalConnectionExists
{
    return NO;
}

- (void) simulateInitialState
{
    // initialize value each electrical pt
    // initialize previousvalue
    // initialize internal state of FF to unknown
    [self simulateCombinational];
}

- (void) simulateCombinational
{
    
}

- (void) simulateThrowOfSwitchLabeled:(int)switchID
{
    // more code necessary here
    [self simulateCombinational];
}



@end
