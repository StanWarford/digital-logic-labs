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
#import "DLLBoard.h"

@interface DLLContainerViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, weak) DLLBoardViewController *boardView;
@property (nonatomic, weak) DLLDockViewController *dockView;
@property (nonatomic, weak) DLLBoard *boardModel;

@end
