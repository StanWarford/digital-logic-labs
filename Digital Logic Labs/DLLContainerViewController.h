//
//  DLLContainerViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLBoardViewController.h"
#import "DLLDockViewController.h"

@interface DLLContainerViewController : UIViewController

@property (nonatomic, weak) DLLBoardViewController *boardView;
@property (nonatomic, weak) DLLDockViewController *dockView;

@end
