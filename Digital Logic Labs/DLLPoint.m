//
//  DLLPoint.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLPoint.h"

@implementation DLLPoint

- (BOOL)isEqual:(id)otherPoint
{
    DLLPoint * comparePoint = (DLLPoint *) otherPoint;
    return self.xCoord == comparePoint.xCoord && self.yCoord == comparePoint.yCoord;
}

@end
