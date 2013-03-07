//
//  DLLModel.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 2/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DLLAComponent.h"
#import "DLLChip.h"
#import "DLLPoint.h"

@interface DLLBoard : NSObject

- (id)init;

- (void)addChipWithPartNum:(NSInteger)partNum atUpperLeftCornerCoordinate:(DLLPoint *)coords;
- (void)addWireFromPoint:(DLLPoint *)startingPoint toPoint:(DLLPoint *) endingPoint withColor:(UIColor *)color;

- (DLLAComponent *)removeComponentAtCoordinate:(DLLPoint *)coords;
- (void)clearBoard;

- (DLLAComponent *)boardStateAt:(DLLPoint *)coords;
- (BOOL)cellAt: (DLLPoint *)coords IsAvailableForComponentOfSize: (NSUInteger)size;

@property (nonatomic) NSNull * myNull;

@end
