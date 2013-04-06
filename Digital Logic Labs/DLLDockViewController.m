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
@end

@implementation DLLDockViewController

#define NUMBER_OF_SECTIONS 1
#define PADDING_CELL_COUNT 5 // number of invisible padding cells on either side of the dock
#define VIEW_HEIGHT 70

@synthesize delegate = _delegate;
@synthesize boardModel = _boardModel;
@synthesize dockLayout = _dockLayout;
@synthesize inventory = _inventory;
@synthesize parent = _parent;
@synthesize popOver = _popOver;

#pragma mark -
#pragma mark property instantiation methods
- (DLLDockViewLayout*)dockLayout
{
    if(!_dockLayout){
        _dockLayout = [[DLLDockViewLayout alloc] initWithDelegate:self];
    }
    return _dockLayout;
}

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
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure layout
    [self.collectionView setCollectionViewLayout:self.dockLayout];
    
    // Enable manual selection
    [self.collectionView setAllowsSelection:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set the height of the frame to 70
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, VIEW_HEIGHT);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // select first item at start
    [self.delegate selectionDidChange:[self.inventory objectAtIndex:0]];
}

#pragma mark -
#pragma mark UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.inventory count] + 2*PADDING_CELL_COUNT;
}

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
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"placeholder"];
    return image.size;
}


#pragma mark -
#pragma mark UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    if(row >= PADDING_CELL_COUNT && row < [self.inventory count] + PADDING_CELL_COUNT){
        DLLAComponentView *selection = [self.inventory objectAtIndex:[indexPath row] - PADDING_CELL_COUNT];
        CGRect presentFrame = CGRectMake(505, 8, 54, 108);
        if([selection isKindOfClass:[DLLWireView class]]){
            DLLWireDetailPopover *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"WireDetailController"];
            detail.wire = (DLLWireView*)selection;
            self.popOver = [[UIPopoverController alloc] initWithContentViewController:detail];
            [self.popOver setPopoverContentSize:CGSizeMake(800, 600)];
            [self.popOver presentPopoverFromRect:presentFrame inView:self.view permittedArrowDirections:0 animated:YES];
        }else{
            DLLChipDetailPopover *detail = [self.storyboard instantiateViewControllerWithIdentifier:@"ChipDetailController"];
            detail.identifier = selection.identifier;
            self.popOver = [[UIPopoverController alloc] initWithContentViewController:detail];
            [self.popOver setPopoverContentSize:CGSizeMake(800, 600)];
            [self.popOver presentPopoverFromRect:presentFrame inView:self.view permittedArrowDirections:0 animated:YES];
        }
    }
}

/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
*/

#pragma mark -
#pragma mark DLLDockViewLayoutDelegate methods
- (void)selectionDidChange:(NSInteger)selection
{
    if(selection >= PADDING_CELL_COUNT && selection < [self.inventory count] + PADDING_CELL_COUNT){
        [self.delegate selectionDidChange:[self.inventory objectAtIndex:selection - PADDING_CELL_COUNT]];
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
