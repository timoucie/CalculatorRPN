//
//  CalculatorBrain.m
//  CalculatorRPN
//
//  Created by BLIGNY Timothée on 10/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (strong, nonatomic) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack
{
	if (!_operandStack) {
		_operandStack = [[NSMutableArray alloc] init]; 
	}
	return _operandStack;
}

- (void)clearArray
{
	[self.operandStack removeAllObjects];
}

- (void)pushOperand:(double)operand
{
	NSNumber *operandObject = [NSNumber numberWithDouble:operand];
	[self.operandStack addObject:operandObject];
}

- (double)popOperand
{
	NSNumber *operandObject = [self.operandStack lastObject];
	if (operandObject) [self.operandStack removeLastObject];
	return [operandObject doubleValue];
}

- (double)performOperation:(NSString *)operation
{
	double result = 0;
	
	if ([operation isEqualToString:@"+"]) {
		result = [self popOperand] + [self popOperand];
	}
	else if ([@"*" isEqualToString:operation]) {
		result = [self popOperand] * [self popOperand];
	}
	else if ([operation isEqualToString:@"-"]) {
		double subtrahend = [self popOperand];
		result = [self popOperand] - subtrahend;
	}
	else if ([operation isEqualToString:@"/"]) {
		double divisor = [self popOperand];
		if (divisor) result = [self popOperand] / divisor;
	}
	else if ([@"+ / -" isEqualToString:operation]) {
		result = [self popOperand] * (-1.0);
	}
	else if ([@"sin" isEqualToString:operation]) {
		result = sin([self popOperand]);
	}	
	else if ([@"cos" isEqualToString:operation]) {
		result = cos([self popOperand]);
	}
	else if ([@"sqrt" isEqualToString:operation]) {
		result = sqrt([self popOperand]);
	}
	else if ([@"log" isEqualToString:operation]) {
		result = log([self popOperand]);
	}
	else if ([@"e" isEqualToString:operation]) {
		result = exp([self popOperand]);
	}
	
	[self pushOperand:result];
	
	return result;
}

@end
