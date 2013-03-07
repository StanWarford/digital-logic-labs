//
//  DLLPoint.m
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLPoint.h"

@implementation DLLPoint

#pragma mark -
#pragma mark initialization methods
- (id)initWithCoords:(CGPoint)coords
{
    if((self = [super init])){
        self.xCoord = (NSUInteger)coords.x;
        self.yCoord = (NSUInteger)coords.y;
    }
    return self;
}

#pragma mark -
#pragma mark Utility methods
- (BOOL)isEqual:(id)otherPoint
{
    DLLPoint * comparePoint = (DLLPoint *) otherPoint;
    return self.xCoord == comparePoint.xCoord && self.yCoord == comparePoint.yCoord;
}

- (CGPoint)CGPointFromCoords
{
    return CGPointMake((CGFloat)self.xCoord, (CGFloat)self.yCoord);
}

@end
