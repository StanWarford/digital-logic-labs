//
//  DLLChipView.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/4/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLChipView.h"

@interface DLLChipView ()
@property (nonatomic, strong) UIImage* availableGhostImage; // premade unhighlighted ghost image
@property (nonatomic, strong) UIImage* unavailableGhostImage; // premade highlighted ghost image
@property (nonatomic, assign) CGPoint center; // center of the view
- (UIImage*)makeGhostWithHoleAvailable:(BOOL)available forImage:(UIImage*)image;
- (UIImage*)convertImageToGrayScale:(UIImage*)image;
- (void)setChipImageAndSize:(NSInteger)identifier;
- (CGPoint)calculateUpperLeftPointFromCenterPoint:(CGPoint)point;
@end

@implementation DLLChipView

#define COLOR_INTENSITY 0.5 // 0 < n < 1, 1 = opaque 0 = transparent
#define GHOST_TRANSPARENCY 0.5 // 0 < n < 1, 1 = opaque 0 = transparent

// Increase these values to move the chip further left from the touch point
#define X_OFFSET_14 140 // offset from middle to first pin for 14 pin chips
#define X_OFFSET_16 151 // offset from middle to first pin for 16 pin chips
#define X_OFFSET_ALU 177 // offset from middle to first pin for the ALU

// Increase these values to move the chip further up from the touch point
#define Y_OFFSET 38// offset from middle to first pin for all chips except the ALU
#define Y_OFFSET_ALU 43 // offset from middle to first pin for the ALU

@synthesize availableGhostImage = _availableGhostImage;
@synthesize unavailableGhostImage = _unavailableGhostImage;
@synthesize center = _center;

#pragma mark -
#pragma mark property instantiation methods
- (UIImage*)availableGhostImage
{
    if(!_availableGhostImage){
        _availableGhostImage = [self makeGhostWithHoleAvailable:YES forImage:self.image];
    }
    return _availableGhostImage;
}

- (UIImage*)unavailableGhostImage
{
    if(!_unavailableGhostImage){
        _unavailableGhostImage = [self makeGhostWithHoleAvailable:NO forImage:self.image];
    }
    return _unavailableGhostImage;
}

#pragma mark -
#pragma mark initialization methods
- (id)initChipAtLocation:(CGPoint)coords inView:(UIView *)view withID:(NSInteger)identifier
{
    if((self = [super init])){
        [self setChipImageAndSize:identifier];
        self.center = coords;
        self.start = [self calculateUpperLeftPointFromCenterPoint:self.center];
        self.targetView = view;
        self.identifier = identifier;
    }
    return self;
}

- (id)initChipWithID:(NSInteger)identifier
{
    if((self = [super init])){
        [self setChipImageAndSize:identifier];
        self.start = CGPointMake(0.0, 0.0);
        self.identifier = identifier;
    }
    return self;
}

#pragma mark -
#pragma mark display methods
- (void)displayComponent
{
    if(self.imageView){
        [self removeGraphics];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.start.x, self.start.y, self.image.size.width, self.image.size.height)];
    self.imageView.image = self.image;
    [self.targetView addSubview:self.imageView];
}

- (void)displayGhostWithHoleAvailable:(BOOL)available
{
    if(self.imageView){
        [self removeGraphics];
    }
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.start.x, self.start.y, self.image.size.width, self.image.size.height)];
    self.imageView.image = available ? self.availableGhostImage : self.unavailableGhostImage;
    [self.targetView addSubview:self.imageView];
}

- (void)translateStartTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    self.center = coords;
    self.start = [self calculateUpperLeftPointFromCenterPoint:coords];
    self.imageView.image = available ? self.availableGhostImage :self.unavailableGhostImage;
    [UIView beginAnimations:@"UIImage Move" context:NULL];
    CGSize size = self.imageView.frame.size;
    self.imageView.frame = CGRectMake(self.start.x, self.start.y, size.width, size.height);
    [UIView commitAnimations];
}

- (void)translateEndTo:(CGPoint)coords withHoleAvailable:(BOOL)available
{
    [NSException raise:NSInternalInconsistencyException format:@"%@ is not used with chips.", NSStringFromSelector(_cmd)];
}

- (void)removeGraphics
{
    [self.imageView removeFromSuperview];
    self.imageView = nil;
}

- (CGPoint)getOffsetPointFrom:(CGPoint)coords
{
    return [self calculateUpperLeftPointFromCenterPoint:coords];
}

#pragma mark -
#pragma mark image manipulation methods
- (UIImage*)makeGhostWithHoleAvailable:(BOOL)available forImage:(UIImage*)image
{
    UIImage *targetImage = image;
    UIColor *highlightColor = [UIColor redColor];
    
    // If unavailable, highlight the image with highlightColor at intensity
    if(!available){
        // create grayscale image to highlight
        UIImage *grayImage = [self convertImageToGrayScale:image];
        
        // highlight grayscale image with highlight color
        CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
        CGSize size = grayImage.size;
        UIGraphicsBeginImageContextWithOptions(size, NO, 2);
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        [grayImage drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];
        
        CGContextSetFillColorWithColor(context, highlightColor.CGColor);
        CGContextSetBlendMode(context, kCGBlendModeOverlay);
        CGContextSetAlpha(context, COLOR_INTENSITY);
        
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(CGPointZero.x, CGPointZero.y, grayImage.size.width, grayImage.size.height));
        
        UIImage *highlightedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        // Ceate an image mask taking only the alpha channel from the original image
        CGContextRef context2 = CGBitmapContextCreate(nil, grayImage.size.width, grayImage.size.height, 8, 0, nil, kCGImageAlphaOnly);
        CGContextDrawImage(context2, imageRect, [grayImage CGImage]);
        CGImageRef mask = CGBitmapContextCreateImage(context2);
        CGContextRelease(context2);
        
        targetImage = [UIImage imageWithCGImage:CGImageCreateWithMask(highlightedImage.CGImage, mask) scale:grayImage.scale orientation:grayImage.imageOrientation];
    }
    
    // Increase transparency of image to make ghost
    UIGraphicsBeginImageContextWithOptions(targetImage.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, targetImage.size.width, targetImage.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, GHOST_TRANSPARENCY);
    
    CGContextDrawImage(ctx, area, targetImage.CGImage);
    
    UIImage *ghostImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return ghostImage;
}

- (UIImage*)convertImageToGrayScale:(UIImage *)image
{
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    // Grayscale color space
    CGColorSpaceRef graySpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, graySpace, kCGImageAlphaNone);
    
    // Draw image into current context with specified rectangle using previously defined context (with grayscale color space)
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Release colorspace and context in preparation to make the mask
    CGImageRef grayImage = CGBitmapContextCreateImage(context);
    CGColorSpaceRelease(graySpace);
    CGContextRelease(context);
    
    // Create an image mask taking only the alpha channel from the original image
    context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, nil, kCGImageAlphaOnly);
    CGContextDrawImage(context, imageRect, [image CGImage]);
    CGImageRef mask = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    // Create the transparent image from the opaque image by applying the mask
    UIImage *grayScaleImage = [UIImage imageWithCGImage:CGImageCreateWithMask(grayImage, mask) scale:image.scale orientation:image.imageOrientation];
    
    // Return new grayscale image
    return grayScaleImage;
}

#pragma mark -
#pragma mark uitility methods
- (void)setChipImageAndSize:(NSInteger)identifier
{
    switch (identifier)
    {
        case 7400:
            self.image = [UIImage imageNamed:@"7400"];
            self.size = 14;
            break;
        case 7402:
            self.image = [UIImage imageNamed:@"7402"];
            self.size = 14;
            break;
        case 7404:
            self.image = [UIImage imageNamed:@"7404"];
            self.size = 14;
            break;
        case 7408:
            self.image = [UIImage imageNamed:@"7408"];
            self.size = 14;
            break;
        case 7432:
            self.image = [UIImage imageNamed:@"7432"];
            self.size = 14;
            break;
        case 7447:
            self.image = [UIImage imageNamed:@"7447"];
            self.size = 16;
            break;
        case 7476:
            self.image = [UIImage imageNamed:@"7476"];
            self.size = 16;
            break;
        case 7485:
            self.image = [UIImage imageNamed:@"7485"];
            self.size = 16;
            break;
        case 7486:
            self.image = [UIImage imageNamed:@"7486"];
            self.size = 14;
            break;
        case 74151:
            self.image = [UIImage imageNamed:@"74151"];
            self.size = 16;
            break;
        case 74164:
            self.image = [UIImage imageNamed:@"74164"];
            self.size = 14;
            break;
        case 74176:
            self.image = [UIImage imageNamed:@"74176"];
            self.size = 14;
            break;
        case 74181:
            self.image = [UIImage imageNamed:@"74181"];
            self.size = 24;
            break;
        case 74711:
            self.image = [UIImage imageNamed:@"74711"];
            self.size = 14;
            break;
        default:
            self.image = [UIImage imageNamed:@"200px-AND_ANSI"];
            break;
    }
}

- (CGPoint)calculateUpperLeftPointFromCenterPoint:(CGPoint)point
{
    NSInteger x = point.x;
    NSInteger y = point.y;
    NSInteger xOffset;
    NSInteger yOffset;
    switch(self.size)
    {
        case 14:
            xOffset = X_OFFSET_14;
            yOffset = Y_OFFSET;
            break;
        case 16:
            xOffset = X_OFFSET_16;
            yOffset = Y_OFFSET;
            break;
        case 24:
            xOffset = X_OFFSET_ALU;
            yOffset = Y_OFFSET_ALU;
            break;
        default:
            xOffset = 0;
            yOffset = 0;
            break;
    }
    return CGPointMake(x-xOffset, y-yOffset);
}
@end
