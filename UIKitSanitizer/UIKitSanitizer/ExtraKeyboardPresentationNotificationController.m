//
//  ExtraKeyboardPresentationNotificationController.m
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "ExtraKeyboardPresentationNotificationController.h"









static ExtraKeyboardPresentationParameters
analyze_keyboard_notification(NSNotification* notification)
{
	UIViewAnimationCurve	c1	=	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	CGFloat		d1	=	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	CGRect		f8	=	[[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];			//	rect in screen space.
	CGRect		f9	=	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];				//	rect in screen space.
	
	////
	
	ExtraKeyboardPresentationParameters	a1;
	a1.curveIdentifier			=	c1;
	a1.duration					=	d1;
	a1.beginFrameInScreenSpace	=	f8;
	a1.endFrameInScreenSpace	=	f9;
	
	return	a1;
}










//#define LOG_EVENT()		NSLog(@"%@, %@", NSStringFromSelector(_cmd), notification)
#define	LOG_EVENT()

@implementation ExtraKeyboardPresentationNotificationController

+ (void)performAnimationBlock:(void (^)(void))block withParameters:(ExtraKeyboardPresentationParameters)parameters
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:parameters.curveIdentifier];
    [UIView setAnimationDuration:parameters.duration];
	
	block();
	
    [UIView commitAnimations];
}

- (void)ExtraKeyboardPresentationNotificationController____will_show:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardWillShowWithParameters:analyze_keyboard_notification(notification)];
}
- (void)ExtraKeyboardPresentationNotificationController____did_show:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardDidShowWithParameters:analyze_keyboard_notification(notification)];
}
- (void)ExtraKeyboardPresentationNotificationController____will_hide:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardWillHideWithParameters:analyze_keyboard_notification(notification)];
}
- (void)ExtraKeyboardPresentationNotificationController____did_hide:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardDidHideWithParameters:analyze_keyboard_notification(notification)];
}
- (void)ExtraKeyboardPresentationNotificationController____will_change_frame:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardWillChangeFrameWithParameters:analyze_keyboard_notification(notification)];
}
- (void)ExtraKeyboardPresentationNotificationController____did_change_frame:(NSNotification*)notification
{
	LOG_EVENT();
	[[self delegate] notifyKeyboardDidChangeFrameWithParameters:analyze_keyboard_notification(notification)];
}

- (id)init
{
	self	=	[super init];
	if (self)
	{
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____will_show:) name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____did_show:) name:UIKeyboardDidShowNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____will_hide:) name:UIKeyboardWillHideNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____did_hide:) name:UIKeyboardDidHideNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____will_change_frame:) name:UIKeyboardWillChangeFrameNotification object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraKeyboardPresentationNotificationController____did_change_frame:) name:UIKeyboardDidChangeFrameNotification object:nil];
	}
	return	self;
}
- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end













