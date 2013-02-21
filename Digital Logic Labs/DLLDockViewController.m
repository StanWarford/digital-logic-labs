//
//  DLLDockViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLDockViewController.h"

@interface DLLDockViewController ()
@property (nonatomic, strong) NSArray *inventory;
@property (nonatomic, strong) DLLDockViewLayout *dockLayout;
- (void)selectCenterItem;
@end

@implementation DLLDockViewController

#define NUMBER_OF_SECTIONS 1
#define PADDING_CELL_COUNT 5 // number of invisible padding cells on either side of the dock

@synthesize delegate = _delegate;
@synthesize boardModel = _boardModel;
@synthesize dockLayout = _dockLayout;

#pragma mark -
#pragma mark property instantiation
- (DLLDockViewLayout*)dockLayout
{
    if(!_dockLayout){
        _dockLayout = [[DLLDockViewLayout alloc] initWithDelegate:self];
    }
    return _dockLayout;
}

#pragma mark -
#pragma mark view initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Configure layout
    [self.collectionView setCollectionViewLayout:self.dockLayout];
    
    // Disable manual selection
    [self.collectionView setAllowsSelection:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set the height of the frame to 70
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, 70);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self selectCenterItem];
}


#pragma mark -
#pragma mark UICollectionViewDataSource methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return [self.boardModel.inventory count] + PADDING_CELL_COUNT*2;
    //TODO: rewrite using new inventory model
    return nil;
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
    //if(row >= PADDING_CELL_COUNT && row < [self.boardModel.inventory count] + PADDING_CELL_COUNT){
    //    sourceBG = [[self.boardModel.inventory objectAtIndex:row - PADDING_CELL_COUNT] image];
    //}else{
    //    sourceBG = [UIImage imageNamed:@"placeholder"];
    //}
    
    //TODO: rewrite using new inventory model
    
    CGSize bgSize = cell.frame.size;
    
    UIGraphicsBeginImageContext(bgSize);
    [sourceBG drawInRect:CGRectMake(0,0,bgSize.width,bgSize.height)];
    UIImage *resizedBG = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:resizedBG];
    cell.backgroundView = backgroundView;
    //cell.backgroundColor = UIColor.whiteColor;
    
    // set autoresizing
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    return cell;
}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout methods
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [UIImage imageNamed:@"200px-AND_ANSI"];
    return image.size;
}

#pragma mark -
#pragma mark UICollectionViewDelegate methods
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectCenterItem];
}

#pragma mark -
#pragma mark DLLDockViewLayoutDelegate methods
- (void)selectionDidChange:(NSInteger)selection
{
    //if(selection >= PADDING_CELL_COUNT && selection < [self.boardModel.inventory count] + PADDING_CELL_COUNT){
    //    [self.delegate selectionDidChange:selection - PADDING_CELL_COUNT];
    //}
    
    //TODO: rewrite this using new inventory model
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// calculates the location of the center visible item in the dock and notifies the delegate what it is
- (void)selectCenterItem
{
    NSArray *visiblePaths = [NSArray array]; // returns a list of indexPaths for visible objects
    visiblePaths = [self.collectionView indexPathsForVisibleItems];
    // calculate the row number that would be the middle--required because visiblePaths not always in order
    NSMutableArray *temp = [NSMutableArray array];
    for(NSIndexPath *path in visiblePaths){
        [temp addObject:[NSNumber numberWithInteger:path.row]];
    }
    NSInteger middleOffset = [visiblePaths count]/2;
    NSNumber *targetRow = [NSNumber numberWithInteger:[[temp valueForKeyPath:@"@max.intValue"] intValue] - middleOffset];
    // get the index of the middle element and notify delegate only if the middle cell is in the correct range
    NSInteger targetIndex = [temp indexOfObject:targetRow];
    //if(targetIndex >= PADDING_CELL_COUNT && targetIndex < [self.boardModel.inventory count] + PADDING_CELL_COUNT){
    //    [self.delegate selectionDidChange:[self.boardModel.inventory objectAtIndex:[visiblePaths[targetIndex] row] - PADDING_CELL_COUNT]];
    
    //TODO: rewrite this using new inventory model
    //}
}

@end
