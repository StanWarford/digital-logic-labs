//
//  DLLSevenSegmentView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLSevenSegmentView.h"

@interface DLLSevenSegmentView ()

@property (nonatomic, strong) UIImage *seg1;
@property (nonatomic, strong) UIImage *seg2;
@property (nonatomic, strong) UIImage *seg3;
@property (nonatomic, strong) UIImage *seg4;
@property (nonatomic, strong) UIImage *seg5;
@property (nonatomic, strong) UIImage *seg6;
@property (nonatomic, strong) UIImage *seg7;
@property (nonatomic, strong) UIImage *segEmpty;
@property (nonatomic, strong) UIImage *segOverlay;
@property (nonatomic, strong) NSArray *state;
- (void)updateImage;
- (UIImage*)getSegmentImage:(NSInteger)number;

@end

@implementation DLLSevenSegmentView

@synthesize seg1 = _seg1;
@synthesize seg2 = _seg2;
@synthesize seg3 = _seg3;
@synthesize seg4 = _seg4;
@synthesize seg5 = _seg5;
@synthesize seg6 = _seg6;
@synthesize seg7 = _seg7;
@synthesize segEmpty = _segEmpty;
@synthesize segOverlay = _segOverlay;
@synthesize state = _state;

#pragma mark -
#pragma mark lazy instantiation metods
- (UIImage*)seg1
{
    if(!_seg1){
        _seg1 = [UIImage imageNamed:@"test-7-seg-display-1"];
    }
    return _seg1;
}

- (UIImage*)seg2
{
    if(!_seg2){
        _seg2 = [UIImage imageNamed:@"test-7-seg-display-2"];
    }
    return _seg2;
}

- (UIImage*)seg3
{
    if(!_seg3){
        _seg3 = [UIImage imageNamed:@"test-7-seg-display-3"];
    }
    return _seg3;
}

- (UIImage*)seg4
{
    if(!_seg4){
        _seg4 = [UIImage imageNamed:@"test-7-seg-display-4"];
    }
    return _seg4;
}

- (UIImage*)seg5
{
    if(!_seg5){
        _seg5 = [UIImage imageNamed:@"test-7-seg-display-5"];
    }
    return _seg5;
}

- (UIImage*)seg6
{
    if(!_seg6){
        _seg6 = [UIImage imageNamed:@"test-7-seg-display-6"];
    }
    return _seg6;
}

- (UIImage*)seg7
{
    if(!_seg7){
        _seg7 = [UIImage imageNamed:@"test-7-seg-display-7"];
    }
    return _seg7;
}

- (UIImage*)segEmpty
{
    if(!_segEmpty){
        _segEmpty = [UIImage imageNamed:@"test-7-seg-display-empty"];
    }
    return _segEmpty;
}

- (UIImage*)segOverlay
{
    if(!_segOverlay){
        _segOverlay = [UIImage imageNamed:@"test-7-seg-display-overlay"];
    }
    return _segOverlay;
}

- (NSArray*)state
{
    if(!_state){
        NSMutableArray *temp = [NSMutableArray array];
        for(int i = 0; i < 7; i++){
            [temp addObject:[NSNumber numberWithBool:NO]];
        }
        _state = temp;
    }
    return _state;
}

#pragma mark -
#pragma mark initialization methods
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.image = self.segOverlay;
    }
    return self;
}

#pragma mark -
#pragma mark segment control methods
- (void)toggleSegment:(NSInteger)number onOff:(BOOL)on
{
    if([[self.state objectAtIndex:(number - 1)] boolValue] != on){
        NSMutableArray *temp = [NSMutableArray array];
        for(int i = 0; i < 7; i ++){
            [temp addObject:[NSNumber numberWithBool:i == (number - 1) ? on : [[self.state objectAtIndex:i] boolValue]]];
        }
        self.state = [NSArray arrayWithArray:temp];
        [self updateImage];
    }
}

#pragma mark -
#pragma mark image manipulation methods
- (UIImage*)getSegmentImage:(NSInteger)number
{
    switch(number)
    {
        case 1:
            return self.seg1;
            break;
        case 2:
            return self.seg2;
            break;
        case 3:
            return self.seg3;
            break;
        case 4:
            return self.seg4;
            break;
        case 5:
            return self.seg5;
            break;
        case 6:
            return self.seg6;
            break;
        case 7:
            return self.seg7;
            break;
        default:
            return self.segEmpty;
            break;
    }
}

- (void)updateImage
{
    // draw necessary segments on to the context then put the overlay on top and flatten
    // then set new image
    UIGraphicsBeginImageContextWithOptions(self.segEmpty.size, NO, 0.0);
    for(int i = 0; i < [self.state count]; i++){
        if([[self.state objectAtIndex:i] boolValue]){
            [[self getSegmentImage:i+1] drawAtPoint:CGPointMake(0,0)];
        }
    }
    [self.segOverlay drawAtPoint:CGPointMake(0,0)];
    UIImage *compiledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.image = compiledImage;
}

@end
