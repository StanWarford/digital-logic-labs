//
//  DLLLabTableViewController.h
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/13/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLLLabTableViewControllerDelegate <NSObject>
- (void) selectionDidChangeTo:(NSInteger)selection;
@end

@interface DLLLabTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id <DLLLabTableViewControllerDelegate> delegate;

@end
