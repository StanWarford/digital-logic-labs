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
#import "DLL7400DIP.h"
#import "DLL7402DIP.h"
#import "DLL7404DIP.h"
#import "DLL7408DIP.h"
#import "DLL7432DIP.h"
#import "DLL7447DIP.h"
#import "DLL74711DIP.h"



@interface DLLBoard : NSObject

- (id)init;

- (void)labSelectionChangedTo:(NSInteger)labNum; // Casey - Added this function to complete the labs view

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords;
- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *) endingPoint withColor:(UIColor *)color;

- (void)removeComponentAtCoordinate:(DLLPoint *)coords;
- (void)clearBoard;

- (BOOL)isOccupiedAt:(DLLPoint *)coords;
- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentWithIdentifier: (NSUInteger)identifier OfSize: (NSUInteger)size;

- (void) runSimulation;
- (void) simulateThrowOfSwitchLabeled:(int)switchID;
- (NSArray *) newStateOfLights;  // 0= off, 1=on, 2=unknown
- (NSArray *) newStateOfSevenSeg;

// function for which lights are lit
// note: of light is "unknown" return off to Controller
// function for 7-segment display value

@end
