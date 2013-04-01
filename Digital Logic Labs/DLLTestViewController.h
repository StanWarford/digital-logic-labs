//
//  DLLTestViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLBoard.h"
#import "DLLSwitch.h"
#import "DLLSevenSegmentView.h"
#import "DLLLightView.h"

@interface DLLTestViewController : UIViewController

@property (nonatomic, weak) DLLBoard *boardModel;
@property (nonatomic, strong) NSArray *lights;
@property (nonatomic, strong) NSArray *switches;
@end
