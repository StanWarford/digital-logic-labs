//
//  DLLTest.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLBoard.h"
#import "DLLPoint.h"


@interface DLLTest : NSObject

- (id) init;
- (void) runSimulation;
- (void) simulateThrowOfSwitchLabeled:(int)switchID;
// function for which lights are lit
// note: of light is "unknown" return off to Controller
// function for 7-segment display value


@end
