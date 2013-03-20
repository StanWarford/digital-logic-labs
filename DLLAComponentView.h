//
//  DLLAComponentView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLAComponentView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView; // only used in chip
@property (nonatomic, strong) UIView *targetView; // pointer to view where object should be displayed
@property (nonatomic, strong) UIColor *color; // only used in wire
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end; // only used in wire

- (void)displayComponent;
- (void)displayGhostWithHoleAvailable:(BOOL)available;
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available; // only used by wire
- (void)removeImageView;

@end
