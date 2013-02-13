//
//  ViewController.m
//  fractionCalc
//
//  Created by Evan Hsu on 12/23/12.
//  Copyright (c) 2012 Evan Hsu. All rights reserved.
//

#import "ViewController.h"
#import "addFunc.h"
#import "AudioToolbox/AudioToolbox.h"
#import "BackgroundChooser.h"
#import "queue.h"

//CFURLRef soundFileURLRef;
//SystemSoundID soundFileObject;

@interface ViewController ()

@end

@implementation ViewController
{
    char op, prevOp;
    double decimal;
    NSDecimalNumber *result;
    NSDecimalNumber *currentNumber;
    BOOL firstOperand, isNumerator, operated, resultCalc, first, second;
    BOOL resultOrCurrent; //yes if result, no if current
    BOOL dot, specialNum, isShowingLandscapeView;
    BOOL opPressed;//used to determine whether consecutive operator buttons have been pressed
    BOOL settingCalled; //In settings or not
    BOOL addOpPressed;
    BOOL vertOrHoriz;
    int themeNum;
    NSMutableArray *array;
    SystemSoundID soundID;
    addFunc *additionalFunc;
    BackgroundChooser *bgChooser;
    NSMutableString *displayString;
    queue *history_queue;

}

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
@synthesize VerticalSettings;
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

//Background Selector
@synthesize BGScroll;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Variable Declaration
    operated = NO;
    resultCalc = NO;
    first = YES;
    second = YES;
    themeNum = 1;
    resultOrCurrent = NO;
    decimal = 0.1;
    dot = NO;
    specialNum = NO;
    opPressed = NO;
    settingCalled = NO;
    vertOrHoriz = YES;
    addOpPressed = NO;
    displayString = [NSMutableString stringWithCapacity: 40];
    result = [NSDecimalNumber zero];
    currentNumber = [NSDecimalNumber zero];
    
    //Additional Func Declaration
    additionalFunc = [[addFunc alloc] init];
    bgChooser = [[BackgroundChooser alloc] init];
    
    //Background Picker Wheel
    array = [[NSMutableArray alloc] initWithObjects:@"Metal", @"Flower", @"Wood", @"Tech", @"Space", @"Helion", @"INT Flower", @"Sky", @"Aqua Burst", @"Pyramid",  nil];
    self.BGScroll.delegate = self;
    self.BGScroll.dataSource = self;
    
    //History Table
    history_queue = [[queue alloc] init];
    HistoryTable.delegate = self; //Setting VC as Table delegate
    HistoryTable.dataSource = self; //Setting VC as Table data source
    SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, 0, SideBar.frame.size.height);
    SlideButton.frame = CGRectMake(0, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
    HistoryLabel.alpha = 0;
    HistoryTable.alpha = 0;
    ClearButton.alpha = 0;
    
    //Orientation code
    isShowingLandscapeView = NO;
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    self.view = self.HorizontalView;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification"
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    // to fix the controller showing under the status bar
    self.view.frame = [[UIScreen mainScreen] applicationFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*~~~~~~~~~~~~~~~~~~~void functions~~~~~~~~~~~~~~~~~*/

-(void) printResult
{
    NSLog(@"result function: %@", result);
}
-(void) processDigit:(int) digit
{
    //special number refers to "pi" and "e"
    if (specialNum == YES) {
        currentNumber = [NSDecimalNumber zero];
        specialNum = NO;
    }
    //If dot button has not been pressed
    if (dot == NO){
        //currentNumber = currentNumber * 10 + digit;
        
        //currentNumber = currentNumber * 10
        currentNumber = [currentNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"10"]];
        
        //currentNumber = currentNumber + digit
        currentNumber = [currentNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:
                                              [NSString stringWithFormat:@"%i", digit]]];
    }
    else{
        //currentNumber = currentNumber + (decimal * digit);
        currentNumber = [currentNumber decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:
                                              [NSString stringWithFormat:@"%f", decimal*digit]]];
        decimal = decimal * 0.1; //Moving decimal place to right.
        NSLog(@"currentNumber: %f decimal: %f", [currentNumber doubleValue], decimal);
    }
    [displayString appendString:[NSString stringWithFormat: @"%i", digit]];
    HorizontalDisplay.text = displayString;
    VerticalDisplay.text = displayString;
    resultOrCurrent = NO;

}

-(void) processOp: (char) theOp
{
    prevOp = op;
    op = theOp;
    [self calculate:prevOp];
    currentNumber = [NSDecimalNumber zero];
    operated = YES;
    [displayString setString:@""];
}

-(void) calculate:(char)theOp
{
    BOOL invalid = NO;
    if (first == NO) {
        NSLog(@"result: %@, currentNumber: %@", result, currentNumber);
        switch (theOp) {
            case '+':
                //result = result + currentNumber;
                if (YES) {
                    double resultDBLadd = [result doubleValue];
                    double currentDBLadd = [currentNumber doubleValue];
                    result = [NSDecimalNumber decimalNumberWithString:
                              [NSString stringWithFormat:@"%.14g", (resultDBLadd + currentDBLadd)]];
                    //result = [result decimalNumberByAdding:currentNumber];
                }
                break;
            case '-':
                //result = result - currentNumber;
                if (YES){
                    double resultDBLmin = [result doubleValue];
                    double currentDBLmin = [currentNumber doubleValue];
                    result = [NSDecimalNumber decimalNumberWithString:
                              [NSString stringWithFormat:@"%.14g", (resultDBLmin - currentDBLmin)]];
                }
                //result = [result decimalNumberBySubtracting:currentNumber];
                break;
            case '*':
                if (resultCalc == NO) {
                    //result = result * currentNumber;
                    double resultDBLmult = [result doubleValue];
                    double currentDBLmult = [currentNumber doubleValue];
                    result = [NSDecimalNumber decimalNumberWithString:
                              [NSString stringWithFormat:@"%.14g", (resultDBLmult * currentDBLmult)]];
                    //result = [result decimalNumberByMultiplyingBy:currentNumber];
                }
                break;
            case '/':
                if (resultCalc == NO){
                    //result = result / currentNumber;
                    if ([currentNumber compare:[NSDecimalNumber zero]] != NSOrderedSame) {
                        double resultDBLdiv = [result doubleValue];
                        double currentDBLdiv = [currentNumber doubleValue];
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.14g", (resultDBLdiv / currentDBLdiv)]];
                        //result = [result decimalNumberByDividingBy:currentNumber];
                    }
                    else{
                        invalid = YES;
                        result = [NSDecimalNumber zero];
                    }
                }
                break;
            case '^':
                if (resultCalc == NO) {
                    //result = pow(result, currentNumber);
                    double resultDBL = [result doubleValue];
                    double currentNumberDBL = [currentNumber doubleValue];
                    result = [NSDecimalNumber decimalNumberWithString:
                       [NSString stringWithFormat:@"%.14g", pow(resultDBL, currentNumberDBL)]];
                }
            default:
                break;
        }
        if (invalid) {
            [self invalidOp:invalid];
        }
        else{
            [self displayResult];      
        }
        resultOrCurrent = YES;
    }
    else{
        NSLog(@"inside here. current number: %.16g", [currentNumber doubleValue]);
        result = [NSDecimalNumber decimalNumberWithDecimal:[currentNumber decimalValue]];
        //result = [currentNumber decimalValue];
        first = NO;
    }
    resultCalc = NO;
    dot = NO;
    decimal = 0.1;
}

-(void) displayResult
{
    VerticalDisplay.text = [NSString stringWithFormat:@"%@", result];
    HorizontalDisplay.text = [NSString stringWithFormat:@"%@", result];
}

-(void) displayCurrent
{
    VerticalDisplay.text = [NSString stringWithFormat:@"%@", currentNumber];
    HorizontalDisplay.text = [NSString stringWithFormat:@"%@", currentNumber];
}

-(void) reset
{
    result = [NSDecimalNumber zero];
    currentNumber = [NSDecimalNumber zero];
    HorizOpDisplay.text = [NSString stringWithFormat:@""];
    opDisplay.text = [NSString stringWithFormat:@""];
    first = YES;
    opPressed = NO;
    [displayString setString:@""];
}

/*~~~~~~~~~~~~~~~~Digit buttons~~~~~~~~~~~~~~~~~~~*/

-(IBAction)clickDigit:(UIButton *)sender
{
    AudioServicesPlaySystemSound(1104);
    if (resultCalc == YES || addOpPressed == YES) {
        NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
        addOpPressed = NO;
    }
    //HorizOpDisplay.text = [NSString stringWithFormat:@""];
    //opDisplay.text = [NSString stringWithFormat:@""];
    opPressed = NO;
    int digit = sender.tag;
    [self processDigit:digit];
    [self printResult];
}

/*~~~~~~~~~~~~~~~Arithmetic Keys~~~~~~~~~~~~~~~~~~*/

-(IBAction) plus
{
    AudioServicesPlaySystemSound(1104);
    if (!opPressed) {
        opDisplay.text = [NSString stringWithFormat:@"+"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"+"];
        opPressed = YES;
        addOpPressed = NO;
        [self processOp:'+'];
    }
}

-(IBAction) minus
{
    AudioServicesPlaySystemSound(1104);
    if (!opPressed) {
        opDisplay.text = [NSString stringWithFormat:@"-"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"-"];
        opPressed = YES;
        addOpPressed = NO;
        [self processOp:'-'];
    }
}

-(IBAction) mult
{
    AudioServicesPlaySystemSound(1104);
    if (!opPressed) {
        opDisplay.text = [NSString stringWithFormat:@"*"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"*"];
        opPressed = YES;
        addOpPressed = NO;
        [self processOp:'*'];
    }
}

-(IBAction) div
{
    AudioServicesPlaySystemSound(1104);
    if (!opPressed) {
        opDisplay.text = [NSString stringWithFormat:@"/"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"/"];
        opPressed = YES;
        addOpPressed = NO;
        [self processOp:'/'];
    }
}

/*~~~~~~~~~~~~~~~~~~Misc Keys~~~~~~~~~~~~~~~~~~~~~*/


-(IBAction) clickClear
{
    AudioServicesPlaySystemSound(1104);
    [self reset];
    [self displayResult];
    resultOrCurrent = YES;
    opDisplay.text = [NSString stringWithFormat:@""];
    HorizOpDisplay.text = [NSString stringWithFormat:@""];
}

-(IBAction) clickEquals
{
    NSLog(@"Equals state");
    AudioServicesPlaySystemSound(1104);
    if (operated == NO){
        [self displayCurrent];
        resultOrCurrent = NO;
        [history_queue push:currentNumber];
    }
    else{
        [self calculate:op];
        [history_queue push:result];
    }
    resultCalc = YES;
    currentNumber = [NSDecimalNumber zero];
    opDisplay.text = [NSString stringWithFormat:@""];
    HorizOpDisplay.text = [NSString stringWithFormat:@""];
    
    NSLog(@"The first element is: %@", [history_queue front]);
    //updating the history table on equal press
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad && [history_queue size] > 14) {
        [history_queue pop];
    }
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone &&
             [history_queue size] > 5){
        [history_queue pop];
    }
    [HistoryTable reloadData];
}

-(IBAction)clickSign
{
    AudioServicesPlaySystemSound(1104);
    if (resultOrCurrent == YES) {
        //result = -(result);
        result = [result decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:
                                              [NSString stringWithFormat:@"-1"]]];
        [self displayResult];
    }
    else{
        currentNumber = [currentNumber decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:
                                                     [NSString stringWithFormat:@"-1"]]];
        [self displayCurrent];
    }
}

-(IBAction)clickDot
{
    AudioServicesPlaySystemSound(1104);
    //Special Num refers to "pi" and "e"
    if (specialNum == YES) {
        currentNumber = [NSDecimalNumber zero];
        specialNum = NO;
    }
    //if dot button has not already been preseed.
    if (resultCalc == NO) {
        [displayString appendString:[NSString stringWithFormat: @"."]];
    }
    else if (resultCalc == YES){
        [self reset];
        resultCalc = NO;
        [displayString appendString:[NSString stringWithFormat:@"."]];
        currentNumber = [NSDecimalNumber zero];
        decimal = 0.1;
    }
    
    //updating vertical and horizontal displays
    HorizontalDisplay.text = displayString;
    VerticalDisplay.text = displayString;
    
    //Sets dot as pressed.
    dot = YES;

}

-(IBAction) clickDel
{
    AudioServicesPlaySystemSound(1104);
    if (resultCalc == NO){
        currentNumber = [NSDecimalNumber zero];
        [self displayCurrent];
        resultOrCurrent = NO;
        [displayString setString:@""];
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

-(void) addOps: (int) operation
{
    AudioServicesPlaySystemSound(1104);
    if (resultOrCurrent == YES) {
        switch (operation) {
            case 1:
                result = [additionalFunc percent:result];
                break;
            case 2:
                result = [additionalFunc sinOp:result
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 3:
                result = [additionalFunc cosOp:result
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 4:
                result = [additionalFunc tanOp:result
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 5:
                result = [additionalFunc lnOp:result];
                break;
            case 6:
                result = [additionalFunc logOp:result];
                break;
            case 7:
                result = [additionalFunc divX:result];
                break;
            case 8:
                result = [additionalFunc etox:result];
                break;
            case 9:
                result = [additionalFunc xSqr:result];
                break;
            case 10:
                result = [additionalFunc absOp:result];
                break;
            default:
                break;
        }
        operated = NO;
        [self displayResult];
    }
    else {
        //opDisplay.text = @"";
        //HorizOpDisplay.text = @"";
        switch (operation) {
            case 1:
                currentNumber = [additionalFunc percent:currentNumber];
                break;
            case 2:
                currentNumber = [additionalFunc sinOp:currentNumber
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 3:
                currentNumber = [additionalFunc cosOp:currentNumber
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 4:
                currentNumber = [additionalFunc tanOp:currentNumber
                                                     :[RadDeg selectedSegmentIndex]==0?TRUE:FALSE];
                break;
            case 5:
                currentNumber = [additionalFunc lnOp:currentNumber];
                break;
            case 6:
                currentNumber = [additionalFunc logOp:currentNumber];
                break;
            case 7:
                currentNumber = [additionalFunc divX:currentNumber];
                break;
            case 8:
                currentNumber = [additionalFunc etox:currentNumber];
                break;
            case 9:
                currentNumber = [additionalFunc xSqr:currentNumber];
                break;
            case 10:
                currentNumber = [additionalFunc absOp:currentNumber];
                break;
            default:
                break;
        }
        addOpPressed = YES;
        operated = YES;
        [self displayCurrent];
    }
    //resultCalc = YES;
    decimal = 0.1;
    dot = NO;
    [displayString setString:@""];
}

-(NSComparisonResult) selfCompare: (NSDecimalNumber*) NSD: (double) selfDBL
{
        NSDecimalNumber *comparedInt = [NSDecimalNumber decimalNumberWithString:
                                       [NSString stringWithFormat:@"%.16g", selfDBL]];
    return [NSD compare:comparedInt];
}

-(IBAction) factorialButton
{
    AudioServicesPlaySystemSound(1104); //Plays clicking sound
    BOOL invalid = FALSE;
    if (resultOrCurrent == YES) {
        //if result number is >= 0 and is an integer.
        if (([result compare:[NSDecimalNumber zero]] == NSOrderedDescending ||
                [result compare:[NSDecimalNumber zero]] == NSOrderedSame) &&
                [self selfCompare:result :104] == NSOrderedAscending) {

            result = [additionalFunc factorial:result];
            [self displayResult];
            operated = NO;
        }
        //if result number is < 0 or is not an integer.
        else {invalid = TRUE; result = [NSDecimalNumber zero]; }
    }
    else{

        //if current number entered is >=0 and is an integer.
        if (([currentNumber compare:[NSDecimalNumber zero]] == NSOrderedDescending ||
            [currentNumber compare:[NSDecimalNumber zero]] == NSOrderedSame) &&
            [self selfCompare:currentNumber :104] == NSOrderedAscending) {
            
            currentNumber = [additionalFunc factorial:currentNumber];
            operated = YES;
            [self displayCurrent];
            addOpPressed = YES;
        }
        //if current number entere is < 0 or is not an integer.
        else {invalid = TRUE; currentNumber = [NSDecimalNumber zero]; }
    }
    decimal = 0.1;
    dot = NO;
    //resultCalc = YES;
    [self invalidOp:invalid];
    [displayString setString:@""];
}

-(IBAction) SqrRootButton
{
    AudioServicesPlaySystemSound(1104);
    BOOL invalid = FALSE;
    if (resultOrCurrent == YES){
        if (result < 0) {invalid = TRUE; }
        else {
            result = [additionalFunc SqrRoot:result];
            operated = NO;
            [self displayResult];
        }
    }
    else{
        if (currentNumber < 0) {invalid = TRUE; }
        else {
            currentNumber = [additionalFunc SqrRoot:currentNumber];
            operated = YES;
            [self displayCurrent];
            addOpPressed = YES;
        }
    }
    decimal = 0.1;
    dot = NO;
    //resultCalc = YES;
    [self invalidOp:invalid];
}
-(IBAction) percentButton
{
    [self addOps:1];
}
-(IBAction) sinButton
{
    [self addOps:2];
}
-(IBAction) cosButton
{
    [self addOps:3];
}
-(IBAction) tanButton
{
    [self addOps:4];
}
-(IBAction) lnButton
{
    [self addOps:5];
}
-(IBAction) logButton
{
    [self addOps:6];
}
-(IBAction) divXButton
{
    [self addOps:7];
}
-(IBAction) etoxButton
{
    [self addOps:8];
}
-(IBAction) xSqrButton
{
    [self addOps:9];
}
-(IBAction) ytoxButton
{
    AudioServicesPlaySystemSound(1104);
    if (!opPressed) {
        opDisplay.text = [NSString stringWithFormat:@"^"];
        HorizOpDisplay.text = [NSString stringWithFormat:@"^"];
        opPressed = YES;
        [self processOp:'^'];
    }
}
-(IBAction) absButton
{
    [self addOps:10];
}
-(IBAction) piButton
{
    AudioServicesPlaySystemSound(1104);
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = [additionalFunc pi];
    [self displayCurrent];
    if (first == YES){NSLog(@"first = yes");}
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
}
-(IBAction) epsilonButton
{
    AudioServicesPlaySystemSound(1104);
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = [additionalFunc epsilon];
    [self displayCurrent];
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
}
/*~~~~~~~~~~~~~~~~~~Animations~~~~~~~~~~~~~~~~~~~~~*/
-(void) dissapear
{
    self.view.alpha = 1.0;
    [UIView animateWithDuration:0.3 animations:^() {
        self.view.alpha = 0;
    }];
}

-(void) appear
{
    self.view.alpha = 0;
    [UIView animateWithDuration:0.3 animations:^() {
        self.view.alpha = 1.0;
    }];
}
/*~~~~~~~~~~~~~~~~~~Settings~~~~~~~~~~~~~~~~~~~~~~~*/

-(IBAction) gotoSettings
{
    AudioServicesPlaySystemSound(1104);
    settingCalled = YES;
    [self dissapear];
    self.view = self.VerticalSettings;
    self.view.alpha = 0;
    [self appear];
}

-(IBAction) gotoCalc
{
    AudioServicesPlaySystemSound(1104);
    [self selectBG];
    settingCalled = NO;
    [self dissapear];
    if (vertOrHoriz) {
        self.view = self.VerticalView;
    }
    else{
        self.view = self.HorizontalView;
    }
    [self appear];
}


/*~~~~~~~~~~~~~~~~History Side Bar~~~~~~~~~~~~~~~~~*/

-(IBAction)onOpenButtonClick:(id)sender
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    
    if (SideBar.frame.size.width == self.view.frame.size.width/2) //Closing Side Bar
    {
        
        SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, 0, SideBar.frame.size.height);
        SlideButton.frame = CGRectMake(0, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
        [SlideButton setTitle:@">" forState:UIControlStateNormal];
        [self HistoryBar:0];
        
    }
    else //Opening Side Bar
    {
        SideBar.frame = CGRectMake(0, SideBar.frame.origin.y, self.view.frame.size.width/2, SideBar.frame.size.height);
        SlideButton.frame = CGRectMake(self.view.frame.size.width/2, SlideButton.frame.origin.y, SlideButton.frame.size.width, SlideButton.frame.size.height);
        [SlideButton setTitle:@"<" forState:UIControlStateNormal];
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
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = [history_queue index:indexPath.row];
    [self displayCurrent];
    if (first == YES){NSLog(@"first = yes");}
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
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
-(void) updateTheme
{
    VerticalBackground.image = [bgChooser chooseBackgroundVertical:themeNum];
    HorizontalBackground.image = [bgChooser chooseBackgroundHorizontal:themeNum];
    
    //Vertical Buttons
    [cV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [divV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [multV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [acV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [minV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [plusV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [nineV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [eightV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [sevenV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [sixV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [fiveV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [fourV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [threeV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [twoV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [oneV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [zeroV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [signV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [dotV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [settingsV setBackgroundImage: [bgChooser chooseKeyVerticalOne:themeNum] forState:UIControlStateNormal];
    [equalsV setBackgroundImage: [bgChooser chooseKeyVerticalTwo:themeNum] forState:UIControlStateNormal];
    
    //Horizontal Buttons
    [cH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [divH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [multH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [acH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [minH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [plusH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [nineH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [eightH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [sevenH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [sixH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [fiveH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [fourH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [threeH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [twoH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [oneH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [zeroH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [dotH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [signH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [settingsH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [equalsH setBackgroundImage: [bgChooser chooseKeyHorizontalTwo:themeNum] forState:UIControlStateNormal];
    
    [factorialH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [sqrtH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [percH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [sinH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [cosH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [tanH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [lnH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [logH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [divXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [eToXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [xSqrH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [yToXH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [absH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [piH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [eH setBackgroundImage: [bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    [SlideButton setBackgroundImage:[bgChooser chooseKeyHorizontalOne:themeNum] forState:UIControlStateNormal];
    
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

-(void) selectBG
{
    NSLog(@"It has been selected");
    UIColor *color;
    themeNum = [BGScroll selectedRowInComponent:0];
    color = [bgChooser colorSelect:themeNum];
    NSLog(@"Theme number: %i", themeNum);
    [self updateTheme];
    [self updateButton:color];
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

-(IBAction) test
{
    if ([BGScroll selectedRowInComponent:0] == 1) {
        NSLog(@"this is a test");
    }
    else if ([BGScroll selectedRowInComponent:0] == 2) {
        NSLog(@"this is the 2nd test");
    }
    else{
        NSLog(@"default");
    }
    
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
    //UIDeviceOrientation deviceOrientation = [[object object] orientation];
    UIDeviceOrientation deviceOrientation = [UIDevice currentDevice].orientation;
    if (deviceOrientation == UIInterfaceOrientationPortrait) {
        vertOrHoriz = YES;
        VerticalSettings.transform = CGAffineTransformMakeRotation(0);
        VerticalView.transform = CGAffineTransformMakeRotation(0);
        if (settingCalled) {
            self.view = self.VerticalSettings;
        }
        else{
            [self dissapear];
            self.view = self.VerticalView;
            [self appear];
        }
    }
    else if (deviceOrientation == UIInterfaceOrientationPortraitUpsideDown){
        vertOrHoriz = YES;
        VerticalSettings.transform = CGAffineTransformMakeRotation(M_PI);
        VerticalView.transform = CGAffineTransformMakeRotation(M_PI);
        if (settingCalled) {
            
            self.view = self.VerticalSettings;
        }
        else{
            [self dissapear];
            self.view = self.VerticalView;
            [self appear];
        }
    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeRight){
        vertOrHoriz = NO;
        VerticalSettings.transform = CGAffineTransformMakeRotation(M_PI/2);
        HorizontalView.transform = CGAffineTransformMakeRotation(M_PI/2);
        if (settingCalled) {
            self.view = self.VerticalSettings;
        }
        else{
            [self dissapear];
            self.view = self.HorizontalView;
            [self appear];
        }
    }
    else if (deviceOrientation == UIInterfaceOrientationLandscapeLeft){
        vertOrHoriz = NO;
        VerticalSettings.transform = CGAffineTransformMakeRotation(3*(M_PI/2));
        HorizontalView.transform = CGAffineTransformMakeRotation(3*(M_PI/2));
        if (settingCalled) {
            self.view = self.VerticalSettings;
        }
        else{
            [self dissapear];
            self.view = self.HorizontalView;
            [self appear];
        }
        
    }
}

@end
















