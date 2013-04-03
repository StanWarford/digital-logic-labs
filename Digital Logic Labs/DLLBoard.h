//
//  DLLModel.h
//  Digital Logic Labs
///Users/joe/Code/Digital Logic Labs/Digital Logic Labs/DLLBoard.m
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLAComponent.h"
#import "DLLChip.h"
#import "DLLPoint.h"
#import "DLLElectricalPoint.h"


@interface DLLBoard : NSObject


- (id)init;

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords;
- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *) endingPoint withColor:(UIColor *)color;

- (DLLAComponent *)removeComponentAtCoordinate:(DLLPoint *)coords;
- (void)clearBoard;

- (BOOL)isOccupiedAt:(DLLPoint *)coords;
- (DLLAComponent *)boardStateAt:(DLLPoint *)coords;
- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentOfSize: (NSUInteger)size;

- (void) runSimulation;
- (void) simulateThrowOfSwitchLabeled:(int)switchID;
// function for which lights are lit
// note: of light is "unknown" return off to Controller
// function for 7-segment display value

@end
