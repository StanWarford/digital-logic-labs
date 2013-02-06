//
//  DLLDockViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLDockViewController.h"

@interface DLLDockViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray; // temporary repository of data just to get the demo working
@end

@implementation DLLDockViewController

#define NUMBER_OF_SECTIONS 1

@synthesize dataArray = _dataArray;

#pragma mark -
#pragma mark early initialization code
-(id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.dataArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark view initialization code
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Populate dataArray with demo data
    for(int i = 0; i < 50; i++){
        [self.dataArray addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    // Configure layout
    DLLDockViewLayout *dockLayout = [[DLLDockViewLayout alloc] init];
    [self.collectionView setCollectionViewLayout:dockLayout];
    
    // Allows manual selection (would have prefered this to be off but still allow programatic selection)
    [self.collectionView setAllowsSelection:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    // set the height of the frame to 150
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, 150);
}


- (void)viewDidAppear:(BOOL)animated
{
    // select middle item at start
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
    cell.cellTitle.text = [self.dataArray objectAtIndex:row];
    
    // set background
    UIView *backgroundView = [[UIView alloc] initWithFrame:cell.frame];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"200px-AND_ANSI"]];
    cell.backgroundView = backgroundView;
    cell.backgroundColor = UIColor.whiteColor;
    
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
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
