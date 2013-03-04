//
//  DLLAComponent.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"

@implementation DLLAComponent

// Casey - random change
// Casey - random change 2

@synthesize identifier = _identifier;
@synthesize type = _type;

-(id)initWithIdentifier:(NSInteger)identifier andType:(NSInteger)type
{
    [NSException raise:NSInternalInconsistencyException format:@"You must override %@ in a subclass.", NSStringFromSelector(_cmd)];
    return nil;
}

@end
