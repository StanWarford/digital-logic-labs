//
//  DLLModel.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DLLModel : NSObject

- (id)init;

- (void)addChipWithPartNum:(NSInteger)partNum;

- (void)addWireFromPoint:(CGPoint)startingPoint toPoint:(CGPoint) endingPoint withColor:(UIColor *)color;

- (BOOL)isChip:(NSInteger)partNum ValidAtUpperLeftCornerCoordinate:(CGPoint)coords;

- (BOOL)isConnectionAvailableAt:(CGPoint)point;

- (void)removeComponentAtCoordinate:(CGPoint)coords;

- (void)clearBoard;

@end
