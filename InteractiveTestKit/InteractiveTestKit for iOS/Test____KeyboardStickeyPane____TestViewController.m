////
////  Test____KeyboardStickeyPane____TestViewController.m
////  InteractiveTestKit
////
////  Created by Hoon H. on 14/8/11.
////  Copyright (c) 2014 Eonil. All rights reserved.
////
//
//#import "Test____KeyboardStickeyPane____TestViewController.h"
//
//
//
//
//
//
//
//
//
//
//
//@implementation Test____KeyboardStickeyPane____TestViewController
//{
//	@private
//	
//	ExtraKeyboardStickyPane*	_panev;
//	UITextField*				_txtv;
//}
//+ (NSString *)testTitle
//{
//	return	@"Keyboard Sticky Pane";
//}
//+ (NSString *)testSubtitle
//{
//	return	@"A pane view sticks to at the top of the keyboard.";
//}
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self	=	[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//	{
//    }
//    return self;
//}
//
//- (void)loadView
//{
//	[super setView:[UIView instantiation]];
//	
//	[[self view] setBackgroundColor:[UIColor whiteColor]];
//	
//	_panev	=	[ExtraKeyboardStickyPane instantiation];
//	[_panev setFrame:CGRectMake(10, 100, 300, 100)];
//	[_panev setBackgroundColor:[UIColor redColor]];
//	[[self view] addSubview:_panev];
//	
//	_txtv	=	[UITextField instantiation];
//	[_txtv setBorderStyle:(UITextBorderStyleRoundedRect)];
//	[_txtv setPlaceholder:@"Tap Here"];
//	[_txtv setFrame:CGRectMake(10 + 50, 44, 200, 44)];
//	[_panev addSubview:_txtv];
//}
//
//@end
