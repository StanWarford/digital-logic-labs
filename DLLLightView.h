//
//  DLLLightView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLLightView : UIImageView

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL on;

- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier;
- (void)toggleOnOff;
- (void)toggleDimOff;

@end
