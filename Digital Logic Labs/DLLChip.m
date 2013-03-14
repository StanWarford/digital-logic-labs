//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@interface DLLChip()
@end

@implementation DLLChip

- (id)initWithIdentifier:(NSInteger)identifier
{
    if((self = [super init])){
        self.identifier = identifier;
    }
    return self;
}

@end
