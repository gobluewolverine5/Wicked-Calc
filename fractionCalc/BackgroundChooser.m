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
            return [UIImage imageNamed:@"Metal (Av).jpg"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower (Av).jpg"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood (Av).jpg"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech (Av).jpg"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space (Av).jpg"];
            break;
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion (Av).jpg"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP (Av).jpg"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm (Av).jpg"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst (Av).jpg"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids (Av).jpg"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal (Av).jpg"];
            break;
    }
}

-(UIImage*) chooseBackgroundHorizontal: (int) number
{
    switch (number) {
        case 0:
            NSLog(@"case 1");//Metal
            return [UIImage imageNamed:@"Metal [Ah].jpg"];
            break;
        case 1:
            NSLog(@"case 2");//Flower
            return [UIImage imageNamed:@"Flower [Ah].jpg"];
            break;
        case 2:
            NSLog(@"case 3");//Wood
            return [UIImage imageNamed:@"Wood [Ah].jpg"];
            break;
        case 3:
            NSLog(@"case 4");//Car Tech
            return [UIImage imageNamed:@"Car Tech [Ah].jpg"];
            break;
        case 4:
            NSLog(@"case 5");//Space
            return [UIImage imageNamed:@"Space [Ah].jpg"];
            break;
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion [Ah].jpg"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP [Ah].jpg"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm [Ah].jpg"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst [Ah].jpg"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids [Ah].jpg"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal [Ah].jpg"];
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
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion (1v).png"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP (1v).png"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm (1v).png"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst (1v).png"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids (1v).png"];
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
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion (2v).png"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP (2v).png"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm (2v).png"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst (2v).png"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids (2v).png"];
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
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion [1h].png"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP [1h].png"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm [1h].png"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst [1h].png"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids [1h].png"];
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
        case 5:
            NSLog(@"case 6"); //Helion
            return [UIImage imageNamed:@"Helion [2h].png"];
            break;
        case 6:
            NSLog(@"case 7");//Int Flower
            return [UIImage imageNamed:@"Int Flower WP [2h].png"];
            break;
        case 7:
            NSLog(@"case 8");//Sky
            return [UIImage imageNamed:@"Farm [2h].png"];
            break;
        case 8:
            NSLog(@"case 9");//Aqua Burst
            return [UIImage imageNamed:@"Aqua Burst [2h].png"];
            break;
        case 9:
            NSLog(@"case 10");//Pyramid
            return [UIImage imageNamed:@"Metallic Pyramids [2h].png"];
            break;
        default:
            NSLog(@"case default");
            return [UIImage imageNamed:@"Metal [2h].png"];
            break;
    }
}

-(UIColor*) colorSelect: (int) number
{
    UIColor * color;
    switch (number) {
        case 0: //Metal
            color = [UIColor blackColor];
            break;
        case 1://Flower
            color = [UIColor whiteColor];
            break;
        case 2://Wood
            color = [UIColor blackColor];
            break;
        case 3://Tech
            color = [UIColor blackColor];
            break;
        case 4://Space
            color = [UIColor cyanColor];
            break;
        case 5://Helion
            color = [UIColor orangeColor];
            break;
        case 6://Int Flower
            color = [UIColor blackColor];
            break;
        case 7://Sky
            color = [UIColor blackColor];
            break;
        case 8://Aqua Burst
            color = [UIColor blackColor];
            break;
        case 9://Pyramid
            color = [UIColor whiteColor];
            break;
        default:
            color = [UIColor blackColor];
            break;
    }
    return color;
}

@end
