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
- (void)brownPressed;
- (void)bluePressed;
- (void)greenPressed;
- (void)blackPressed;

@end

@implementation DLLWireDetailPopover

#define BUTTONS_X_START 280 // right direction horizontal location where buttons start appearing
#define BUTTONS_X_SPACING 150 // spacing between columns of buttons

#define BUTTONS_Y_START 100 // down direction vertical location where buttons start appearing
#define BUTTONS_Y_SPACING 150 // spacing between rows of buttons

#define BUTTONS_LENGTH 100 // length of buttons
#define BUTTONS_WIDTH 100 // width of buttons

@synthesize wire = _wire; // pointer to selected wire in dock
@synthesize buttons = _buttons; // array of buttons to display

#pragma mark -
#pragma mark lazy instantiation methods
// set up all buttons to display
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
        
        UIButton *brownButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [brownButton addTarget:self action:@selector(brownPressed) forControlEvents:UIControlEventTouchDown];
        [brownButton setTintColor:[UIColor brownColor]];
        [brownButton setTitle:@"Brown" forState:UIControlStateNormal];
        [temp addObject:brownButton];
        
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
        
        UIButton *blackButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [blackButton addTarget:self action:@selector(blackPressed) forControlEvents:UIControlEventTouchDown];
        [blackButton setTintColor:[UIColor blackColor]];
        [blackButton setTitle:@"Black" forState:UIControlStateNormal];
        [temp addObject:blackButton];
        
        _buttons = [NSArray arrayWithArray:temp];
    }
    return _buttons;
}

#pragma mark -
#pragma mark initialization methods
// display all buttons
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
    self.wire.color = [UIColor redColor];
}

- (void)orangePressed
{
    self.messageBox.text = @"Color set to orange";
    self.wire.color = [UIColor orangeColor];
}

- (void)brownPressed
{
    self.messageBox.text = @"Color set to brown";
    self.wire.color = [UIColor brownColor];
}

- (void)bluePressed
{
    self.messageBox.text = @"Color set to blue";
    self.wire.color = [UIColor blueColor];
}

- (void)greenPressed
{
    self.messageBox.text = @"Color set to green";
    self.wire.color = [UIColor greenColor];
}

- (void)blackPressed
{
    self.messageBox.text = @"Color set to black";
    self.wire.color = [UIColor colorWithRed:100/255 green:100/255 blue:100/255 alpha:1.0];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.buttons = nil;
}

@end
