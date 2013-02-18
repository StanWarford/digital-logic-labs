//
//  DLLBoardViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLDockViewController.h"
#import "DLLBoard.h"
#import "DLLAComponent.h"

@interface DLLBoardViewController : UIViewController <DLLDockViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *testLabel;
@property (weak, nonatomic) DLLBoard *boardModel;

@end
