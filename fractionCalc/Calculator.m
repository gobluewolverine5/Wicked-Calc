//
//  Calculator.m
//  Wicked Calc
//
//  Created by Evan Hsu on 3/3/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import "Calculator.h"
#import "addFunc.h"

@implementation Calculator
{
    char op, prevOp;
    double decimal;
    BOOL firstOperand, isNumerator, operated, resultCalc, first, second;
    BOOL resultOrCurrent; //yes if result, no if current
    BOOL dot, specialNum;
    BOOL opPressed;//used to determine whether consecutive operator buttons have been pressed
    BOOL addOpPressed;
    BOOL invalid;
    addFunc *additionalFunc;
    NSMutableString *displayString;
}

-(id) init
{
    /*Variable Declaration*/
    operated = NO;
    resultCalc = NO;
    first = YES;
    second = YES;
    resultOrCurrent = NO;
    decimal = 0.1;
    dot = NO;
    specialNum = NO;
    opPressed = NO;
    addOpPressed = NO;
    invalid = FALSE;
    displayString = [NSMutableString stringWithCapacity: 40];
    result = [NSDecimalNumber zero];
    currentNumber = [NSDecimalNumber zero];
    
    /*Additional Func Declaration*/
    additionalFunc = [[addFunc alloc] init];
    
    return self;
}

/*~~~~~~~~~~~~~~~~~~~Return Numbers~~~~~~~~~~~~~~~~~*/

-(NSDecimalNumber*) returnResult
{
    return result;
}

-(NSDecimalNumber*) returnCurrent
{
    return currentNumber;
}

-(NSMutableString*) returnDisplayString
{
    return displayString;
}

-(BOOL) returnInvalid
{
    return invalid;
}

/*~~~~~~~~~~~~~~~~~~~Calculation Processing~~~~~~~~~~~~~~~~~*/

-(void) printResult
{
    NSLog(@"result function: %@", result);
}
-(NSMutableString*) processDigit:(int) digit
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

    resultOrCurrent = NO;
    return displayString;
}

-(BOOL) processOp: (char) theOp
{
    BOOL updateDisplay = TRUE;
    prevOp = op;
    op = theOp;
    updateDisplay = [self calculate:prevOp];
    currentNumber = [NSDecimalNumber zero];
    operated = YES;
    [displayString setString:@""];
    return updateDisplay;
}

-(BOOL) calculate:(char)theOp
{
    BOOL tempBool = FALSE;
    invalid = FALSE;
    if (first == NO) {
        NSLog(@"result: %@, currentNumber: %@", result, currentNumber);
        switch (theOp) {
            case '+':
                //result = result + currentNumber;
                if (YES) {
                    double resultDBLadd = [result doubleValue];
                    double currentDBLadd = [currentNumber doubleValue];
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.10g", (resultDBLadd + currentDBLadd)]];
                    }
                    else{
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.14g", (resultDBLadd + currentDBLadd)]];
                    }
                    //result = [result decimalNumberByAdding:currentNumber];
                }
                break;
            case '-':
                //result = result - currentNumber;
                if (YES){
                    double resultDBLmin = [result doubleValue];
                    double currentDBLmin = [currentNumber doubleValue];
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {//Display for iPhone
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.10g", (resultDBLmin - currentDBLmin)]];
                    }
                    else { //Display for iPad
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.14g", (resultDBLmin - currentDBLmin)]];
                    }
                
                }
                break;
            case '*':
                if (resultCalc == NO) {
                    //result = result * currentNumber;
                    double resultDBLmult = [result doubleValue];
                    double currentDBLmult = [currentNumber doubleValue];
                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {//Display for iPhone
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.10g", (resultDBLmult * currentDBLmult)]];
                    }
                    else {//Display for iPad
                        result = [NSDecimalNumber decimalNumberWithString:
                                  [NSString stringWithFormat:@"%.14g", (resultDBLmult * currentDBLmult)]];
                    }
                }
                break;
            case '/':
                if (resultCalc == NO){
                    //result = result / currentNumber;
                    if ([currentNumber compare:[NSDecimalNumber zero]] != NSOrderedSame) {
                        double resultDBLdiv = [result doubleValue];
                        double currentDBLdiv = [currentNumber doubleValue];
                        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {//Display for iPhone
                            result = [NSDecimalNumber decimalNumberWithString:
                                      [NSString stringWithFormat:@"%.10g", (resultDBLdiv / currentDBLdiv)]];
                        }
                        else {
                            result = [NSDecimalNumber decimalNumberWithString:
                                      [NSString stringWithFormat:@"%.14g", (resultDBLdiv / currentDBLdiv)]];
                        }
                    
                    }
                    else{
                        invalid = TRUE;
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
            //[self invalidOp:invalid];
        }
        else{
            //[self displayResult];
            tempBool = TRUE;
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
    return tempBool;
}

-(void) reset
{
    result = [NSDecimalNumber zero];
    currentNumber = [NSDecimalNumber zero];
    first = YES;
    opPressed = NO;
    [displayString setString:@""];
}

/*~~~~~~~~~~~~~~~~Digit buttons~~~~~~~~~~~~~~~~~~~*/

-(void) clickDigit
{
    if (resultCalc == YES || addOpPressed == YES) {
        NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
        addOpPressed = NO;
    }
    opPressed = NO;
}

/*~~~~~~~~~~~~~~~Arithmetic Keys~~~~~~~~~~~~~~~~~~*/

-(BOOL) operand
{
    if (!opPressed) {
        opPressed = YES;
        addOpPressed = NO;
        return TRUE;
    }
    return FALSE;
}

/*~~~~~~~~~~~~~~~~~~Misc Keys~~~~~~~~~~~~~~~~~~~~~*/

-(void) clear
{
    [self reset];
    resultOrCurrent = YES;
}

-(BOOL) equals
{
    NSLog(@"Equals state");
    BOOL tempBool;
    if (operated == NO){
        resultOrCurrent = NO;
        tempBool = TRUE;
    }
    else{
        [self calculate:op];
        tempBool = FALSE;
    }
    resultCalc = YES;
    currentNumber = [NSDecimalNumber zero];
    return tempBool;
}

-(BOOL) sign
{
    if (resultOrCurrent == YES) {
        //result = -(result);
        result = [result decimalNumberByMultiplyingBy:
                  [NSDecimalNumber decimalNumberWithString:
                   [NSString stringWithFormat:@"-1"]]];
        return TRUE;
    }
    else{
        currentNumber = [currentNumber decimalNumberByMultiplyingBy:
                         [NSDecimalNumber decimalNumberWithString:
                          [NSString stringWithFormat:@"-1"]]];
        return FALSE;
    }
}

-(void) dot
{
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
    
    //Sets dot as pressed.
    dot = YES;
    
}

-(BOOL) del
{
    if (resultCalc == NO){
        currentNumber = [NSDecimalNumber zero];
        resultOrCurrent = NO;
        [displayString setString:@""];
        return TRUE;
    }
    return FALSE;
}

/*~~~~~~~~~~~~~Aditional Arithmetic~~~~~~~~~~~~~~~~*/

-(BOOL) addOps: (int)operation segment:(int)RadDeg
{
    BOOL tempBool;
    if (resultOrCurrent == YES) {
        switch (operation) {
            case 1:
                result = [additionalFunc percent:result];
                break;
            case 2:
                result = [additionalFunc sinOp:result seg:RadDeg==0?TRUE:FALSE];
                break;
            case 3:
                result = [additionalFunc cosOp:result seg:RadDeg==0?TRUE:FALSE];
                break;
            case 4:
                result = [additionalFunc tanOp:result seg:RadDeg==0?TRUE:FALSE];
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
        tempBool = TRUE;
    }
    else {
        switch (operation) {
            case 1:
                currentNumber = [additionalFunc percent:currentNumber];
                break;
            case 2:
                currentNumber = [additionalFunc sinOp:currentNumber seg:RadDeg==0?TRUE:FALSE];
                break;
            case 3:
                currentNumber = [additionalFunc cosOp:currentNumber seg:RadDeg==0?TRUE:FALSE];
                break;
            case 4:
                currentNumber = [additionalFunc tanOp:currentNumber seg:RadDeg==0?TRUE:FALSE];
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
        tempBool = FALSE;
    }
    decimal = 0.1;
    dot = NO;
    [displayString setString:@""];
    return tempBool;
}

-(NSComparisonResult) selfCompare: (NSDecimalNumber*) NSD mydouble: (double) selfDBL
{
    NSDecimalNumber *comparedInt = [NSDecimalNumber decimalNumberWithString:
                                    [NSString stringWithFormat:@"%.16g", selfDBL]];
    return [NSD compare:comparedInt];
}

-(BOOL) factorial
{
    invalid = FALSE;
    BOOL tempBool = FALSE;
    if (resultOrCurrent == YES) {
        //if result number is >= 0 and is an integer.
        if (([result compare:[NSDecimalNumber zero]] == NSOrderedDescending ||
             [result compare:[NSDecimalNumber zero]] == NSOrderedSame) &&
            [self selfCompare:result mydouble:104] == NSOrderedAscending) {
            
            result = [additionalFunc factorial:result];
            operated = NO;
            tempBool = TRUE;
            
        }
        //if result number is < 0 or is not an integer.
        else {invalid = TRUE; result = [NSDecimalNumber zero]; }
    }
    else{
        
        //if current number entered is >=0 and is an integer.
        if (([currentNumber compare:[NSDecimalNumber zero]] == NSOrderedDescending ||
             [currentNumber compare:[NSDecimalNumber zero]] == NSOrderedSame) &&
             [self selfCompare:currentNumber mydouble:104] == NSOrderedAscending){
            currentNumber = [additionalFunc factorial:currentNumber];
            operated = YES;
            addOpPressed = YES;
            tempBool = FALSE;
        }
        //if current number entere is < 0 or is not an integer.
        else {invalid = TRUE; currentNumber = [NSDecimalNumber zero]; }
    }
    decimal = 0.1;
    dot = NO;
    [displayString setString:@""];
    return tempBool;
}

-(BOOL) SqrRoot
{
    BOOL tempBool = FALSE;
    invalid = FALSE;
    if (resultOrCurrent == YES){
        if (result < 0) {invalid = TRUE; }
        else {
            result = [additionalFunc SqrRoot:result];
            operated = NO;
            tempBool =  TRUE;
        }
    }
    else{
        if (currentNumber < 0) {invalid = TRUE; }
        else {
            currentNumber = [additionalFunc SqrRoot:currentNumber];
            operated = YES;
            addOpPressed = YES;
            tempBool = FALSE;
        }
    }
    decimal = 0.1;
    dot = NO;
    return tempBool;
}
-(BOOL) ytoxButton
{
    if (!opPressed) {
        opPressed = YES;
        [self processOp:'^'];
        return TRUE;
    }
    return FALSE;
}
-(BOOL) piButton
{
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = [additionalFunc pi];
    if (first == YES){NSLog(@"first = yes");}
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
    return TRUE;
}
-(BOOL) epsilonButton
{
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = [additionalFunc epsilon];
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
    return TRUE;
}

-(void) resultHistoryPress: (NSDecimalNumber*) number
{
    specialNum = YES;
    if (resultCalc == YES) {
        //NSLog(@"Has been reset");
        [self reset];
        resultCalc = NO;
    }
    currentNumber = number;
    if (first == YES){NSLog(@"first = yes");}
    [displayString setString:@""];
    resultOrCurrent = NO;
    opPressed = NO;
    dot = NO;
}

@end
