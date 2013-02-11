//
//  addFunc.h
//  Custom Calc
//
//  Created by Evan Hsu on 1/3/13.
//  Copyright (c) 2013 Evan Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface addFunc : NSObject

-(BOOL) isInteger: (NSDecimalNumber*) number;
-(NSDecimalNumber *) factorial: (NSDecimalNumber*) number;
-(NSDecimalNumber*) SqrRoot: (NSDecimalNumber*) number;
-(NSDecimalNumber*) percent: (NSDecimalNumber*) number;
-(NSDecimalNumber*) sinOp: (NSDecimalNumber*) number: (BOOL) deg;
-(NSDecimalNumber*) cosOp: (NSDecimalNumber*) number: (BOOL) deg;
-(NSDecimalNumber*) tanOp: (NSDecimalNumber*) number: (BOOL) deg;
-(NSDecimalNumber*) lnOp: (NSDecimalNumber*) number;
-(NSDecimalNumber*) logOp: (NSDecimalNumber*) number;
-(NSDecimalNumber*) divX: (NSDecimalNumber*) number;
-(NSDecimalNumber*) etox: (NSDecimalNumber*) number;
-(NSDecimalNumber*) xSqr: (NSDecimalNumber*) number;
-(NSDecimalNumber*) absOp: (NSDecimalNumber*) number;
-(NSDecimalNumber*) pi;
-(NSDecimalNumber*) epsilon;

@end
