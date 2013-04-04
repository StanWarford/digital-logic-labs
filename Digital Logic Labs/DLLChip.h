//
//  DLLChip.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"
#import "DLLPoint.h"

@interface DLLChip : DLLAComponent

@property BOOL isFunctional;
@property (nonatomic, assign) NSUInteger groundPin;
@property (nonatomic, assign) NSUInteger powerPin;

- (id)init;
- (id)initWithIdenfifier:(NSInteger)identifier;
- (DLLPoint *)powerPinCoordinate;
- (DLLPoint *)groundPinCoordinate;

typedef enum
{
    PinValueOne, PinValueZero, PinValueUnknown
    
} PinValue;

@end
