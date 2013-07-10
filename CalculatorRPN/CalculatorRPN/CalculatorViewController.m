//
//  CalculatorViewController.m
//  CalculatorRPN
//
//  Created by BLIGNY Timothée on 10/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController
@synthesize display = _display;
@synthesize operationDisplay = _operationDisplay;
@synthesize brain = _brain;
@synthesize userIsInTheMiddleOfEnteringANumber = _userIsInTheMiddleOfEnteringANumber;

- (CalculatorBrain *)brain
{
	if (!_brain) _brain = [[CalculatorBrain alloc] init];
	return _brain;
		
}

- (IBAction)digitPressed:(UIButton *)sender 
{
	NSString *digit = [sender currentTitle];
	if (self.userIsInTheMiddleOfEnteringANumber && ![self.display.text isEqualToString:@"0"] && ![self.display.text isEqualToString:@"π"]) {
		self.display.text = [self.display.text stringByAppendingString:digit];
	} 
//	else if (self.userIsInTheMiddleOfEnteringANumber && ![self.display.text isEqualToString:@"0"] && [digit isEqualToString:@"π"]) {
//		self.display.text = [NSString stringWithFormat:@"%g",[self.display.text doubleValue]*3.14159265359];
//	}
	else 
	{
		self.display.text = digit;
		self.userIsInTheMiddleOfEnteringANumber = YES;
	}
	
}

- (IBAction)pointPressed:(id)sender 
{
		//self.userIsInTheMiddleOfEnteringANumber = YES;
	NSString *digit = [sender currentTitle];
	int i=0,j=0;
	do {
		if ([@"." isEqualToString:[NSString stringWithFormat:@"%c",[self.display.text characterAtIndex:i]]]) {
			j++;
		}
		i++;
	} while (i<[self.display.text length]);
	if (j<1) {
		self.display.text = [self.display.text stringByAppendingString:digit];
	}
	
}

- (IBAction)enterPressed 
{
	if (![@"π" isEqualToString:self.display.text]) {
		[self.brain pushOperand:[self.display.text doubleValue]];
		self.userIsInTheMiddleOfEnteringANumber = NO;
		if ([self.operationDisplay.text isEqualToString:@""]) {
			self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:self.display.text];
		} else {
			self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@",self.display.text]];
		}
	} else if ([@"π" isEqualToString:self.display.text]) {
		[self.brain pushOperand:3.14159265359];
		self.userIsInTheMiddleOfEnteringANumber = NO;
		if ([self.operationDisplay.text isEqualToString:@""]) {
			self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:self.display.text];
		} else {
			self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@",self.display.text]];
		}
	}
	
	
}

- (IBAction)operationPressed:(UIButton *)sender 
{
	if (self.userIsInTheMiddleOfEnteringANumber) {
		[self enterPressed];
	}
	NSString *operation = [sender currentTitle];
	double result = [self.brain performOperation:operation];
	if (![[sender currentTitle] isEqualToString:@"+ / -"]) {
		self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:[NSString stringWithFormat:@" %@",[sender currentTitle]]];
	}
	else if ([[sender currentTitle] isEqualToString:@"+ / -"])
	{
		self.operationDisplay.text = [self.operationDisplay.text stringByAppendingString:[NSString stringWithFormat:@" (-1) *"]];
	}
	self.display.text = [NSString stringWithFormat:@"%g",result];
}

- (IBAction)backspace:(id)sender 
{
	NSString *digit;
	if ([self.display.text length]>1) {
		digit = [self.display.text substringToIndex:[self.display.text length]-1];

	}
	else if ([self.display.text length]==1) {
		digit = @"0";
		
	}
	self.display.text = digit;
}



- (IBAction)clear 
{
	[self.brain clearArray];
	self.display.text = @"0";
	self.operationDisplay.text = @"";
}


- (void)viewDidUnload {
	[self setOperationDisplay:nil];
	[super viewDidUnload];
}
@end
