//
//  DLLModel.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoard.h"

@interface  DLLBoard()
@property (assign, nonatomic) NSInteger activeLab;
@property (strong, nonatomic) NSMutableArray *breadboardStateArray;
@end

@implementation DLLBoard

@synthesize breadboardStateArray = _breadboardStateArray;
@synthesize activeLab = _activeLab;

// lazy instantiation of breadboardStateArray
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray) _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: 3];
    return _breadboardStateArray;
}

//board constructor code here
- (id)init
{
    // Creates 3 x 3 array w/ all values set to boardCellStates.EMPTY
    // define overarching array as rows
    int numRows = 3;
    
    NSMutableArray * boardColumns = [[NSMutableArray alloc] initWithCapacity: numRows];
    
    for(int i = 0; i < numRows; i++)
    {
        [boardColumns insertObject:[NSNumber numberWithInt: EMPTY] atIndex:i];
    }
    
    for(int i = 0; i < [_breadboardStateArray count]; i++)
    {
        [_breadboardStateArray insertObject: boardColumns atIndex: i];
    }
    
    return self;
}

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(CGPoint)coords
{
    
    //add a component to the XML file and to data structure for the active board
    // need internal safety w/ exceptions
}

- (void)addWireFromPoint:(CGPoint)startingPoint toPoint:(CGPoint)endingPoint withColor:(UIColor *)color
{
    
    //add a component to the XML file and to data structure for the active board
    // need internal safety w/ exceptions
}

- (BOOL)isChip:(NSInteger)partNum validAtUpperLeftCornerCoordinate:(CGPoint)coords
{
    //helper method for collision detection
    
    return YES;
}

//helper method for collision detection
- (NSInteger)boardStateAt:(CGPoint)coords
{
    NSUInteger rowCoordinate = coords.y;
    NSUInteger columnCoordinate = coords.x;
    NSArray * row = [_breadboardStateArray objectAtIndex:rowCoordinate];
    return [[row objectAtIndex: columnCoordinate] integerValue];
    //return enumerated value at the given point
}

- (BOOL)cellAt: (CGPoint)coords IsAvailableFor: (NSInteger)componentType
{
    //logic for determining if a component is allowed in a cell
    //componentType should be enumerated CellState
    
    switch(componentType)
    {
        case CHIP:
            break;
        case WIRE:
            break;
        default: return NO;
    }
    
    return YES;
}

- (DLLAComponent*)removeComponentAtCoordinate:(CGPoint)coords //this will return component type (perhaps ENUM)-Casey
{
    //not necessarily upper left-need to check 2D array (w/ trinary entries?)
    //remove an existing component from XML file
    return [[DLLChip alloc] init];
}

- (BOOL)cellIsAvailableFor:(NSInteger)componentType
{
    return YES;
}

- (void)clearBoard
{
    //reset XML to default, clear data structure, and set all cells in board array to EMPTY
}

// 2D needs to be 63x25 w/ 63rd row as a 'trash' row, items put here will not be added-mark as always unavailable

- (NSArray*)getCurrentInventory
{
    NSMutableArray* temp = [NSMutableArray array];
    
    for(int i = 0; i < 5; i++){
        [temp addObject:[[DLLChip alloc] initWithIdenfifier:0]];
    }
    for(int i = 0; i < 5; i++){
        [temp addObject:[[DLLChip alloc] initWithIdenfifier:3]];
    }
    [temp addObject:[[DLLChip alloc] initWithIdenfifier:1]];
    [temp addObject:[[DLLChip alloc] initWithIdenfifier:2]];
    for(int i = 0; i < 5; i++){
        [temp addObject:[[DLLChip alloc] initWithIdenfifier:3]];
    }
    for(int i = 0; i < 5; i++){
       [temp addObject:[[DLLChip alloc] initWithIdenfifier:0]];
    }
    return [NSArray arrayWithArray:temp];
}
@end
