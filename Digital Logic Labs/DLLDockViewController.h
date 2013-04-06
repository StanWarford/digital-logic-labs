//
//  DLLDockViewController.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLLDockViewCell.h"
#import "DLLDockViewLayout.h"

#import "DLLBoard.h"

#import "DLLAComponent.h"
#import "DLLChipView.h"
#import "DLLWireView.h"

#import "DLLChipDetailPopover.h"
#import "DLLWireDetailPopover.h"

@class DLLDockViewController;

@protocol DLLDockViewControllerDelegate <NSObject>

- (void)selectionDidChange:(DLLAComponentView*)selection;

@end

@interface DLLDockViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DLLDockViewLayoutDelegate>

@property (nonatomic, weak) id <DLLDockViewControllerDelegate> delegate;
@property (nonatomic, weak) DLLBoard *boardModel;
@property (nonatomic, weak) UIViewController *parent;
@property (nonatomic, strong) NSArray* inventory;

@end
