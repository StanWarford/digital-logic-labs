//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@implementation DLLChip

- (id)init
{
    self.isFunctional = YES;
    
    return self;
}

- (id)initWithIdentifier:(NSInteger)identifier
{
    self.identifier = identifier;
    self.isFunctional = YES;
    
    return self;
}

@end
