//
//  DLLChip.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"

@interface DLLChip : DLLAComponent

- (id)initWithIdenfifier:(NSInteger)identifier;
- (void)displayComponentInView:(UIView *)view atCoordinates:(CGPoint)loc;
- (void)displayGhostInView:(UIView *)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available;

@end
