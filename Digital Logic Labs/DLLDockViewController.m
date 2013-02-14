//
//  DLLDockViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLDockViewController.h"

@interface DLLDockViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray; // legacy
@property (nonatomic, strong) NSArray *inventory;
@property (nonatomic, strong) DLLDockViewLayout *dockLayout;
- (void)selectCenterItem;
@end

@implementation DLLDockViewController

#define NUMBER_OF_SECTIONS 1
#define DUMMY_CELL_COUNT 5 // number of invisible dummy cells in the dock

@synthesize dataArray = _dataArray;
@synthesize delegate = _delegate;
@synthesize boardModel = _boardModel;
@synthesize dockLayout = _dockLayout;

#pragma mark -
#pragma mark property instantiation
- (NSMutableArray*)dataArray
{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (DLLDockViewLayout*)dockLayout
{
    if(!_dockLayout){
        _dockLayout = [[DLLDockViewLayout alloc] init];
    }
    return _dockLayout;
}

#pragma mark -
#pragma mark view initialization code
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Populate dataArray with demo data (legacy)
    for(int i = 0; i < DUMMY_CELL_COUNT; i++){
        [self.dataArray addObject:[UIImage imageNamed:@"placeholder"]];
    }
    for(int i = 0; i < DUMMY_CELL_COUNT; i++){
        [self.dataArray addObject:[UIImage imageNamed:@"200px-AND_ANSI"]];
    }
    [self.dataArray addObject:[UIImage imageNamed:@"chip-14.png"]];
    [self.dataArray addObject:[UIImage imageNamed:@"chip-16.png"]];
    for(int i = 0; i < DUMMY_CELL_COUNT; i++){
        [self.dataArray addObject:[UIImage imageNamed:@"200px-AND_ANSI"]];
    }
    for(int i = 0; i < DUMMY_CELL_COUNT; i++){
        [self.dataArray addObject:[UIImage imageNamed:@"placeholder"]];
    }
    
    // Configure layout
    self.dockLayout.delegate = self;
    [self.collectionView setCollectionViewLayout:self.dockLayout];
    
    // Allows manual selection (would have prefered this to be off but still allow programatic selection)
    [self.collectionView setAllowsSelection:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // set the height of the frame to 150
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, 70);
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // select middle item at start
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
    return [self.dataArray count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve reusable cell
    DLLDockViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"protoCell" forIndexPath:indexPath];
    
    // Set label number
    NSInteger row = [indexPath row];
    //cell.cellTitle.text = [NSString stringWithFormat:@"%d", row];
    
    // set background
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    UIImage *sourceBG = [self.dataArray objectAtIndex:row];
    CGSize bgSize = cell.frame.size;
    
    UIGraphicsBeginImageContext(bgSize);
    [sourceBG drawInRect:CGRectMake(0,0,bgSize.width,bgSize.height)];
    UIImage *resizedBG = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:resizedBG];
    cell.backgroundView = backgroundView;
    //cell.backgroundColor = UIColor.whiteColor;
    
    // set selection
    UIView *selectedView = [[UIView alloc] initWithFrame:cell.frame];
    selectedView.backgroundColor = UIColor.greenColor;
    cell.selectedBackgroundView = selectedView;
    
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
    [self.delegate selectionDidChange:selection];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// calculates the location of the center visible item in the dock and selects it
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
    // get the index of the middle element and select it
    NSInteger targetIndex = [temp indexOfObject:targetRow];
    [self.collectionView selectItemAtIndexPath:visiblePaths[targetIndex] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
    [self.delegate selectionDidChange:[visiblePaths[targetIndex] row]];
}

@end
