//
//  DLLLightView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLLightView : UIImageView

typedef enum{
    on,
    off,
    dim
} lightState;

@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) lightState state;

- (id)initWithFrame:(CGRect)frame andID:(NSInteger)identifier;
- (void)toggleOn;
- (void)toggleOff;
- (void)toggleDim;

@end
