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

@end

@implementation DLLModel

- (id)init
{
    NSArray * breadboardState = [NSArray arrayWithObjects:[NSArray arrayWithObjects:0,0,0, nil],[NSArray arrayWithObjects:0, 0, 0, nil],nil];
    //model constructor code here
    
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
    //return objectAtIndex:(NSUInteger)point;
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
