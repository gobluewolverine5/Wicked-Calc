//
//  initController.m
//  Wicked Calc
//
//  Created by Evan Hsu on 3/6/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "initController.h"
#import "AudioToolbox/AudioToolbox.h"
#import "BackgroundChooser.h"
#import "queue.h"
#import "SettingsViewController.h"
#import "Calculator.h"

@interface initController ()

@end

@implementation initController
{
    BOOL isShowingLandscapeView;
    NSMutableArray *array;
    SystemSoundID soundID;
    BackgroundChooser *bgChooser;
    queue *history_queue;
    Calculator *myCalculator;
    
}
//Passed Variables
@synthesize vertOrHoriz;
@synthesize current_orientation;
@synthesize orientation_id;
@synthesize themeNum;

//Number displays
@synthesize VerticalDisplay;
@synthesize HorizontalDisplay;
//Operator displays
@synthesize opDisplay;
@synthesize HorizOpDisplay;
//History Table
@synthesize SideBar;
@synthesize HistoryTable;
@synthesize ClearButton;
@synthesize HistoryLabel;
@synthesize SlideButton;
//View Controller
@synthesize HorizontalView, VerticalView;
//Background Image Views
@synthesize VerticalBackground;
@synthesize HorizontalBackground;
//Vertical Buttons
@synthesize cV;
@synthesize divV;
@synthesize multV;
@synthesize acV;
@synthesize minV;
@synthesize plusV;
@synthesize nineV;
@synthesize eightV;
@synthesize sevenV;
@synthesize sixV;
@synthesize fiveV;
@synthesize fourV;
@synthesize threeV;
@synthesize twoV;
@synthesize oneV;
@synthesize zeroV;
@synthesize signV;
@synthesize dotV;
@synthesize equalsV;
@synthesize settingsV;

//Horizontal Buttons
@synthesize cH;
@synthesize divH;
@synthesize multH;
@synthesize acH;
@synthesize minH;
@synthesize plusH;
@synthesize equalsH;
@synthesize nineH;
@synthesize eightH;
@synthesize sevenH;
@synthesize sixH;
@synthesize fiveH;
@synthesize fourH;
@synthesize threeH;
@synthesize twoH;
@synthesize oneH;
@synthesize zeroH;
@synthesize dotH;
@synthesize signH;
@synthesize factorialH;
@synthesize sqrtH;
@synthesize percH;
@synthesize sinH;
@synthesize cosH;
@synthesize tanH;
@synthesize lnH;
@synthesize logH;
@synthesize divXH;
@synthesize eToXH;
@synthesize xSqrH;
@synthesize yToXH;
@synthesize absH;
@synthesize piH;
@synthesize eH;
@synthesize settingsH;

//Radians and Degrees selector
@synthesize RadDeg;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    /*Variable Declaration*/
    themeNum = 0;
    
    /*Object Allocation*/
    myCalculator = [[Calculator alloc] init];
    bgChooser = [[BackgroundChooser alloc] init];
    
    /*History Table*/
    history_queue = [[queue alloc] init];
    HistoryTable.delegate = self; //Setting VC as Table delegate
    HistoryTable.dataSource = self; //Setting VC as Table data source
    SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, 0, SideBar.frame.size.height);
    SlideButton.frame = CGRectMake(0, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
    HistoryLabel.alpha = 0;
    HistoryTable.alpha = 0;
    ClearButton.alpha = 0;
    
    /*Orientation code*/
    //self.view = self.HorizontalView;
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
    
    [self updateOrientation];
    [self selectBG:themeNum];
    NSLog(@"LOADED AND THEMENUM: %i", themeNum);
}

- (void)viewWillAppear:(BOOL)animated {
    // to fix the controller showing under the status bar
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"CalcToSettings"] || [segue.identifier isEqualToString:@"CalcToSettings2"]) {
        SettingsViewController *controller = (SettingsViewController*) segue.destinationViewController;
        controller.vertOrHoriz = vertOrHoriz;
        controller.orientation_id = orientation_id;
        controller.themeNum = themeNum;
    }
}

/*~~~~~~~~~~~~~~~~Display Updates~~~~~~~~~~~~~~~~~*/

-(void) displayResult
{
    VerticalDisplay.text = [NSString stringWithFormat:@"%@",
                            [myCalculator returnResult]];
    HorizontalDisplay.text = [NSString stringWithFormat:@"%@",
                              [myCalculator returnResult]];
}

-(void) displayCurrent
{
    VerticalDisplay.text = [NSString stringWithFormat:@"%@",
                            [myCalculator returnCurrent]];
    HorizontalDisplay.text = [NSString stringWithFormat:@"%@",
                              [myCalculator returnCurrent]];
}

-(void) displayDisplayString
{
    VerticalDisplay.text = [myCalculator returnDisplayString];
    HorizontalDisplay.text = [myCalculator returnDisplayString];
}

-(void) displayInvalid
{
    VerticalDisplay.text = [NSString stringWithFormat:@"Invalid Operation"];
    HorizontalDisplay.text = [NSString stringWithFormat:@"Invalid Operation"];
}

-(void) clearOps
{
    opDisplay.text = [NSString stringWithFormat:@""];
    HorizOpDisplay.text = [NSString stringWithFormat:@""];
}

/*~~~~~~~~~~~~~~~~Digit buttons~~~~~~~~~~~~~~~~~~~*/

-(IBAction)clickDigit:(UIButton *)sender
{
    //Playing Click Sound
    AudioServicesPlaySystemSound(1104);
    
    //Processing Digit input in Calculator Object
    int digit = sender.tag;
    NSMutableString *tempString = [NSMutableString stringWithCapacity: 40];
    [myCalculator clickDigit];
    tempString = [myCalculator processDigit:digit];
    [myCalculator printResult];
    
    //Updating Number displays
    HorizontalDisplay.text = tempString;
    VerticalDisplay.text = tempString;
    
}

/*~~~~~~~~~~~~~~~Arithmetic Keys~~~~~~~~~~~~~~~~~~*/

-(IBAction)clickOp:(UIButton *)sender
{
    AudioServicesPlaySystemSound(1104);
    char tempOp;
    switch (sender.tag) {
        case 0:
            tempOp = '+';
            break;
        case 1:
            tempOp = '-';
            break;
        case 2:
            tempOp = '*';
            break;
        case 3:
            tempOp = '/';
            break;
        default:
            tempOp = '+';
            break;
    }
    if ([myCalculator operand]) {
        opDisplay.text = [NSString stringWithFormat:@"%c", tempOp];
        HorizOpDisplay.text = [NSString stringWithFormat:@"%c", tempOp];
        if([myCalculator processOp:tempOp]){
            [self displayResult];
        }
    }
}



/*~~~~~~~~~~~~~~~~~~Misc Keys~~~~~~~~~~~~~~~~~~~~~*/


-(IBAction) clickClear
{
    AudioServicesPlaySystemSound(1104);
    //Resets Calculator object
    [myCalculator clear];
    
    //Reseting Number displays to zero
    [self displayResult];
    
    //Clearing the op displays
    [self clearOps];
}

-(IBAction) clickEquals
{
    NSLog(@"Equals state");
    AudioServicesPlaySystemSound(1104);
    if ([myCalculator equals]) {
        [self displayCurrent];
        [history_queue push:[myCalculator returnCurrent]];
    }
    else{
        if ([myCalculator returnInvalid]) {
            [self displayInvalid];
        }
        else{
            [self displayResult];
            [history_queue push:[myCalculator returnResult]];
        }
    }
    
    //Clearing the op displays
    [self clearOps];
    
    //Popping Result History if Full
    NSLog(@"The first element is: %@", [history_queue front]);
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [history_queue size] > 14) {
        [history_queue pop];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
             [history_queue size] > 5){
        [history_queue pop];
    }
    
    //Updates Result History Table View
    [HistoryTable reloadData];
}

-(IBAction)clickSign
{
    AudioServicesPlaySystemSound(1104);
    if ([myCalculator sign]) {
        [self displayResult];
    }
    else {
        [self displayCurrent];
    }
}

-(IBAction) clickDot
{
    AudioServicesPlaySystemSound(1104);
    [myCalculator dot];
    //updating vertical and horizontal displays
    [self displayDisplayString];
    
}

-(IBAction) clickDel
{
    AudioServicesPlaySystemSound(1104);
    if ([myCalculator del]){
        [self displayCurrent];
    }
}

/*~~~~~~~~~~~~~Aditional Arithmetic~~~~~~~~~~~~~~~~*/
-(void) invalidOp: (BOOL) invalid
{
    if (invalid){
        VerticalDisplay.text = [NSString stringWithFormat:@"Invalid Operation"];
        HorizontalDisplay.text = [NSString stringWithFormat:@"Invalid Operation"];
    }
}

-(IBAction) additionalOps: (UIButton*) sender
{
    AudioServicesPlaySystemSound(1104);
    if ([myCalculator addOps:sender.tag segment:[RadDeg selectedSegmentIndex]]) {
        [self displayResult];
    }
    else{
        [self displayCurrent];
    }
}

-(IBAction) factorialButton
{
    AudioServicesPlaySystemSound(1104); //Plays clicking sound
    
    //Determines what to display on factorial function
    if ([myCalculator factorial]) {
        [self displayResult];
    }
    else{
        [self displayCurrent];
    }
    
    //displays invalid message if factorial error exists
    if ([myCalculator returnInvalid]) {
        [self displayInvalid];
    }
}

-(IBAction) SqrRootButton
{
    AudioServicesPlaySystemSound(1104);
    
    //Determines what to display on factorial function
    if ([myCalculator SqrRoot]){
        [self displayResult];
    }
    else{
        [self displayCurrent];
    }
    
    //displays invalid message if factorial error exists
    if ([myCalculator returnInvalid]) {
        [self displayInvalid];
    }
}

-(IBAction) ytoxButton
{
    AudioServicesPlaySystemSound(1104);
    if ([myCalculator ytoxButton]) {
        opDisplay.text = [NSString stringWithFormat:@"^"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"^"];
    }
}

-(IBAction) piButton
{
    AudioServicesPlaySystemSound(1104);
    [myCalculator piButton];
    [self displayCurrent];
}
-(IBAction) epsilonButton
{
    AudioServicesPlaySystemSound(1104);
    [myCalculator epsilonButton];
    [self displayCurrent];
}
/*~~~~~~~~~~~~~~~~~~Animations~~~~~~~~~~~~~~~~~~~~~*/
-(void) dissapear:(UIView*) object
{
    object.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^() {
        object.alpha = 0;
    }];
}

-(void) appear:(UIView*) object
{
    object.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^() {
        object.alpha = 1.0;
    }];
}

/*~~~~~~~~~~~~~~~~History Side Bar~~~~~~~~~~~~~~~~~*/

-(IBAction)onOpenButtonClick:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    
    if (SideBar.frame.size.width == self.view.frame.size.width/2 ||
        SideBar.frame.size.width == self.view.frame.size.width/4) //Closing Side Bar
    {
        
        SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, 0, SideBar.frame.size.height);
        SlideButton.frame = CGRectMake(0, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
        [SlideButton setTitle:@">" forState:UIControlStateNormal];
        [self HistoryBar:0];
        
    }
    else //Opening Side Bar
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, self.view.frame.size.width/2, SideBar.frame.size.height);
            SlideButton.frame = CGRectMake(self.view.frame.size.width/2, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
            [SlideButton setTitle:@"<" forState:UIControlStateNormal];
        }
        else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, self.view.frame.size.width/4, SideBar.frame.size.height);
            SlideButton.frame = CGRectMake(self.view.frame.size.width/4, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
            [SlideButton setTitle:@"<" forState:UIControlStateNormal];
        }
        
        [self HistoryBar:1];
    }
    [UIView commitAnimations];
}

-(IBAction)clearQueue:(id)sender
{
    [history_queue clearQueue];
    [HistoryTable reloadData];
}


-(void) HistoryBar: (int) value
{
    HistoryLabel.alpha = value;
    HistoryTable.alpha = value;
    ClearButton.alpha = value;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AudioServicesPlaySystemSound(1104);
    NSLog(@"Index %@ selected", [history_queue index:indexPath.row]);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [myCalculator resultHistoryPress:[history_queue index:indexPath.row]];
    [self displayCurrent];
    //grab indexPath of the array
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return [history_queue size];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    //here you check for PreCreated cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Fill the cells...
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[[history_queue values] objectAtIndex: indexPath.row]];
    
    //yourMutableArray is Array
    return cell;
}



/*~~~~~~~~~~~~~~~~Background Theme~~~~~~~~~~~~~~~~~*/

-(void) selectBG: (int) num
{
    NSLog(@"It has been selected");
    UIColor *color;
    //themeNum = [BGScroll selectedRowInComponent:0];
    color = [bgChooser colorSelect:num];
    NSLog(@"Theme number: %i", num);
    [self updateTheme:num];
    [self updateButton:color];
}

-(void) updateTheme: (int) num
{
    NSLog(@"updateTheme: %i", num);
    VerticalBackground.image = [bgChooser chooseBackgroundVertical:num];
    HorizontalBackground.image = [bgChooser chooseBackgroundHorizontal:num];
    
    //Vertical Buttons
    [cV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [divV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [multV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [acV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [minV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [plusV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [nineV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [eightV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [sevenV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [sixV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [fiveV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [fourV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [threeV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [twoV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [oneV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [zeroV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [signV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [dotV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [settingsV setBackgroundImage: [bgChooser chooseKeyVerticalOne:num] forState:UIControlStateNormal];
    [equalsV setBackgroundImage: [bgChooser chooseKeyVerticalTwo:num] forState:UIControlStateNormal];
    
    //Horizontal Buttons
    [cH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [divH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [multH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [acH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [minH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [plusH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [nineH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [eightH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [sevenH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [sixH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [fiveH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [fourH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [threeH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [twoH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [oneH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [zeroH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [dotH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [signH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [settingsH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [equalsH setBackgroundImage: [bgChooser chooseKeyHorizontalTwo:num] forState:UIControlStateNormal];
    
    [factorialH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [sqrtH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [percH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [sinH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [cosH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [tanH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [lnH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [logH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [divXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [eToXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [xSqrH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [yToXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [absH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [piH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [eH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    [SlideButton setBackgroundImage:[bgChooser chooseKeyHorizontalOne:num] forState:UIControlStateNormal];
    
}

-(void) updateButton: (UIColor*) myColor
{
    
    //Vertical Buttons
    [cV setTitleColor:myColor forState:UIControlStateNormal];
    [divV setTitleColor:myColor forState:UIControlStateNormal];
    [multV setTitleColor:myColor forState:UIControlStateNormal];
    [acV setTitleColor:myColor forState:UIControlStateNormal];
    [minV setTitleColor:myColor forState:UIControlStateNormal];
    [plusV setTitleColor:myColor forState:UIControlStateNormal];
    [nineV setTitleColor:myColor forState:UIControlStateNormal];
    [eightV setTitleColor:myColor forState:UIControlStateNormal];
    [sevenV setTitleColor:myColor forState:UIControlStateNormal];
    [sixV setTitleColor:myColor forState:UIControlStateNormal];
    [fiveV setTitleColor:myColor forState:UIControlStateNormal];
    [fourV setTitleColor:myColor forState:UIControlStateNormal];
    [threeV setTitleColor:myColor forState:UIControlStateNormal];
    [twoV setTitleColor:myColor forState:UIControlStateNormal];
    [oneV setTitleColor:myColor forState:UIControlStateNormal];
    [zeroV setTitleColor:myColor forState:UIControlStateNormal];
    [signV setTitleColor:myColor forState:UIControlStateNormal];
    [dotV setTitleColor:myColor forState:UIControlStateNormal];
    [equalsV setTitleColor:myColor forState:UIControlStateNormal];
    [settingsV setTitleColor:myColor forState:UIControlStateNormal];
    
    //Horizontal Buttons
    [cH setTitleColor:myColor forState:UIControlStateNormal];
    [divH setTitleColor:myColor forState:UIControlStateNormal];
    [multH setTitleColor:myColor forState:UIControlStateNormal];
    [acH setTitleColor:myColor forState:UIControlStateNormal];
    [minH setTitleColor:myColor forState:UIControlStateNormal];
    [plusH setTitleColor:myColor forState:UIControlStateNormal];
    [nineH setTitleColor:myColor forState:UIControlStateNormal];
    [eightH setTitleColor:myColor forState:UIControlStateNormal];
    [sevenH setTitleColor:myColor forState:UIControlStateNormal];
    [sixH setTitleColor:myColor forState:UIControlStateNormal];
    [fiveH setTitleColor:myColor forState:UIControlStateNormal];
    [fourH setTitleColor:myColor forState:UIControlStateNormal];
    [threeH setTitleColor:myColor forState:UIControlStateNormal];
    [twoH setTitleColor:myColor forState:UIControlStateNormal];
    [oneH setTitleColor:myColor forState:UIControlStateNormal];
    [zeroH setTitleColor:myColor forState:UIControlStateNormal];
    [dotH setTitleColor:myColor forState:UIControlStateNormal];
    [signH setTitleColor:myColor forState:UIControlStateNormal];
    [equalsH setTitleColor:myColor forState:UIControlStateNormal];
    [settingsH setTitleColor:myColor forState:UIControlStateNormal];
    
    [factorialH setTitleColor:myColor forState:UIControlStateNormal];
    [sqrtH setTitleColor:myColor forState:UIControlStateNormal];
    [percH setTitleColor:myColor forState:UIControlStateNormal];
    [sinH setTitleColor:myColor forState:UIControlStateNormal];
    [cosH setTitleColor:myColor forState:UIControlStateNormal];
    [tanH setTitleColor:myColor forState:UIControlStateNormal];
    [lnH setTitleColor:myColor forState:UIControlStateNormal];
    [logH setTitleColor:myColor forState:UIControlStateNormal];
    [divXH setTitleColor:myColor forState:UIControlStateNormal];
    [eToXH setTitleColor:myColor forState:UIControlStateNormal];
    [xSqrH setTitleColor:myColor forState:UIControlStateNormal];
    [yToXH setTitleColor:myColor forState:UIControlStateNormal];
    [absH setTitleColor:myColor forState:UIControlStateNormal];
    [piH setTitleColor:myColor forState:UIControlStateNormal];
    [eH setTitleColor:myColor forState:UIControlStateNormal];
    [SlideButton setTitleColor:myColor forState:UIControlStateNormal];
    
}

/*~~~~~~~~~~~~~Orientation Functions~~~~~~~~~~~~~~~*/

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
    [self updateOrientation];
}

-(void) updateOrientation
{
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (deviceOrientation == UIInterfaceOrientationPortrait) {
        vertOrHoriz = YES;
        NSLog(@"orienation 0");
        orientation_id = 0;
        VerticalView.transform = CGAffineTransformMakeRotation(0);
        self.view = self.VerticalView;
    }
    else if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        vertOrHoriz = YES;
        NSLog(@"orientation 1");
        orientation_id = 1;
        VerticalView.transform = CGAffineTransformMakeRotation(M_PI);
        self.view = self.VerticalView;
    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeRight){
        vertOrHoriz = NO;
        NSLog(@"orientation 2");
        orientation_id = 2;
        HorizontalView.transform = CGAffineTransformMakeRotation(M_PI/2);
        self.view = self.HorizontalView;
    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeLeft){
        vertOrHoriz = NO;
        NSLog(@"orientation 3");
        orientation_id = 3;
        HorizontalView.transform = CGAffineTransformMakeRotation(3*(M_PI/2));
        self.view = self.HorizontalView;
    }
}


@end
