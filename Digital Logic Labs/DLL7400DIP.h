//
//  DLL7400DIP.h
//  Digital Logic Labs
//
//  Created by Joe Scharnitzke on 4/3/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLL14PinDIP.h"
#import "DLLPoint.h"
#import "DLLElectricalPoint.h"

@interface DLL7400DIP : DLL14PinDIP

- (id)initWithLocation: (DLLPoint *) loc;
- (void)calculateOutputs;
- (DLLPoint *)powerPinCoordinate;
- (DLLPoint *)groundPinCoordinate;
- (NSArray *)coordinatesOfInputPins;
- (NSArray *)coordinatesOfOutputPins;
// do these need to be re-stated here?

@end
