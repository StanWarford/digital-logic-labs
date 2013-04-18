//
//  DLLTestViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLTestViewController.h"

@interface DLLTestViewController ()
- (void)updateLightState:(NSArray*)lights;
- (void)updateSevenSegState:(NSArray*)segments;
- (void)swipeSegue:(UISwipeGestureRecognizer*)recognizer;
@end

@implementation DLLTestViewController

@synthesize boardModel = _boardModel;
@synthesize lights = _lights;
@synthesize switches = _switches;
@synthesize segView = _segView;

#define SWITCH_ROW 450 // down direction vertical y coordinate where switches begin appearing
#define SWITCH_COL_START 290 // right direction horizontal x coordinate where switches begin appearing
#define SWITCH_DEBOUNCED_SPACING 53 // horizontal spacing specific to debounced switches
#define SWITCH_SPACING 64 // horizontal spacing for non-debounced switches
#define SWITCH_SIZE_X 77 // length of switches
#define SWITCH_SIZE_Y 27 // height of switches
#define SWITCH_COUNT 10 // number of switches

#define LIGHT_ROW 245 // down direction vertical y coordinate where lights begin appearing
#define LIGHT_COL_START 302 // right direction horizontal x coordinate where lights begin appearing
#define LIGHT_SIZE_X 50 // length of lights
#define LIGHT_SIZE_Y 50 // width of lights
#define LIGHT_SPACING 83 // horizontal spacing between lights
#define LIGHT_COUNT 8 // number of lights

#define SEG_ROW 270 // down direction vertical y coordinate where seven segment display begins appearing
#define SEG_COL 95 // right direction horizontal x coordinate where seven segment display begins appearing
#define SEG_SIZE_X 115 // length of seven segment display
#define SEG_SIZE_Y 187 // width of seven segment display

#pragma mark -
#pragma mark lazy instantiation methods
- (NSArray*)switches
{
    if(!_switches){
        NSMutableArray *temp = [NSMutableArray array];
        CGRect frame;
        DLLSwitch *sw;
        
        // Add first debounced switch
        frame = CGRectMake(SWITCH_COL_START, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
        sw = [[DLLSwitch alloc] initWithFrame:frame andID:0];
        [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:sw];
        
        // Add second debounced switch
        frame = CGRectMake(SWITCH_COL_START + SWITCH_DEBOUNCED_SPACING, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
        sw = [[DLLSwitch alloc] initWithFrame:frame andID:1];
        [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:sw];
        
        // Add other switches
        for(int i = 2; i < SWITCH_COUNT; i++){
            frame = CGRectMake(SWITCH_COL_START + SWITCH_SPACING*i, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
            sw = [[DLLSwitch alloc] initWithFrame:frame andID:i];
            [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventTouchUpInside];
            [temp addObject:sw];
            
        }
        _switches = [NSArray arrayWithArray:temp];
    }
    return _switches;
}

- (NSArray*)lights
{
    if(!_lights){
        NSMutableArray *temp = [NSMutableArray array];
        CGRect frame;
        DLLLightView *lt;
        for(int i = 0; i < LIGHT_COUNT; i++){
            frame = CGRectMake(LIGHT_COL_START + i*LIGHT_SPACING, LIGHT_ROW, LIGHT_SIZE_X, LIGHT_SIZE_Y);
            lt = [[DLLLightView alloc] initWithFrame:frame andID:i];
            [temp addObject:lt];
        }
        _lights = [NSArray arrayWithArray:temp];
    }
    return _lights;
}

- (DLLSevenSegmentView*)segView
{
    if(!_segView){
        CGRect frame = CGRectMake(SEG_COL, SEG_ROW, SEG_SIZE_X, SEG_SIZE_Y);
        _segView = [[DLLSevenSegmentView alloc] initWithFrame:frame];
    }
    return _segView;
}

#pragma mark -
#pragma mark initialization methods
// display all the switches and lights
- (void)viewDidLoad
{
    [super viewDidLoad];
    for(DLLSwitch *sw in self.switches){
        [self.view addSubview:sw];
    }
    for(DLLLightView *lt in self.lights){
        [self.view addSubview:lt];
    }
    [self.view addSubview:self.segView];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"test-screen"]];
    
    [self.boardModel runSimulation];
    [self updateLightState:[self.boardModel newStateOfLights]];
    [self updateSevenSegState:[self.boardModel newStateOfSevenSeg]];
    
    // setup 2 finger swipe right gesture recognizer to segue to board screen
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeSegue:)];
    [swipe setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipe setDelaysTouchesBegan:YES];
    [swipe setNumberOfTouchesRequired:2];
    [self.view addGestureRecognizer:swipe];

}

#pragma mark -
#pragma mark switch methods
- (IBAction)switchStateChanged:(DLLSwitch *)sender {
    NSInteger i = sender.identifier;
    [self.boardModel simulateThrowOfSwitchLabeled:i];
    [self updateLightState:[self.boardModel newStateOfLights]];
    [self updateSevenSegState:[self.boardModel newStateOfSevenSeg]];
}

#pragma mark -
#pragma mark light methods
- (void)updateLightState:(NSArray *)lights
{
    for(NSInteger i = 0; i < [lights count]; i++){
        NSNumber *number = [lights objectAtIndex:i];
        if([number integerValue] == 0){
            [[self.lights objectAtIndex:i] toggleOff];
        }else if([number integerValue] == 1){
            [[self.lights objectAtIndex:i] toggleOn];
        }else{
            [[self.lights objectAtIndex:i] toggleDim];
        }
    }
}

#pragma mark -
#pragma mark seven segment methods
- (void)updateSevenSegState:(NSArray *)segments
{
    for(NSInteger i = 0; i < 7; i++){
        NSNumber *num = [segments objectAtIndex:i];
        NSInteger set = [num integerValue];
        [self.segView toggleSegment:i+1 onOff:set == 1];
    }
}

#pragma mark -
#pragma mark gesture recognizer responder methods
- (void)swipeSegue:(UISwipeGestureRecognizer *)recognizer
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.switches = nil;
    self.lights = nil;
    self.segView = nil;
}
@end
