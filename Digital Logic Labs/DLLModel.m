//
//  DLLModel.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLModel.h"

@interface  DLLModel()
@property int activeLab;
@property (strong, nonatomic) NSMutableArray *breadboardStateArray;
@end

@implementation DLLModel

// lazy instantiation of breadboardState
- (NSMutableArray *)breadboardStateArray
{
    if (!_breadboardStateArray) _breadboardStateArray = [[NSMutableArray alloc] initWithCapacity: 3];
    return _breadboardStateArray;
}

//model constructor code here
- (id)init
{
    // Creates 3 x 3 array w/ all values set to 0
    // define overarching array as rows
    
    [_breadboardStateArray insertObject:[NSMutableArray arrayWithObjects:0,0,0,nil] atIndex:0];
    [_breadboardStateArray insertObject:[NSMutableArray arrayWithObjects:0,0,0,nil] atIndex:1];
    [_breadboardStateArray insertObject:[NSMutableArray arrayWithObjects:0,0,0,nil] atIndex:2];
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

- (BOOL)isChip:(NSInteger)partNum ValidAtUpperLeftCornerCoordinate:(CGPoint)coords
{
    //helper method for collision detection
    
    return true;
}

//helper method for collision detection
- (BOOL)isConnectionAvailableAt:(CGPoint)point
{
    NSUInteger rowCoordinate = point.x;
    NSArray * row = [_breadboardStateArray objectAtIndex:rowCoordinate];
    return true;
}

- (void)removeComponentAtCoordinate:(CGPoint)coords //this will return component type (perhaps ENUM)-Casey
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
