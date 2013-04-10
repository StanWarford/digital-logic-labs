//
//  DLLPoint.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLPoint : NSObject

@property (nonatomic, assign) NSUInteger xCoord;
@property (nonatomic, assign) NSUInteger yCoord;

- (id)initWithCoords:(CGPoint)coords;
- (id)initWithIntX:(int)x andY:(int)y;
- (id)init;

- (BOOL)isEqual:(id)otherPoint;
- (CGPoint)CGPointFromCoords;
- (NSString *)toString;


@end
