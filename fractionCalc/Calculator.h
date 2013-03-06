//
//  Calculator.h
//  Wicked Calc
//
//  Created by Evan Hsu on 3/3/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject{
    NSDecimalNumber *result;
    NSDecimalNumber *currentNumber;
}

//Return Numbers
-(NSDecimalNumber*) returnResult;
-(NSDecimalNumber*) returnCurrent;
-(NSMutableString*) returnDisplayString;
-(BOOL) returnInvalid;

//Calculation Processing
-(void) printResult;
-(NSMutableString*) processDigit: (int) digit;
-(BOOL) processOp: (char) theOp;
-(BOOL) calculate: (char) theOp;
-(void) reset;

//Digit buttons
-(void) clickDigit;

//Arithmetic Keys
-(BOOL) operand;

//Misc. Keys
-(void) clear;
-(BOOL) equals;
-(BOOL) sign;
-(void) dot;
-(BOOL) del;


//Additional Arithmetic
-(BOOL) addOps: (int)operation segment:(int) RadDeg;
-(void) invalidOp:(BOOL) invalid;
-(BOOL) factorial;
-(BOOL) SqrRoot;
-(BOOL) ytoxButton;
-(BOOL) piButton;
-(BOOL) epsilonButton;
-(void) resultHistoryPress: (NSDecimalNumber*) number;

@end
