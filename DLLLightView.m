//
//  DLLLightView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLLightView.h"

@implementation DLLLightView

@synthesize identifier = _identifier;
@synthesize state = _state;

#pragma mark -
#pragma mark initialization methods
- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
        self.image = [UIImage imageNamed:@"test-light-off"];
        self.state = off;
    }
    return self;
}

#pragma mark -
#pragma mark light control methods
- (void)toggleOn
{
    self.state = on;
    self.image = [UIImage imageNamed:@"test-light-on"];
}

- (void)toggleOff
{
    self.state = off;
    self.image = [UIImage imageNamed:@"test-light-off"];
}

- (void)toggleDim
{
    self.state = dim;
    self.image = [UIImage imageNamed:@"test-light-dim"];
}


@end
