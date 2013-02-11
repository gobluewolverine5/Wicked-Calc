//
//  ViewController.h
//  fractionCalc
//
//  Created by Evan Hsu on 12/23/12.
//  Copyright (c) 2012 Evan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource,
    UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UIView *VerticalView;
    IBOutlet UIView *HorizontalView;
}

//Number displays
@property (strong, nonatomic) IBOutlet UILabel *VerticalDisplay;
@property (strong, nonatomic) IBOutlet UILabel *HorizontalDisplay;

//Orientation Views
@property (strong, nonatomic) IBOutlet UIView *VerticalView;
@property (strong, nonatomic) IBOutlet UIView *HorizontalView;
@property (strong, nonatomic) IBOutlet UIView *VerticalSettings;

//History Table
@property (strong, nonatomic) IBOutlet UIView *SideBar;
@property (strong, nonatomic) IBOutlet UITableView *HistoryTable;
@property (strong, nonatomic) IBOutlet UIButton *ClearButton;
@property (strong, nonatomic) IBOutlet UILabel *HistoryLabel;
@property (strong, nonatomic) IBOutlet UIButton *SlideButton;


//Operation displays
@property (strong, nonatomic) IBOutlet UILabel *opDisplay;
@property (strong, nonatomic) IBOutlet UILabel *HorizOpDisplay;

//ImageView background
@property (strong, nonatomic) IBOutlet UIImageView *VerticalBackground;
@property (strong, nonatomic) IBOutlet UIImageView *HorizontalBackground;

//Vertical Buttons
@property (weak, nonatomic) IBOutlet UIButton *cV;
@property (weak, nonatomic) IBOutlet UIButton *divV;
@property (weak, nonatomic) IBOutlet UIButton *multV;
@property (weak, nonatomic) IBOutlet UIButton *acV;
@property (weak, nonatomic) IBOutlet UIButton *minV;
@property (weak, nonatomic) IBOutlet UIButton *nineV;
@property (weak, nonatomic) IBOutlet UIButton *eightV;
@property (weak, nonatomic) IBOutlet UIButton *sevenV;
@property (weak, nonatomic) IBOutlet UIButton *plusV;
@property (weak, nonatomic) IBOutlet UIButton *sixV;
@property (weak, nonatomic) IBOutlet UIButton *fiveV;
@property (weak, nonatomic) IBOutlet UIButton *fourV;
@property (weak, nonatomic) IBOutlet UIButton *threeV;
@property (weak, nonatomic) IBOutlet UIButton *twoV;
@property (weak, nonatomic) IBOutlet UIButton *oneV;
@property (weak, nonatomic) IBOutlet UIButton *zeroV;
@property (weak, nonatomic) IBOutlet UIButton *equalsV;
@property (weak, nonatomic) IBOutlet UIButton *signV;
@property (weak, nonatomic) IBOutlet UIButton *dotV;
@property (weak, nonatomic) IBOutlet UIButton *settingsV;

//Horizontal Buttons
@property (weak, nonatomic) IBOutlet UIButton *cH;
@property (weak, nonatomic) IBOutlet UIButton *divH;
@property (weak, nonatomic) IBOutlet UIButton *multH;
@property (weak, nonatomic) IBOutlet UIButton *acH;
@property (weak, nonatomic) IBOutlet UIButton *minH;
@property (weak, nonatomic) IBOutlet UIButton *plusH;
@property (weak, nonatomic) IBOutlet UIButton *equalsH;
@property (weak, nonatomic) IBOutlet UIButton *nineH;
@property (weak, nonatomic) IBOutlet UIButton *eightH;
@property (weak, nonatomic) IBOutlet UIButton *sevenH;
@property (weak, nonatomic) IBOutlet UIButton *sixH;
@property (weak, nonatomic) IBOutlet UIButton *fiveH;
@property (weak, nonatomic) IBOutlet UIButton *fourH;
@property (weak, nonatomic) IBOutlet UIButton *threeH;
@property (weak, nonatomic) IBOutlet UIButton *twoH;
@property (weak, nonatomic) IBOutlet UIButton *oneH;
@property (weak, nonatomic) IBOutlet UIButton *zeroH;
@property (weak, nonatomic) IBOutlet UIButton *dotH;
@property (weak, nonatomic) IBOutlet UIButton *signH;
@property (weak, nonatomic) IBOutlet UIButton *factorialH;
@property (weak, nonatomic) IBOutlet UIButton *sqrtH;
@property (weak, nonatomic) IBOutlet UIButton *percH;
@property (weak, nonatomic) IBOutlet UIButton *sinH;
@property (weak, nonatomic) IBOutlet UIButton *cosH;
@property (weak, nonatomic) IBOutlet UIButton *tanH;
@property (weak, nonatomic) IBOutlet UIButton *lnH;
@property (weak, nonatomic) IBOutlet UIButton *logH;
@property (weak, nonatomic) IBOutlet UIButton *divXH;
@property (weak, nonatomic) IBOutlet UIButton *eToXH;
@property (weak, nonatomic) IBOutlet UIButton *xSqrH;
@property (weak, nonatomic) IBOutlet UIButton *yToXH;
@property (weak, nonatomic) IBOutlet UIButton *absH;
@property (weak, nonatomic) IBOutlet UIButton *piH;
@property (weak, nonatomic) IBOutlet UIButton *eH;
@property (weak, nonatomic) IBOutlet UIButton *settingsH;

//Radians and Degrees selector
@property (weak, nonatomic) IBOutlet UISegmentedControl *RadDeg;

//Background Selection
@property (weak, nonatomic) IBOutlet UIPickerView *BGScroll;


//void functions
-(void) processDigit: (int) digit;
-(void) processOp: (char) theOp;
-(void) calculate: (char) theOp;
-(void) displayResult;
-(void) displayCurrent;
-(void) reset;


//Digit buttons
-(IBAction) clickDigit: (UIButton *) sender;

//Arithmetic Keys
-(IBAction) plus;
-(IBAction) minus;
-(IBAction) mult;
-(IBAction) div;

//Misc. Keys
-(IBAction) clickClear;
-(IBAction) clickEquals;
-(IBAction) clickSign;
-(IBAction) clickDot;
-(IBAction) clickDel;


//Additional Arithmetic
-(void) invalidOp:(BOOL) invalid;
-(IBAction) factorialButton;
-(IBAction) SqrRootButton;
-(IBAction) percentButton;
-(IBAction) sinButton;
-(IBAction) cosButton;
-(IBAction) tanButton;
-(IBAction) lnButton;
-(IBAction) logButton;
-(IBAction) divXButton;
-(IBAction) etoxButton;
-(IBAction) xSqrButton;
-(IBAction) ytoxButton;
-(IBAction) absButton;
-(IBAction) piButton;
-(IBAction) epsilonButton;

//Settings
-(IBAction) gotoSettings;
-(IBAction) gotoCalc;

//Background theme
-(void) updateTheme;

@end
