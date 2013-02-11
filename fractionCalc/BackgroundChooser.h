//
//  BackgroundChooser.h
//  Custom Calc
//
//  Created by Evan Hsu on 1/6/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackgroundChooser : NSObject

-(UIImage*) chooseBackgroundVertical: (int) number;
-(UIImage*) chooseBackgroundHorizontal: (int)number;
-(UIImage*) chooseKeyVerticalOne: (int) number;
-(UIImage*) chooseKeyVerticalTwo: (int) number;
-(UIImage*) chooseKeyHorizontalOne: (int) number;
-(UIImage*) chooseKeyHorizontalTwo: (int) number;

@end
