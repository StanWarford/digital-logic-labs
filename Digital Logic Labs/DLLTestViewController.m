//
//  DLLTestViewController.m
//  Digital Logic Labs
//
//  Created by Casey Chock on 3/27/13.
//  Copyright (c) 2013 Pepperdine. All rights reserved.
//

#import "DLLTestViewController.h"

@interface DLLTestViewController ()

@end

@implementation DLLTestViewController

@synthesize boardModel = _boardModel;
@synthesize lights = _lights;
@synthesize switches = _switches;
@synthesize segView = _segView;

#define SWITCH_ROW 450
#define SWITCH_COL_START 290
#define SWITCH_DEBOUNCED_SPACING 53
#define SWITCH_SPACING 64
#define SWITCH_SIZE_X 77
#define SWITCH_SIZE_Y 27
#define SWITCH_COUNT 10

#define LIGHT_ROW 245
#define LIGHT_COL_START 302
#define LIGHT_SIZE_X 50
#define LIGHT_SIZE_Y 50
#define LIGHT_SPACING 83
#define LIGHT_COUNT 8

#define SEG_ROW 270
#define SEG_COL 95
#define SEG_SIZE_X 115
#define SEG_SIZE_Y 187

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
        sw = [[DLLSwitch alloc] initWithFrame:frame andID:1];
        [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:sw];
        
        // Add second debounced switch
        frame = CGRectMake(SWITCH_COL_START + SWITCH_DEBOUNCED_SPACING, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
        sw = [[DLLSwitch alloc] initWithFrame:frame andID:2];
        [sw addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventTouchUpInside];
        [temp addObject:sw];
        
        // Add other switches
        for(int i = 2; i < SWITCH_COUNT; i++){
            frame = CGRectMake(SWITCH_COL_START + SWITCH_SPACING*i, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
            sw = [[DLLSwitch alloc] initWithFrame:frame andID:i+1];
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
            lt = [[DLLLightView alloc] initWithFrame:frame andID:i+1];
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
}

#pragma mark -
#pragma mark switch methods
- (IBAction)switchStateChanged:(DLLSwitch *)sender {
    NSInteger i = sender.identifier;
    //DLLLightView *target = [self.lights objectAtIndex:i];
    [self.segView toggleSegment:i onOff:sender.on];
    NSLog([NSString stringWithFormat:@"%d turned %s", sender.identifier, sender.on ? "ON" : "OFF"]);
}

#pragma mark -
#pragma mark MISC
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
