//
//  NotepadSettings.m
//  Wicked Calc
//
//  Created by Evan Hsu on 3/8/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "NotepadSettings.h"

@interface NotepadSettings ()

@end

@implementation NotepadSettings{
    CGFloat insideBrush;
    CGFloat insideOpacity;
    CGFloat red;
    CGFloat blue;
    CGFloat green;
    int     color_mode;
}
@synthesize delegate;
@synthesize BrushSlider;
@synthesize OpacitySlider;
@synthesize ColorSelection;

//Passed Data

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
    NSLog(@"insideBrush: %f", insideBrush);
    NSLog(@"insideOpacity: %f", insideOpacity);
    [BrushSlider setValue:(insideBrush / 10.0)];
    [OpacitySlider setValue:insideOpacity];
    [self obtainColor:color_mode];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    //What happens when the view appears
}

-(void) obtainBrush:(CGFloat) brush
{
    insideBrush = brush;
}

-(void) obtainOpacity:(CGFloat) opacity
{
    insideOpacity = opacity;
}

-(void) obtainRGB: (CGFloat) Red Bl:(CGFloat) Blue Gr:(CGFloat) Green
{
    red     = Red;
    blue    = Blue;
    green   = Green;
}

-(void)obtainColor:(int)mode
{
    color_mode = mode;
    switch (color_mode) {
        case 0:
            NSLog(@"Black Selected");
            ColorSelection.image = [UIImage imageNamed:@"Pyramids [1h].png"];
            break;
        case 1:
            NSLog(@"Blue Selected");
            ColorSelection.image = [UIImage imageNamed:@"New Sky [1h].png"];
            break;
        case 2:
            NSLog(@"Red Selected");
            ColorSelection.image = [UIImage imageNamed:@"Red B.png"];
            break;
        case 3:
            NSLog(@"Green Selected");
            ColorSelection.image = [UIImage imageNamed:@"Green B.png"];
            break;
        default:
            NSLog(@"Default Selected");
            break;
    }
}

-(IBAction)goBack:(id)sender
{
    [delegate dismissPop:insideOpacity B:insideBrush R:red Bl:blue Gr:green Color:color_mode];
}

- (IBAction)valueChanged:(id)sender
{
    NSLog(@"Brush changed");
    insideBrush = 10.0 * [BrushSlider value];
    NSLog(@"Brush should be: %f", 10.0 * [BrushSlider value]);
    NSLog(@"Brush is: %f", insideBrush);
}

- (IBAction)opacityChanged:(id)sender
{
    NSLog(@"Opacity changed");
    insideOpacity = [OpacitySlider value];
    NSLog(@"Opacity should be: %f", [OpacitySlider value]);
    NSLog(@"Opacity is: %f", insideOpacity);
}

-(IBAction)colorSelect:(UIButton*)sender
{
    switch (sender.tag) {
        case 0:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            [self obtainColor:0];
            break;
        case 1:
            red = 0.0/255.0;
            green = 0.0/255.0;
            blue = 255.0/255.0;
            [self obtainColor:1];
            break;
        case 2:
            red = 255.0/255.0;
            green = 0.0/255.0;
            blue = 0.0/255.0;
            [self obtainColor:2];
            break;
        case 3:
            red = 0.0/255.0;
            green = 255.0/255.0;
            blue = 0.0/255.0;
            [self obtainColor:3];
            break;
        default:
            break;
    }
}



@end
