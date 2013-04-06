//
//  DLLWireDetailPopover.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 4/5/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLWireDetailPopover.h"

@interface DLLWireDetailPopover ()
@property (nonatomic, strong) NSArray *buttons;
- (void)redPressed;
- (void)orangePressed;
- (void)yellowPressed;
- (void)bluePressed;
- (void)greenPressed;
- (void)greyPressed;
@end

@implementation DLLWireDetailPopover

#define BUTTONS_X_START 280
#define BUTTONS_X_SPACING 150
#define BUTTONS_Y_START 100
#define BUTTONS_Y_SPACING 150
#define BUTTONS_LENGTH 100
#define BUTTONS_WIDTH 100

@synthesize wire = _wire;
@synthesize buttons = _buttons;

#pragma mark -
#pragma mark lazy instantiation methods
- (NSArray*)buttons
{
    if(!_buttons){
        NSMutableArray *temp = [NSMutableArray array];
        
        UIButton *redButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [redButton addTarget:self action:@selector(redPressed) forControlEvents:UIControlEventTouchDown];
        [redButton setTintColor:[UIColor redColor]];
        [redButton setTitle:@"Red" forState:UIControlStateNormal];
        [temp addObject:redButton];
        
        UIButton *orangeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [orangeButton addTarget:self action:@selector(orangePressed) forControlEvents:UIControlEventTouchDown];
        [orangeButton setTintColor:[UIColor orangeColor]];
        [orangeButton setTitle:@"Orange" forState:UIControlStateNormal];
        [temp addObject:orangeButton];
        
        UIButton *yellowButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [yellowButton addTarget:self action:@selector(yellowPressed) forControlEvents:UIControlEventTouchDown];
        [yellowButton setTintColor:[UIColor yellowColor]];
        [yellowButton setTitle:@"Yellow" forState:UIControlStateNormal];
        [temp addObject:yellowButton];
        
        UIButton *blueButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [blueButton addTarget:self action:@selector(bluePressed) forControlEvents:UIControlEventTouchDown];
        [blueButton setTintColor:[UIColor blueColor]];
        [blueButton setTitle:@"Blue" forState:UIControlStateNormal];
        [temp addObject:blueButton];
        
        UIButton *greenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [greenButton addTarget:self action:@selector(greenPressed) forControlEvents:UIControlEventTouchDown];
        [greenButton setTintColor:[UIColor greenColor]];
        [greenButton setTitle:@"Green" forState:UIControlStateNormal];
        [temp addObject:greenButton];
        
        UIButton *greyButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [greyButton addTarget:self action:@selector(greyPressed) forControlEvents:UIControlEventTouchDown];
        [greyButton setTintColor:[UIColor grayColor]];
        [greyButton setTitle:@"Grey" forState:UIControlStateNormal];
        [temp addObject:greyButton];
        
        _buttons = [NSArray arrayWithArray:temp];
    }
    return _buttons;
}

#pragma mark -
#pragma mark initialization methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *button;
    NSInteger row = 0;
    for(NSInteger i = 0; i < [self.buttons count]; i++){
        button = [self.buttons objectAtIndex:i];
        button.frame = CGRectMake(BUTTONS_X_START + BUTTONS_X_SPACING*(i%2), BUTTONS_Y_START + BUTTONS_Y_SPACING*row, BUTTONS_LENGTH, BUTTONS_WIDTH);
        [self.view addSubview:button];
        if(i % 2 == 1){
            row++;
        }
    }
}

#pragma mark - 
#pragma mark button response methods
- (void)redPressed
{
    self.messageBox.text = @"Color set to red";
}

- (void)orangePressed
{
    self.messageBox.text = @"Color set to grey";
}

- (void)yellowPressed
{
    self.messageBox.text = @"Color set to orange";
}

- (void)bluePressed
{
    self.messageBox.text = @"Color set to blue";
}

- (void)greenPressed
{
    self.messageBox.text = @"Color set to green";
}

- (void)greyPressed
{
    self.messageBox.text = @"Color set to grey";
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
