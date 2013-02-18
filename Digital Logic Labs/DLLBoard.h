//
//  DLLModel.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLAComponent.h"
#import "DLLChip.h"

@interface DLLBoard : NSObject

typedef enum boardCellStates
{
    EMPTY,
    CHIP,
    WIRE
} CellState;

- (id)init;

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(CGPoint)coords;

- (void)addWireFromPoint:(CGPoint)startingPoint toPoint:(CGPoint) endingPoint withColor:(UIColor *)color;

- (BOOL)isChip:(NSInteger)partNum validAtUpperLeftCornerCoordinate:(CGPoint)coords;

- (NSInteger)boardStateAt:(CGPoint)coords;

- (BOOL)cellIsAvailableFor:(NSInteger)componentType;

- (DLLAComponent*)removeComponentAtCoordinate:(CGPoint)coords;

- (void)clearBoard;

- (NSArray*)getCurrentInventory;

@end
