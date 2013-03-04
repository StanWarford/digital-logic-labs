//
//  DLLSplitViewController.m
//  Digital Logic Labs
//
//  Created by Trevor Hilseth on 2/20/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLSplitViewController.h"

@interface DLLSplitViewController ()

@end

@implementation DLLSplitViewController

@synthesize boardModel = _boardModel;

#pragma mark -
#pragma mark property instantiation
- (DLLBoard*)boardModel
{
    if (!_boardModel){
        _boardModel = [[DLLBoard alloc] init];
    }
    return _boardModel;
}

#pragma mark -
#pragma mark view initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    DLLLabTableViewController *tableView = [self.viewControllers objectAtIndex:0];
    DLLPDFViewController *pdfView = [self.viewControllers objectAtIndex:1];
    tableView.delegate = pdfView;
}

#pragma mark -
#pragma mark segue control methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LabToBoardSegue"]){
        DLLContainerViewController *controller = (DLLContainerViewController*)segue.destinationViewController;
        controller.boardModel = self.boardModel;
    }
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
