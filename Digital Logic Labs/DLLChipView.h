//
//  DLLChipView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponentView.h"

@interface DLLChipView : DLLAComponentView

- (id)initChipOfSize:(NSInteger)size AtLocation:(CGPoint)coords;

- (void)displayComponentInView:(UIView*)view;
- (void)displayGhostInView:(UIView*)view withHoleAvailable:(BOOL)available;
- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeImageView;

@end
