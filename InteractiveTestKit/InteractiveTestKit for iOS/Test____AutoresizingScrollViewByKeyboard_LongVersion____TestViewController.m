//
//  ScrollViewAutomaticResizingByKeyboardTestViewController.m
//  InteractiveTestKit
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "Test____AutoresizingScrollViewByKeyboard_LongVersion____TestViewController.h"

@implementation Test____AutoresizingScrollViewByKeyboard_LongVersion____TestViewController
{
	UIScrollView*	_scrv;
	UITextField*	_txtv1;
	UITextField*	_txtv2;
	
	ExtraScrollViewResizingByKeyboardPresentationControllerV2*	_resizer;
}

- (void)userDidTapOnView:(id)sender
{
	[_txtv1 resignFirstResponder];
	[_txtv2 resignFirstResponder];
}
- (void)userDidTapShortizeButton:(id)sender
{
	[_scrv setContentSize:CGSizeMake(0, 200)];
	[_txtv2 setFrame:CGRectMake(100, 200-44, 200, 44)];
	[[self navigationItem] setRightBarButtonItem:nil];
}





+ (NSString *)testTitle
{
	return	@"Autoresizing UIScrollView by Keyboard";
}
+ (NSString *)testSubtitle
{
	return	@"A scroll-view which resizes itself by keyboard presentation.";
}
- (void)loadView
{
	[super loadView];
	
	[[self view] addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userDidTapOnView:)]];
	[[self view] setBackgroundColor:[UIColor grayColor]];
	
	[[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Make Scroll Short" style:(UIBarButtonItemStylePlain) target:self action:@selector(userDidTapShortizeButton:)]];
	
	_scrv	=	[UIScrollView instantiation];
	[_scrv setBounds:CGRectMake(0, 0, 300, 300)];
	[_scrv setCenter:[[self view] center]];
	[_scrv setContentSize:CGSizeMake(0, 1000)];
	[_scrv setBackgroundColor:[UIColor whiteColor]];
	[[self view] addSubview:_scrv];
	
	for (int i=0; i<10; i++)
	{
		UIView*	v1	=	[UIView instantiation];
		[v1 setFrame:CGRectMake(0, i * 100, 100, 100)];
		[v1 setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:i/10.0]];
		[_scrv addSubview:v1];
	}
	
	_txtv1	=	[UITextField instantiation];
	[_txtv1 setFrame:CGRectMake(100, 0, 200, 44)];
	[_txtv1 setBackgroundColor:[UIColor blackColor]];
	[_txtv1 setTextColor:[UIColor whiteColor]];
	[_scrv addSubview:_txtv1];
	
	_txtv2	=	[UITextField instantiation];
	[_txtv2 setFrame:CGRectMake(100, 1000-44, 200, 44)];
	[_txtv2 setBackgroundColor:[UIColor blackColor]];
	[_txtv2 setTextColor:[UIColor whiteColor]];
	[_scrv addSubview:_txtv2];
	
	_resizer	=	[ExtraScrollViewResizingByKeyboardPresentationControllerV2 instantiation];
	[_resizer setTargetScrollView:_scrv];
}
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
//	[_resizer startKeyboardAppearanceTracking];
}
- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
//	[_resizer stopKeyboardAppearanceTracking];
}
@end
