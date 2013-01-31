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

// pointers to the two subviews that will be added to this container
@property (nonatomic, weak) DLLBoardViewController *boardView;
@property (nonatomic, weak) DLLDockViewController *dockView;

@end
