//
//  SettingsViewController.m
//  Wicked Calc
//
//  Created by Evan Hsu on 2/28/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController{
    NSMutableArray *array;
}

@synthesize vertOrHoriz;
@synthesize orientation_id;
@synthesize themeNum;
@synthesize BGscroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //list of Picker View themes
    array = [[NSMutableArray alloc] initWithObjects:@"Metal", @"Flower", @"Wood", @"Tech", @"Space",
             @"Helion", @"INT Flower", @"Sky", @"Aqua Burst", @"Pyramid", @"Blue",
             @"Button", @"Grate", @"Frosty Leaves", @"Green", nil];
    
    self.BGscroll.delegate = self;
    self.BGscroll.dataSource = self;
    
    //Orientation Code
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    NSLog(@"loaded theme: %i", themeNum);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SettingsToCalc"]) {
        ViewController *controller = (ViewController*) segue.destinationViewController;
        controller.vertOrHoriz = vertOrHoriz;
        controller.orientation_id = orientation_id;
        themeNum = [BGscroll selectedRowInComponent:0];
        controller.themeNum = themeNum;
        NSLog(@"SENT THEMENUM: %i", themeNum);
    }
}

/*~~~~~~~~~~~~~~~~~Picker View~~~~~~~~~~~~~~~~~~~~*/
-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //updating themeNum on Picker View index
    themeNum = [BGscroll selectedRowInComponent:0];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    //One Column
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return array.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:
(NSInteger)component
{
    //set item per row
    return [array objectAtIndex:row];
}


/*~~~~~~~~~~~~~~~~~Orientation~~~~~~~~~~~~~~~~~~~~*/

-(BOOL)shouldAutorotate{
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

-(void)orientationChanged:(NSNotification *) object
{
    //UIDeviceOrientation deviceOrientation = [[object object] orientation];
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (deviceOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"orientation 0");
        orientation_id = 0;
        vertOrHoriz = YES;
    }
    else if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        NSLog(@"orientation 1");
        orientation_id = 1;
        vertOrHoriz = YES;
    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeRight){
        NSLog(@"orientation 2");
        orientation_id = 2;
        vertOrHoriz = NO;

    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeLeft){
        NSLog(@"orientation 3");
        orientation_id = 3;
        vertOrHoriz = NO;
    }
    else{
        NSLog(@"orientation 0");
        orientation_id = 0;
        vertOrHoriz = YES;
    }
}

@end