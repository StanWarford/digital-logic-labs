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
             AndEndPoint: (DLLPoint *)endPoint
{
    self.identifier = 9999; //unique number to differentiate a wire
    self.startPoint = startPoint;
    self.endPoint = endPoint;
    
    return self;
}

@end
