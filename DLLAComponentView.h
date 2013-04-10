//
//  DLLAComponentView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLWireDrawing.h"

// Abstract class defining the general form of a component view object
@interface DLLAComponentView : NSObject

@property (nonatomic, strong) UIImage *image; // image associated with object if needed
@property (nonatomic, strong) UIImageView *imageView; // only used in chip
@property (nonatomic, strong) DLLWireDrawing *wireDrawing; // only used in wire
@property (nonatomic, weak) UIView *targetView; // pointer to view where object should be displayed
@property (nonatomic, strong) UIColor *color; // only used in wire
@property (nonatomic, assign) NSInteger identifier; // identifier, chips use standard 7400 addresses, and wire has identifier 1
@property (nonatomic, assign) NSInteger size; // size of chip: 14, 16, 24.  Wire has size 1
@property (nonatomic, assign) CGPoint start; // coordinates for the upper left corner where the object should be displayed
@property (nonatomic, assign) CGPoint end; // only used in wire

- (void)displayComponent;
- (void)displayGhostWithHoleAvailable:(BOOL)available;
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available; // only used by wire
- (void)removeGraphics;
- (CGPoint)getOffsetPointFrom:(CGPoint)coords;

@end
