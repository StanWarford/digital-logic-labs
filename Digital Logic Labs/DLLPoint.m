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
    if([otherPoint class] == [self class])
    {
        //return self.xCoord == otherPoint.xCoord && self.yCoord == otherPoint.yCoord;
        return YES;
    } else return NO;
}

@end
