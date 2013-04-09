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
#import "DLLWire.h"
#import "DLLPoint.h"
#import "DLLElectricalPoint.h"
#import "DLL14PinDIP.h"
#import "DLL7400DIP.h"



@interface DLLBoard : NSObject


- (id)init;

- (void)labSelectionChangedTo:(NSInteger)labNum; // Casey - Added this function to complete the labs view

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords;
- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *) endingPoint withColor:(UIColor *)color;

- (void)removeComponentAtCoordinate:(DLLPoint *)coords;
- (void)removeWireAtPoint: (DLLPoint *) startPoint;
- (void)removeWireAtStartPoint: (DLLPoint *)startPoint AndEndPoint: (DLLPoint *)endPoint;
- (void)clearBoard;

- (BOOL)isOccupiedAt:(DLLPoint *)coords;
- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentOfSize: (NSUInteger)size;

- (void) runSimulation;
- (void) simulateThrowOfSwitchLabeled:(int)switchID;
- (NSArray *) newStateOfLights;  // 0= off, 1=on, 2=unknown

// function for which lights are lit
// note: of light is "unknown" return off to Controller
// function for 7-segment display value

@end
