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

@property DLLPoint * startPoint;
@property DLLPoint * endPoint;

@end
