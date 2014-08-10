//
//  TestItemViewController.m
//  InteractiveTestKit
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "TestItemViewController.h"

@implementation TestItemViewController
+ (NSString *)testTitle
{
	return	NSStringFromClass(self);
}
+ (NSString *)testSubtitle
{
	return	nil;
}
- (void)loadView
{
	[super loadView];
	
	[[self view] setBackgroundColor:[UIColor whiteColor]];
	[[self navigationItem] setTitle:[[self class] testTitle]];
	[self setAutomaticallyAdjustsScrollViewInsets:NO];
}
@end
