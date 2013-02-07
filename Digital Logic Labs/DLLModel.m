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
    //model constructor code here
    
    return self;
}

/* are these redundant with addComponent below?
+ (void)updateXMLWithCircuit:(int)circuitName AtCoordinates:(CGPoint)coords
{
    //save updated circuit data into XML file
}

+ (void)updateXMLWithWireStarting: (CGPoint)startPoint Ending: (CGPoint)endPoint WithColor: (NSString *)color
{
    //save updated wire into XML file
}
 */

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



- (BOOL)isChip:(NSInteger)partNum ValidatUpperLeftCornerCoordinate:(CGPoint)coords
{
    //helper method for collision detection
    
    return true;
}

- (BOOL)isConnectionAvailableAt:(CGPoint)point
{
    //helper method for collision detection
    
    return true;
}

- (void)removeChipAtCoordinate: (CGPoint)coords //not necessarily upper left-need to check 2D array (w/ trinary entries?)
{
    //remove an existing component from XML file
}

- (void)clearBoard
{
    //reset XML to default
}



@end
