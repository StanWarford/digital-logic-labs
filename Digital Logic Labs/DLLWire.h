//
//  DLLWire.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 3/18/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLAComponent.h"
#import "DLLPoint.h"

@interface DLLWire : DLLAComponent

@property (nonatomic, strong) DLLPoint * startPoint;
@property (nonatomic, strong) DLLPoint * endPoint;
@property (nonatomic, strong) UIColor * color;

- (id)initWithStartPoint: (DLLPoint *)startPoint
                EndPoint: (DLLPoint *)endPoint
                AndColor: (UIColor *)color;
- (DLLPoint *)otherBoardHole: (DLLPoint *)firstPoint;

@end