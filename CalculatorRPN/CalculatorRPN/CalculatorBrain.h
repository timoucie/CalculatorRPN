//
//  CalculatorBrain.h
//  CalculatorRPN
//
//  Created by BLIGNY Timothée on 10/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;
- (void)clearArray;

@end
