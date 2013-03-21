//
//  DLLWireDrawing.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLWireDrawing : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL isGhost;
@property (nonatomic, assign) CGPoint start;
@property (nonatomic, assign) CGPoint end;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame fromStart:(CGPoint)start toEnd:(CGPoint)end asGhost:(BOOL)isGhost withColor:(UIColor*)color;

@end
