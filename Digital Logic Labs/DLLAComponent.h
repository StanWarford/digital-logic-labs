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

-(id)initWithIdentifier:(NSInteger)identifier;

// more methods and properties to be defined later

@end
