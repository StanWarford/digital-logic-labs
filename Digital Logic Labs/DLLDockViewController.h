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

@class DLLDockViewController;

@protocol DLLDockViewControllerDelegate <NSObject>

- (void)selectionDidChange:(NSInteger)selection;

@end

@interface DLLDockViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, DLLDockViewLayoutDelegate>

@property (nonatomic, strong) id <DLLDockViewControllerDelegate> delegate;
@property (nonatomic, weak) DLLBoard *boardModel;

@end
