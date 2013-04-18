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

#define DEFAULT_LAB_NUM 1

@synthesize boardModel = _boardModel;

#pragma mark -
#pragma mark lazy instantiation methods
- (DLLBoard*)boardModel
{
    if (!_boardModel){
        _boardModel = [[DLLBoard alloc] init];
    }
    return _boardModel;
}

#pragma mark -
#pragma mark view initialization methods
// create the table and pdfviews and set the tableView's delegate to pdfView
// then tell the model that the default lab was selected
- (void)viewDidLoad
{
    [super viewDidLoad];
    DLLLabTableViewController *tableView = [self.viewControllers objectAtIndex:0];
    DLLPDFViewController *pdfView = [self.viewControllers objectAtIndex:1];
    tableView.delegate = pdfView;
    [self.boardModel labSelectionChangedTo:DEFAULT_LAB_NUM];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    DLLLabTableViewController *tableView = [self.viewControllers objectAtIndex:0];
    DLLPDFViewController *pdfView = [self.viewControllers objectAtIndex:1];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:pdfView.selection inSection:0];
    [tableView.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark -
#pragma mark segue control methods
// pass a pointer to the board model on to the next view
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"LabToBoardSegue"]){
        DLLContainerViewController *controller = (DLLContainerViewController*)segue.destinationViewController;
        controller.boardModel = self.boardModel;
    }
}

#pragma mark -
#pragma mark MISC
// deallocate all strong properties
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.boardModel = nil;
}

@end
