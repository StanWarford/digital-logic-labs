//
//  DLLSevenSegmentView.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DLLSevenSegmentView : UIImageView

- (id)initWithFrame:(CGRect)frame;
- (void)toggleSegment:(NSInteger)number onOff:(BOOL)on;

@end
