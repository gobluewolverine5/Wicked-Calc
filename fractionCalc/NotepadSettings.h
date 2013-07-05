//
//  NotepadSettings.h
//  Wicked Calc
//
//  Created by Evan Hsu on 3/8/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NotepadSettingsDelegate;

@interface NotepadSettings : UIViewController

@property (weak) id <NotepadSettingsDelegate> delegate;

//Passed Data

@property (strong, nonatomic) IBOutlet UIButton *BlackColor;
@property (strong, nonatomic) IBOutlet UIButton *BlueColor;
@property (strong, nonatomic) IBOutlet UIButton *RedColor;
@property (strong, nonatomic) IBOutlet UIButton *GreenColor;

@property (strong, nonatomic) IBOutlet UIButton *ColorSelection;


@property (strong, nonatomic) IBOutlet UISlider *BrushSlider;

@property (strong, nonatomic) IBOutlet UISlider *OpacitySlider;
@property (strong, nonatomic) IBOutlet UIButton *Save;

- (void) obtainBrush:(CGFloat) brush;
- (void) obtainOpacity:(CGFloat) opacity;
- (void) obtainRGB: (CGFloat) Red Bl:(CGFloat) Blue Gr:(CGFloat) Green;
- (void) obtainColor: (int) mode;
- (IBAction)goBack:(id)sender;
- (IBAction)valueChanged:(id)sender;
- (IBAction)opacityChanged:(id)sender;
- (IBAction)colorSelect:(UIButton*)sender;

@end


@protocol NotepadSettingsDelegate <NSObject>

@required

-(void)dismissPop:(CGFloat)Opacity B:(CGFloat) Brush
R:(CGFloat) Red Bl:(CGFloat) Blue Gr:(CGFloat) Green Color:(int)mode;

@end