//
//  DLLChip.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 2/15/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChip.h"

@interface DLLChip()

- (UIImage*)makeGhostWithHoleAvailable:(BOOL)available;

@end

@implementation DLLChip

#pragma mark -
#pragma mark initialization methods
- (id)initWithIdenfifier:(NSInteger)identifier andType:(NSInteger)type
{
    if((self = [super init])){
        self.identifier = identifier;
        if(self.identifier == 0){
            self.image = [UIImage imageNamed:@"placeholder"];
        }else if(self.identifier == 7400){
            self.image = [UIImage imageNamed:@"chip-14"];
        }else if(self.identifier == 7476){
            self.image = [UIImage imageNamed:@"chip-16"];
        }else{
            self.image = [UIImage imageNamed:@"200px-AND_ANSI"];
        }
    self.type = type;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
- (void)displayComponentInView:(UIView *)view atCoordinates:(CGPoint)loc
{
    if(self.imageView){
        [self removeImageView];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(loc.x, loc.y, self.image.size.width, self.image.size.height)];
    self.imageView.image = self.image;
    [view addSubview:self.imageView];
}

- (void)displayGhostInView:(UIView *)view atCoordinates:(CGPoint)loc withHoleAvailable:(BOOL)available
{
    if(self.imageView){
        [self removeImageView];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(loc.x, loc.y, self.image.size.width, self.image.size.height)];
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
