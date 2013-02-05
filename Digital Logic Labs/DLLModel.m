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

+ (void)addComponent//: (DLLComponent)component
{    
    //add a component to the XML file for the active board
}

+ (void)moveComponent//: (DLLComponent)component
{
    //update coordinates of an existing component in XML
}

- (BOOL)collisionsDetected
{
    //helper method for collision detection
    
    return true;
}

+ (void)removeComponent//: (DLLComponent)component
{
    //remove an existing component from XML file
}

+ (void)clearBoard
{
    //reset XML to default
}



@end
