//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@implementation DLLChip

- (id)initWithIdenfifier:(NSInteger)identifier
{
    if((self = [super init])){
        self.identifier = identifier;
        if(self.identifier == 0){
            self.image = [UIImage imageNamed:@"placeholder"];
        }else if(self.identifier == 1){
            self.image = [UIImage imageNamed:@"chip-14"];
        }else if(self.identifier == 2){
            self.image = [UIImage imageNamed:@"chip-16"];
        }else{
            self.image = [UIImage imageNamed:@"200px-AND_ANSI"];
        }
    }
    return self;
}

- (void)displayComponentInView:(UIView *)view atCoordinates:(CGPoint)loc
{
    // display chip
}

- (void)displayGhostInView:(UIView *)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available
{
    // display ghost chip
}

@end
