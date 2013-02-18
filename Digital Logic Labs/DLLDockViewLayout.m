//
//  DLLDockViewLayout.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 1/31/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLDockViewLayout.h"

@interface DLLDockViewLayout ()

- (void)selectCenterItem;

@end

@implementation DLLDockViewLayout

#define ITEM_SIZE 75 // needed to make active frame to select correct item to zoom
#define ACTIVE_DISTANCE 100 // change to zoom cells outside of active frame
#define ZOOM_FACTOR 0.7 // defines amount of zoom
#define ITEM_SPACING 5000.0 // used to ensure items display in a single row
#define LINE_SPACING 20.0 // defines minimum spacing between items

@synthesize delegate = _delegate;

#pragma mark -
#pragma mark initialization
- (id)init
{
    if((self = [super init])){
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.minimumInteritemSpacing = ITEM_SPACING;
        self.minimumLineSpacing = LINE_SPACING;
    }
    return self;
}

#pragma mark -
#pragma mark Zooming
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributeList = [super layoutAttributesForElementsInRect:rect];
    
    CGRect visibleRect; // rectangle around center item
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    // set zoom for cells that intersect with the target area
    for(UICollectionViewLayoutAttributes *attributes in attributeList){
        if(CGRectIntersectsRect(attributes.frame, rect)){
            CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
            CGFloat normalizedDist = distance / ACTIVE_DISTANCE;
            if(ABS(distance) < ACTIVE_DISTANCE){
                CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDist));
                attributes.transform3D = CATransform3DMakeScale(zoom, zoom, 1.0);
                attributes.zIndex = round(zoom);
            }
        }
    }
    
    // Keep the middle element selected while scrolling
    [self selectCenterItem];
    return attributeList;
}

#pragma mark -
#pragma mark Force Updates
- (BOOL) shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    // set to true to refresh items while scrolling
    return YES;
}

#pragma mark -
#pragma mark Center Snapping
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    // Force scrolling to stop with items centered
    CGFloat offSetAdjustment = CGFLOAT_MAX;
    CGFloat horizontalCenter = (CGFloat)(proposedContentOffset.x + self.collectionView.bounds.size.width/2.0);
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray *array = [self layoutAttributesForElementsInRect:targetRect];
    for(UICollectionViewLayoutAttributes *attributes in array){
        CGFloat itemHorizontalCenter = attributes.center.x;
        if(ABS(itemHorizontalCenter - horizontalCenter) < ABS(offSetAdjustment)){
            offSetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    
    return CGPointMake(proposedContentOffset.x+offSetAdjustment, proposedContentOffset.y);
}

#pragma mark -
#pragma mark MISC
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
        [self.delegate selectionDidChange:[visiblePaths[targetIndex] row]];
    }
}

@end
