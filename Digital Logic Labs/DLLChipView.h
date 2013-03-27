//
//  DLLChipView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponentView.h"

@interface DLLChipView : DLLAComponentView

- (id)initChipAtLocation:(CGPoint)coords inView:(UIView*)view withID:(NSInteger)identifier;
- (id)initChipWithID:(NSInteger)identifier;

- (void)displayComponent;
- (void)displayGhostWithHoleAvailable:(BOOL)available;
- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available;
- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available; // only used by wire
- (void)removeGraphics;

@end
