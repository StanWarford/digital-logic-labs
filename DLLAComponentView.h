//
//  DLLAComponentView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLAComponentView : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) CGPoint start;

- (void)displayComponentInView:(UIView*)view;
- (void)displayGhostInView:(UIView*)view withHoleAvailable:(BOOL)available;
- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeImageView;

@end
