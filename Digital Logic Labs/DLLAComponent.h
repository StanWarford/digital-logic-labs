//
//  DLLAComponent.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

/*
 This is an abstract class and should never be instantiated directly.

 Subclasses must implement all methods defined in this class without calls to super.
 
 init calls to super will raise an exception.
*/


#import <Foundation/Foundation.h>
#import "DLLPoint.h"

@interface DLLAComponent : NSObject

@property (assign, nonatomic) NSUInteger identifier;

-(id)initWithIdentifier:(NSInteger)identifier;

// more methods and properties to be defined later

@end
