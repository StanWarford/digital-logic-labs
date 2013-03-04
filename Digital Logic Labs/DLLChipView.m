//
//  DLLChipView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChipView.h"

@implementation DLLChipView

#pragma mark -
#pragma mark initialization methods
- (id)initChipOfSize:(NSInteger)size AtLocation:(CGPoint)coords
{
    if((self = [super init])){
        if(size == 0){
            self.image = [UIImage imageNamed:@"placeholder"];
        }else if(size == 7400){
            self.image = [UIImage imageNamed:@"chip-14"];
        }else if(size == 7476){
            self.image = [UIImage imageNamed:@"chip-16"];
        }else{
            self.image = [UIImage imageNamed:@"200px-AND_ANSI"];
        }
        self.start = coords;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
- (void)displayComponentInView:(UIView *)view
{
    if(self.imageView){
        [self removeImageView];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.start.x, self.start.y, self.image.size.width, self.image.size.height)];
    self.imageView.image = self.image;
    [view addSubview:self.imageView];
}

- (void)displayGhostInView:(UIView *)view withHoleAvailable:(BOOL)available
{
    if(self.imageView){
        [self removeImageView];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.start.x, self.start.y, self.image.size.width, self.image.size.height)];
    self.imageView.image = [self makeGhostWithHoleAvailable:available];
    [view addSubview:self.imageView];
}

- (void)translateGhostImageTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    [UIView beginAnimations:@"UIImage Move" context:NULL];
    CGSize size = self.imageView.frame.size;
    self.imageView.frame = CGRectMake(coords.x, coords.y, size.width, size.height);
    [UIView commitAnimations];
}

- (void)removeImageView
{
    [self.imageView removeFromSuperview];
    self.imageView = nil;
}

#pragma mark -
#pragma mark image manipulation methods
- (UIImage*)makeGhostWithHoleAvailable:(BOOL)available
{
    // manipulate self.image to be a ghost (with highliting if !available)
    return self.image;
}
@end
