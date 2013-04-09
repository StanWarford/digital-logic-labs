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

- (id)initWithIntX:(int)x andY:(int)y
{
    if((self = [super init])){
        self.xCoord = (NSUInteger)x;
        self.yCoord = (NSUInteger)y;
    }
    return self;
}

- (id)init
{
    if(self = [super init]){
        self.xCoord = 0;
        self.yCoord = 0;
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

- (NSString *)toString
{
    NSNumber * number = [NSNumber numberWithInt: self.xCoord * 100 + self.yCoord];
    NSString * stringVal = @"";
    
    if(number <= [NSNumber numberWithInt:999])
        [stringVal stringByAppendingString: @"0"];
    
    [stringVal stringByAppendingString: [number stringValue]];
    
    return stringVal;
}

@end
