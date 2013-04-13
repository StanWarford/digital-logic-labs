//
//  DLLWireView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponentView.h"

@interface DLLWireView : DLLAComponentView

- (id)initWire;
- (id)initWireWithStartAt:(CGPoint)coords withColor:(UIColor*)color inView:(UIView*)view;
- (id)initWireWithStartAt:(CGPoint)sCoords andEndAt:(CGPoint)eCoords withColor:(UIColor *)color inView:(UIView *)view;

- (void)displayComponent;
- (void)displayGhostWithHoleAvailable:(BOOL)available;
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeGraphics;
- (CGPoint)getOffsetPointFrom:(CGPoint)coords;

@end
