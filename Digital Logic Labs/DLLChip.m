//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@interface DLLChip()

- (UIImage*)makeGhostWithHoleAvailable:(BOOL)available;

@end

@implementation DLLChip

- (id)initWithIdentifier:(NSInteger)identifier andType:(NSInteger)type
{
    if((self = [super init])){
        self.identifier = identifier;
        self.type = type;
    }
    return self;
}

@end
