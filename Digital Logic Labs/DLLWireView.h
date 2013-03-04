//
//  DLLWireView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponentView.h"

@interface DLLWireView : DLLAComponentView

@property (nonatomic, assign) CGPoint end;
@property (nonatomic, strong) UIColor *color;

-(id)initWireAtLocation:(CGPoint)coords withColor:(UIColor*)color;

- (void)displayComponentInView:(UIView*)view atCoordinates:(CGPoint)loc;
- (void)displayGhostInView:(UIView*)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available;
- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeImageView;

@end
