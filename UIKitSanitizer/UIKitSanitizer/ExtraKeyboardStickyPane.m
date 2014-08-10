//	//
////  ExtraKeyboardStickyPane.m
////  UIKitSanitizer
////
////  Created by Hoon H. on 14/8/11.
////  Copyright (c) 2014 Eonil. All rights reserved.
////
//
//#import "ExtraKeyboardStickyPane.h"
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
//
//
//
//@implementation ExtraKeyboardStickyPane
//{
//	ExtraKeyboardPresentationNotificationController*	_kbd_notice;
//}
//
//
//
//typedef
//struct
//{
//	CGRect	beginFrameInSelfViewBounds;
//	CGRect	endFrameInSelfViewBounds;
//}
//KeyboardFrames;
//
//static CGFloat
//displacement__min_y_begin_to_end(CGRect begin, CGRect end)
//{
//	return	CGRectGetMinY(end) - CGRectGetMinY(begin);
//}
//
//- (CGRect)ExtraKeyboardStickyPane____screen_to_local:(CGRect)f1
//{
//	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE([self superview], UIView);
//	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE([self window], UIWindow);
//	
//	CGRect	f2	=	[[self window] convertRect:f1 fromWindow:nil];
//	CGRect	f3	=	[[self superview] convertRect:f2 fromView:nil];
//	return	f3;
//}
//- (KeyboardFrames)ExtraKeyboardStickyPane____keyboard_frames_from_parameters:(ExtraKeyboardPresentationParameters)parameters
//{
//	KeyboardFrames	fs1;
//	fs1.beginFrameInSelfViewBounds	=	[self ExtraKeyboardStickyPane____screen_to_local:parameters.beginFrameInScreenSpace];
//	fs1.endFrameInSelfViewBounds	=	[self ExtraKeyboardStickyPane____screen_to_local:parameters.endFrameInScreenSpace];
//	
//	return	fs1;
//}
//- (CGFloat)ExtraKeyboardStickyPane____displacement1_with_params:(ExtraKeyboardPresentationParameters)parameters
//{
//	KeyboardFrames	fs1	=	[self ExtraKeyboardStickyPane____keyboard_frames_from_parameters:parameters];
//	CGFloat			d1	=	CGRectGetMinY(fs1.endFrameInSelfViewBounds) - CGRectGetMinY(fs1.beginFrameInSelfViewBounds);
//	return			d1;
//}
//
//
//
//
//
//- (id)initWithFrame:(CGRect)frame
//{
//    self	=	[super initWithFrame:frame];
//    if (self)
//	{
//		_kbd_notice	=	[ExtraKeyboardPresentationNotificationController instantiation];
//		[_kbd_notice setDelegate:self];
//    }
//    return self;
//}
//- (void)layoutSubviews
//{
//	[super layoutSubviews];
//}
//
//- (void)notifyKeyboardWillShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
//{
//	NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//- (void)notifyKeyboardDidShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
//{
//	NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//- (void)notifyKeyboardWillHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
//{
//	NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//- (void)notifyKeyboardDidHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
//{
//	NSLog(@"%@", NSStringFromSelector(_cmd));
//}
//
//@end
