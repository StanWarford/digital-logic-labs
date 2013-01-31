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
}

- (void)viewWillAppear:(BOOL)animated
{
    // set the height of the frame to 150
    self.collectionView.frame = CGRectMake(self.collectionView.frame.origin.x, self.collectionView.frame.origin.y, self.collectionView.frame.size.width, 150);
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
    
    // Configure reusable cell
    NSInteger row = [indexPath row];
    UIImage *image = [UIImage imageNamed:@"200px-AND_ANSI"];
    cell.cellTitle.text = [self.dataArray objectAtIndex:row];
    cell.cellImage.image = image;
    cell.backgroundColor = UIColor.whiteColor;
    
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
