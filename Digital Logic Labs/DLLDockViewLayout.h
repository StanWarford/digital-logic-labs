//
//  DLLDockViewLayout.h
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "DLLAComponent.h"

@class DLLDockViewLayout;

@protocol DLLDockViewLayoutDelegate <NSObject>

- (void)selectionDidChange:(NSInteger)selection;

@end

@interface DLLDockViewLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <DLLDockViewLayoutDelegate> delegate;

- (id)initWithDelegate:(id)delegate;

@end
