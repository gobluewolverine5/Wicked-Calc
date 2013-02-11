//
//  addFunc.m
//  Custom Calc
//
//  Created by Evan Hsu on 1/3/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "addFunc.h"

@implementation addFunc

-(BOOL) isInteger: (NSDecimalNumber*) number
{
    double myDouble = [number doubleValue];
    return myDouble == (int) myDouble;
}

-(NSDecimalNumber*) factorial: (NSDecimalNumber*) number
{
    NSDecimalNumber *result = [NSDecimalNumber one]; //initializing result to 1.
    
    if ([self isInteger:number]) {//If number is Integer
        for (int i = [number intValue]; i > 0; i--){
            //result *= i;
            result = [result decimalNumberByMultiplyingBy:
                      [NSDecimalNumber decimalNumberWithString:
                        [NSString stringWithFormat:@"%i",i]]];
        }
    }
    else{ //If number is decimal
        result = [NSDecimalNumber decimalNumberWithString:
                  [NSString stringWithFormat:
                   @"%.16g", exp(lgamma([number doubleValue] + 1))]];
    }
    return result;
}

-(NSDecimalNumber*) SqrRoot: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:
              [NSString stringWithFormat:
               @"%.16g", sqrt([number doubleValue])]];
    
    return number;
}

-(NSDecimalNumber*) percent: (NSDecimalNumber*) number
{
    number = [number decimalNumberByDividingBy:
                [NSDecimalNumber decimalNumberWithString:
                    [NSString stringWithFormat:@"%i", 100]]];
    return number;
}

-(NSDecimalNumber*) sinOp: (NSDecimalNumber*) number: (BOOL) deg
{
    // Traditional computational result. Same as on mac and iOS calculators.
    double init = [number doubleValue];
    if (deg) {//Degrees Calculation
        init = init * M_PI / 180;
    }
    number = [NSDecimalNumber decimalNumberWithString:
                  [NSString stringWithFormat:
                   @"%.15f", sin(init)]];
    return number;
}
-(NSDecimalNumber*) cosOp: (NSDecimalNumber*) number: (BOOL) deg
{
    double init = [number doubleValue];
    if (deg) {//Degrees Calculation
        init = init * M_PI / 180;
    }
    number = [NSDecimalNumber decimalNumberWithString:
                  [NSString stringWithFormat:
                   @"%.15f", cos(init)]];
    return number;
}

-(NSDecimalNumber*) tanOp: (NSDecimalNumber*) number: (BOOL) deg
{
    double init = [number doubleValue];
    if (deg) {//Degrees Calculation
        init = init * M_PI / 180;
    }
    number = [NSDecimalNumber decimalNumberWithString:
                  [NSString stringWithFormat:
                   @"%.15f", tan(init)]];
    return number;
}
-(NSDecimalNumber*) lnOp: (NSDecimalNumber*) number
{

    number = [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat:
                 @"%.16g", log([number doubleValue])]];
    return number;
}

-(NSDecimalNumber*) logOp: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat:
                 @"%.16g", log10([number doubleValue])]];
    return number;
}

-(NSDecimalNumber*) divX: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:  
                [NSString stringWithFormat:
                 @"%.16g", pow([number doubleValue], -1)]];
    return number;
}

-(NSDecimalNumber*) etox: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat:
                 @"%.16g", pow(M_E, [number doubleValue])]];
    return number;
}

-(NSDecimalNumber*) xSqr: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat:
                 @"%.16g", pow([number doubleValue], 2)]];
    return number;
}

-(NSDecimalNumber*) absOp: (NSDecimalNumber*) number
{
    number = [NSDecimalNumber decimalNumberWithString:
                [NSString stringWithFormat:
                 @"%.16g", fabs([number doubleValue])]];
    return number;
}
-(NSDecimalNumber*) pi
{
    return [NSDecimalNumber decimalNumberWithString:
            [NSString stringWithFormat:@"%.16g", M_PI]];
}
-(NSDecimalNumber*) epsilon
{
    return [NSDecimalNumber decimalNumberWithString:
            [NSString stringWithFormat:@"%.16g", M_E]];
}

// More precise results for trig functions.
/*
 //number = number * M_PI
 number = [number decimalNumberByMultiplyingBy:
 [NSDecimalNumber decimalNumberWithString:
 [NSString stringWithFormat:@"%f", M_PI]]];
 //number = number / 180
 number = [number decimalNumberByDividingBy:
 [NSDecimalNumber decimalNumberWithString:
 [NSString stringWithFormat:@"%i", 180]]];
 //sin(number);
 number = [NSDecimalNumber decimalNumberWithString:
 [NSString stringWithFormat:@"%.16g", sin([number doubleValue])]];
 */


@end
