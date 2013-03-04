//
//  DLLPoint.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLPoint : NSObject

@property (nonatomic)NSUInteger xCoord;
@property (nonatomic)NSUInteger yCoord;

- (BOOL)isEqual:(id)otherPoint;

@end
