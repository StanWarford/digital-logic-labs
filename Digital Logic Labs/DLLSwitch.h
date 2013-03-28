//
//  DLLSwitch.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLSwitch : UISwitch

@property (nonatomic, assign) NSInteger identifier;
- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier;

@end
