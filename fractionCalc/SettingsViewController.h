//
//  SettingsViewController.h
//  Wicked Calc
//
//  Created by Evan Hsu on 2/28/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SettingsViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource>

/*Shared Variables*/
@property (nonatomic) BOOL *vertOrHoriz;
@property (nonatomic) int orientation_id;
@property (nonatomic) int themeNum;

/*Objects*/
@property (strong, nonatomic) IBOutlet UIPickerView *BGscroll;
@property (strong, nonatomic) IBOutlet UIImageView *PreviewWindow;

@property (strong, nonatomic) IBOutlet UIImageView *mainImage;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (strong, nonatomic) IBOutlet UIImageView *rightImagetwo;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UIImageView *leftImageTwo;


@end
