//
//  BackgroundChooser.m
//  Custom Calc
//
//  Created by Evan Hsu on 1/6/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "BackgroundChooser.h"

@implementation BackgroundChooser

-(UIImage*) chooseBackgroundVertical: (int) number
{
    switch (number) {
        case 0:
            NSLog(@"case 1"); //Metal
            return [UIImage imageNamed:@"Metal (Av) brighter.png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower (Av).png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood (Av).png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech (Av).png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space (Av).png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal (Av).png"];
            break;
    }
}

-(UIImage*) chooseBackgroundHorizontal: (int) number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"Metal [Ah].png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower [Ah].png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood [Ah].png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech [Ah].png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space [Ah].png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal [Ah].png"];
            break;
    }
}

-(UIImage*) chooseKeyVerticalOne: (int) number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"metal (1v).png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower (1v).png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood (1v).png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech (1v).png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space (1v).png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"metal (1v).png"];
            break;
    }
}

-(UIImage*) chooseKeyVerticalTwo: (int) number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"metal (2v).png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower (2v).png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood (2v).png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech (2v).png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space (2v).png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"metal (2v).png"];
            break;
    }
}

-(UIImage*) chooseKeyHorizontalOne:(int)number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"Metal [1h].png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower [1h].png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood [1h].png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech [1h].png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space [1h].png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal [1h].png"];
            break;
    }
}

-(UIImage*) chooseKeyHorizontalTwo:(int)number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"Metal [2h].png"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower [2h].png"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood [2h].png"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech [2h].png"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space [2h].png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal [2h].png"];
            break;
    }
}

@end
