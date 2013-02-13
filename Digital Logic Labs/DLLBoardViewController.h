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

@interface DLLBoardViewController : UIViewController <DLLDockViewControllerDelegate>

@property (assign, nonatomic) NSInteger selectedChip;
@property (weak, nonatomic) IBOutlet UILabel *testLabel;
@property (strong, nonatomic) DLLBoard *model;

@end
