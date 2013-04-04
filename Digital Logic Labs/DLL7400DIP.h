//
//  DLL7400DIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL14PinDIP.h"
#import "DLLPoint.h"

@interface DLL7400DIP : DLL14PinDIP

- (id)initWithLocation: (DLLPoint *) loc;
- (void)calculateOutputs;
- (DLLPoint *)powerPinCoordinate;
- (DLLPoint *)groundPinCoordinate;
// do these need to be re-stated here?

@end
