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
- (id)initWireWithStartAt:(CGPoint)coords withColor:(UIColor*)color;

- (void)displayComponentInView:(UIView*)view atCoordinates:(CGPoint)loc;
- (void)displayGhostInView:(UIView*)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available;
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeImageView;

@end
