//
//  DLLChip.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"

@interface DLLChip : DLLAComponent

@property BOOL isFunctional;

- (id)init;
- (id)initWithIdenfifier:(NSInteger)identifier;

typedef enum
{
    PinValueOne, PinValueZero, PinValueUnknown
    
} PinValue;

@end
