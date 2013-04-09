//
//  DLLWire.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWire.h"

@implementation DLLWire

- (id)initWithStartPoint: (DLLPoint *)startPoint
                EndPoint: (DLLPoint *)endPoint
                AndColor: (UIColor *)color
{
    self.identifier = 9999; //unique number to differentiate a wire
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    self.color = color;
    
    return self;
}

- (DLLPoint *)otherBoardHole: (DLLPoint *)firstPoint
{
    if(firstPoint == self.startPoint)
        return self.endPoint;
    else
        return self.startPoint;
}

@end