//
//  DLLModel.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLModel.h"

@interface  DLLModel()

@property int labNum;

@end

@implementation DLLModel

- (id)init
{
    //model constructor code here
}

+ (void)updateXMLWithCircuit:(int)circuitName AtCoordinates:(CGPoint)coords
{
    //save updated circuit data into XML file
}

+ (void)updateXMLWithWireStarting: (CGPoint)startPoint Ending: (CGPoint)endPoint WithColor: (NSString *)color
{
    //save updated wire into XML file
}

@end
