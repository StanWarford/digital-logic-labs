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

#define SWITCH_ROW 138
#define SWITCH_COL_START 10
#define SWITCH_SPACING 50
#define SWITCH_SIZE_X 60
#define SWITCH_SIZE_Y 26
#define SWITCH_COUNT 10

#define LIGHT_ROW 220
#define LIGHT_COL_START 64
#define LIGHT_SIZE_X 20
#define LIGHT_SIZE_Y 20
#define LIGHT_SPACING 50
#define LIGHT_COUNT 8

#pragma mark -
#pragma mark lazy instantiation methods
- (NSArray*)switches
{
    if(!_switches){
        NSMutableArray *temp = [NSMutableArray array];
        CGRect frame;
        DLLSwitch *sw;
        for(int i = SWITCH_SPACING; i <= SWITCH_SPACING*SWITCH_COUNT; i+=SWITCH_SPACING){
            frame = CGRectMake(SWITCH_COL_START+i, SWITCH_ROW, SWITCH_SIZE_X, SWITCH_SIZE_Y);
            sw = [[DLLSwitch alloc] initWithFrame:frame andID:i/SWITCH_SPACING];
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
        for(int i = LIGHT_SPACING; i <= LIGHT_SPACING*LIGHT_COUNT; i+=LIGHT_SPACING){
            frame = CGRectMake(LIGHT_COL_START+i, LIGHT_ROW, LIGHT_SIZE_X, LIGHT_SIZE_Y);
            lt = [[DLLLightView alloc] initWithFrame:frame andID:i/LIGHT_SPACING];
            [temp addObject:lt];
        }
        _lights = [NSArray arrayWithArray:temp];
    }
    return _lights;
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
}

#pragma mark -
#pragma mark switch methods
- (IBAction)switchStateChanged:(DLLSwitch *)sender {
    NSInteger i = sender.identifier - 1;
    DLLLightView *target = [self.lights objectAtIndex:i];
    [target toggleState];
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
