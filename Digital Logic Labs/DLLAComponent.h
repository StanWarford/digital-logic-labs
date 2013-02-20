//
//  DLLAComponent.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

/*
 This is an abstract class and should never be instantiated directly.

 Subclasses must implement all metods defined in this class without calls to super.

 All properties have been synthesized in this class, and therefore do not need to be resynthesized in subclasses.
*/

#import <Foundation/Foundation.h>

@interface DLLAComponent : NSObject

@property (assign, nonatomic) NSInteger identifier;
@property (assign, nonatomic) NSInteger type;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *imageView;

- (id)initWithIdenfifier:(NSInteger)identifier andType:(NSInteger)type;

- (void)displayComponentInView:(UIView*)view atCoordinates:(CGPoint)loc;
- (void)displayGhostInView:(UIView*)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available;
- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)removeImageView;

// more methods and properties to be defined later

@end