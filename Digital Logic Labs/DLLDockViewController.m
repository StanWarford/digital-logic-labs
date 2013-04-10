//
//  DLLDockViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLDockViewController.h"

@interface DLLDockViewController ()
@property (nonatomic, strong) DLLDockViewLayout *dockLayout;
@property (nonatomic, strong) UIPopoverController *popOver;
- (void)selectCenterItem;
@end

@implementation DLLDockViewController

#define NUMBER_OF_SECTIONS 1 // number of section in the collectionview, should be 1
#define PADDING_CELL_COUNT 5 // number of invisible padding cells on either side of the dock
#define VIEW_HEIGHT 70 // height of the entire dock

@synthesize delegate = _delegate; // delegate should be the board view controller
@synthesize boardModel = _boardModel; // pointer to the model
@synthesize dockLayout = _dockLayout; // pointer to the layout
@synthesize inventory = _inventory; // inventory of components to populate the dock with
@synthesize parent = _parent; // pointer back to the container controller
@synthesize popOver = _popOver; // pointer to the popover windows for each dock item

#pragma mark -
#pragma mark property instantiation methods
// allocate a new dock layout
- (DLLDockViewLayout*)dockLayout
{
    if(!_dockLayout){
        _dockLayout = [[DLLDockViewLayout alloc] initWithDelegate:self];
    }
    return _dockLayout;
}

// populate the inventory with components
- (NSArray*)inventory
{
    if(!_inventory){
        NSMutableArray* temp = [NSMutableArray array];
    
        [temp addObject:[[DLLChipView alloc] initChipWithID:7400]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7402]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7404]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7408]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7432]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7447]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7476]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7485]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:7486]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:74151]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:74164]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:74176]]; // 74176-177
        [temp addObject:[[DLLChipView alloc] initChipWithID:74181]];
        [temp addObject:[[DLLChipView alloc] initChipWithID:74711]]; // MAN71A
        [temp addObject:[[DLLWireView alloc] initWire]];
        _inventory = [NSArray arrayWithArray:temp];
    }
    return _inventory;
}

#pragma mark -
#pragma mark view initialization methods
// enable the layout and allow selection
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure layout
    [self.collectionView setCollectionViewLayout:self.dockLayout];
    
    // Enable manual selection
    [self.collectionView setAllowsSelection:YES];
}

// configure size of the view
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, VIEW_HEIGHT);
}

// after view appears, select the center item
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // select first item at start
    [self selectCenterItem];
}

#pragma mark -
#pragma mark UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NUMBER_OF_SECTIONS;
}

// add extra space for padding on left and right in addition to inventory items
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.inventory count] + 2*PADDING_CELL_COUNT;
}

// Assign appropriate images to cells as defined by the inventory and number of padding cells
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve reusable cell
    DLLDockViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"protoCell" forIndexPath:indexPath];
    
    // cache row number for future use
    NSInteger row = [indexPath row];
    
    // set background
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    UIImage *sourceBG;
    if(row >= PADDING_CELL_COUNT && row < [self.inventory count] + PADDING_CELL_COUNT){
        sourceBG = [[self.inventory objectAtIndex:row - PADDING_CELL_COUNT] image];
    }else{
        sourceBG = [UIImage imageNamed:@"placeholder"];
    }
    
    CGSize bgSize = [[UIImage imageNamed:@"placeholder"] size];
    
    // resize background
    UIGraphicsBeginImageContext(bgSize);
    [sourceBG drawInRect:CGRectMake(0,0,bgSize.width,bgSize.height)];
    UIImage *resizedBG = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:resizedBG];
    cell.backgroundView = backgroundView;
    
    // set autoresizing
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return cell;
}


#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout methods
// size items in the dock
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    return image.size;
}


#pragma mark -
#pragma mark UICollectionViewDelegate methods
// configure and show the corresponding popout for each dock component
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    // make sure the selection is within the bounds of the array (do not include padding cells)
    if(row >= PADDING_CELL_COUNT && row < [self.inventory count] + PADDING_CELL_COUNT){
        DLLAComponentView *selection = [self.inventory objectAtIndex:[indexPath row] - PADDING_CELL_COUNT];
        CGRect presentFrame = CGRectMake(505, 8, 54, 108); // frame where the popover will present itself from (NOT the popover's frame)
        
        if([selection isKindOfClass:[DLLWireView class]]){ // the wire is selected
            DLLWireDetailPopover *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"WireDetailController"];
            detail.wire = (DLLWireView*)selection;
            self.popOver = [[UIPopoverController alloc] initWithContentViewController:detail];
            [self.popOver setPopoverContentSize:CGSizeMake(800, 600)];
            [self.popOver presentPopoverFromRect:presentFrame inView:self.view permittedArrowDirections:0 animated:YES];
        }else{ // a chip is selected
            DLLChipDetailPopover *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ChipDetailController"];
            detail.identifier = selection.identifier;
            self.popOver = [[UIPopoverController alloc] initWithContentViewController:detail];
            [self.popOver setPopoverContentSize:CGSizeMake(800, 600)];
            [self.popOver presentPopoverFromRect:presentFrame inView:self.view permittedArrowDirections:0 animated:YES];
        }
    } // otherwise do nothing
}

#pragma mark -
#pragma mark DLLDockViewLayoutDelegate methods
// called when the flow layout changes the selection.  Update our delegate on the selection change.
- (void)selectionDidChange:(NSInteger)selection
{
    if(selection >= PADDING_CELL_COUNT && selection < [self.inventory count] + PADDING_CELL_COUNT){
        [self.delegate selectionDidChange:[self.inventory objectAtIndex:selection - PADDING_CELL_COUNT]];
    }
}

#pragma mark -
#pragma mark utility methods
// called at appearance time when the center item needs to be selected.  Calculates center item and updates delegate on selection
- (void)selectCenterItem
{
    NSArray *visiblePaths = [NSArray array];
    visiblePaths = [self.collectionView indexPathsForVisibleItems];
    // check required at start since visiblePaths when this is first called is empty
    if([visiblePaths count] > 0){
        // calculate the row number that would be the middle--required because visiblePaths not always in order
        NSMutableArray *temp = [NSMutableArray array];
        for(NSIndexPath *path in visiblePaths){
            [temp addObject:[NSNumber numberWithInteger:path.row]];
        }
        NSInteger middleOffset = [visiblePaths count]/2;
        NSNumber *targetRow = [NSNumber numberWithInteger:[[temp valueForKeyPath:@"@max.intValue"] intValue] - middleOffset];
        // get the index of the middle element and select it
        NSInteger targetIndex = [temp indexOfObject:targetRow];
        [self.delegate selectionDidChange:[self.inventory objectAtIndex:[visiblePaths[targetIndex] row] - PADDING_CELL_COUNT]];
    }
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.dockLayout = nil;
    self.popOver = nil;
    self.inventory = nil;
}

@end
