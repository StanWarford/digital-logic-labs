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
@synthesize inventory = _inventory;

#pragma mark -
#pragma mark lazy instantiation methods
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray){
        _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: 3];
    }
    return _breadboardStateArray;
}

- (NSArray*)inventory
{
    if(!_inventory){
        NSMutableArray* temp = [NSMutableArray array];

        for(int i = 0; i < 5; i++){
            [temp addObject:[[DLLChip alloc] initWithIdenfifier:3 andType:CHIP]];
        }
        [temp addObject:[[DLLChip alloc] initWithIdenfifier:7400 andType:CHIP]];
        [temp addObject:[[DLLChip alloc] initWithIdenfifier:7476 andType:CHIP]];
        for(int i = 0; i < 5; i++){
            [temp addObject:[[DLLChip alloc] initWithIdenfifier:3 andType:CHIP]];
        }
        
        _inventory = [NSArray arrayWithArray:temp];
    }
    return _inventory;
}

#pragma mark -
#pragma mark initialization methods
- (id)init
{
    // Creates 3 x 3 array w/ all values set to boardCellStates.EMPTY
    // define overarching array as rows
    if((self = [super init])){
        int numRows = 3;
    
        NSMutableArray * boardColumns = [[NSMutableArray alloc] initWithCapacity: numRows];
        
        for(int i = 0; i < numRows; i++)
        {
            [boardColumns insertObject:[NSNumber numberWithInt: EMPTY] atIndex:i];
        }
        
        for(int i = 0; i < [self.breadboardStateArray count]; i++)
        {
        [self.breadboardStateArray insertObject: boardColumns atIndex: i];
        }
    }
    
    return self;
}

#pragma mark -
#pragma mark component addition methods
- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(CGPoint)coords
{
    
    //add a component to data structure for the active board
    // need internal safety w/ exceptions
}

- (void)addWireFromPoint:(CGPoint)startingPoint toPoint:(CGPoint)endingPoint withColor:(UIColor *)color
{
    
    //add a component to the XML file and to data structure for the active board
    // need internal safety w/ exceptions
}

#pragma mark -
#pragma mark component removal methods
- (DLLAComponent*)removeComponentAtCoordinate:(CGPoint)coords //this will return component type (perhaps ENUM)-Casey
{
    //not necessarily upper left-need to check 2D array (w/ trinary entries?)
    //remove an existing component from XML file
    return [[DLLChip alloc] init];
}

- (void)clearBoard
{
    //reset XML to default, clear data structure, and set all cells in board array to EMPTY
}

#pragma mark -
#pragma mark board state methods

- (NSInteger)boardStateAt:(CGPoint)coords
{
    NSUInteger rowCoordinate = coords.y;
    NSUInteger columnCoordinate = coords.x;
    NSArray * row = [self.breadboardStateArray objectAtIndex:rowCoordinate];
    return [[row objectAtIndex: columnCoordinate] integerValue];
    //return enumerated value at the given point
}

- (BOOL)cellAt: (CGPoint)coords IsAvailableForChip: (NSInteger)partNum  OfType: (NSInteger)componentType
{
    //logic for determining if a component is allowed in a cell
    //componentType should be enumerated CellState
    
    switch(componentType)
    {
        case CHIP: return [self willChip: partNum FitAt: coords];
            break;
        case WIRE: return [self boardStateAt: coords] == EMPTY;
            break;
        default: return NO;
    }
    
    return YES;
}

#pragma mark -
#pragma mark helper methods
- (BOOL)willChip: (NSInteger)partNum FitAt: (CGPoint)coords
{
    int x = coords.x;
    int y = coords.y;
    
    if(partNum == 7400) //assume 14 pin
    {
        for(;coords.x <= x + 2; coords.x++)
        {
            for(;coords.y <= y + 7; coords.y++)
            {
                if([self boardStateAt: coords] != EMPTY) return NO;
            }
        }
        
        
        
        
    } else if(partNum == 7476)  //assume 16 pin
    {
        
    }
    return YES;
}

// 2D needs to be 63x25 w/ 63rd row as a 'trash' row, items put here will not be added-mark as always unavailable
@end
