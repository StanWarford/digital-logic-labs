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
@synthesize on = _on;

#pragma mark -
#pragma mark initialization methods
- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier
{
    self = [super initWithFrame:frame];
    if (self) {
        self.identifier = identifier;
        self.image = [UIImage imageNamed:@"test-light-off"];
        self.on = NO;
    }
    return self;
}

#pragma mark -
#pragma mark light control methods
- (void)toggleOnOff
{
    self.on = !self.on;
    if(self.on){
        self.image = [UIImage imageNamed:@"test-light-on"];
    }else{
        self.image = [UIImage imageNamed:@"test-light-off"];
    }
}

@end
