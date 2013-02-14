//
//  DLLModel.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLBoard.h"

@interface  DLLBoard()
@property int activeLab;
@property (strong, nonatomic) NSMutableArray *breadboardStateArray;
@end

@implementation DLLBoard

// lazy instantiation of breadboardStateArray
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray) _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: 3];
    return _breadboardStateArray;
}

//model constructor code here
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
    
    //add a component to the XML file for the active board
    // need internal safety w/ exceptions
}

- (void)addWireFromPoint:(CGPoint)startingPoint toPoint:(CGPoint)endingPoint withColor:(UIColor *)color
{
    
    //add a component to the XML file for the active board
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

- (NSInteger)removeComponentAtCoordinate:(CGPoint)coords //this will return component type (perhaps ENUM)-Casey
{
    //not necessarily upper left-need to check 2D array (w/ trinary entries?)
    //remove an existing component from XML file
}

- (void)clearBoard
{
    //reset XML to default
}

// 2D needs to be 63x25 w/ 63rd row as a 'trash' row, items put here will not be added-mark as always unavailable
@end
