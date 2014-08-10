//
//  ExtraViewResizingByKeyboardPresentationController.m
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//
//

#import "ExtraViewResizingByKeyboardPresentationController.h"
#import <FoundationExtras/FoundationExtras.h>






typedef
struct
{
	UIViewAnimationCurve	curveIdentifier;
	NSTimeInterval			duration;
	CGRect					beginFrameInScreenSpace;
	CGRect					endFrameInScreenSpace;
}
KeyboardAnimationLayoutParametersAnalysis;

/*!
 All coordinates are in target-view's superview space.
 Frame height can go negative if the keyboards fully covers the view area.
 */
typedef
struct
{
	BOOL					available;
	CGRect					keyboardBeginFrame;
	CGRect					keyboardEndFrame;
	CGRect					viewBeginFrame;
	CGRect					viewEndFrame;
	CGFloat					verticalDisplacement;
	
	KeyboardAnimationLayoutParametersAnalysis	keyboardParameters;
}
ViewAnimationParameters;

















static KeyboardAnimationLayoutParametersAnalysis
analyze_keyboard_notification(NSNotification* notification)
{
	UIViewAnimationCurve	c1	=	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	CGFloat		d1	=	[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	CGRect		f8	=	[[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];			//	rect in screen space.
	CGRect		f9	=	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];				//	rect in screen space.
	
	////
	
	KeyboardAnimationLayoutParametersAnalysis	a1;
	a1.curveIdentifier			=	c1;
	a1.duration					=	d1;
	a1.beginFrameInScreenSpace	=	f8;
	a1.endFrameInScreenSpace	=	f9;
	
	return	a1;
}

static CGRect
screen_to_superview_of(UIView* view, CGRect r1)
{
	CGRect	r2	=	[[view window] convertRect:r1 fromWindow:nil];
	CGRect	r3	=	[[view superview] convertRect:r2 fromView:[view window]];
	return	r3;
}

static ViewAnimationParameters
analyze_view_animation_parameters(KeyboardAnimationLayoutParametersAnalysis const keyboard_params, UIView* target_view)
{
	ViewAnimationParameters	ps1;
	ps1.available					=	YES;
	ps1.keyboardParameters			=	keyboard_params;
	ps1.keyboardBeginFrame			=	screen_to_superview_of(target_view, keyboard_params.beginFrameInScreenSpace);
	ps1.keyboardEndFrame			=	screen_to_superview_of(target_view, keyboard_params.endFrameInScreenSpace);
	ps1.verticalDisplacement		=	CGRectGetMinY(ps1.keyboardEndFrame) - CGRectGetMinY(ps1.keyboardBeginFrame);
	ps1.viewBeginFrame				=	[target_view frame];
	ps1.viewEndFrame				=	ps1.viewBeginFrame;
	ps1.viewEndFrame.size.height	+=	ps1.verticalDisplacement;
	
	return	ps1;
}







static ViewAnimationParameters
build_all_parameters(NSNotification* notification, UIView* target_view)
{
	KeyboardAnimationLayoutParametersAnalysis const	ka1	=	analyze_keyboard_notification(notification);
	ViewAnimationParameters const					va1	=	analyze_view_animation_parameters(ka1, target_view);
	return	va1;
}





















@interface	ExtraViewResizingByKeyboardPresentationController____params_box : NSObject
@property	(readonly,nonatomic,copy)		NSUUID*						ID;
@property	(readonly,nonatomic,assign)		ViewAnimationParameters		parameters;
@end
@implementation ExtraViewResizingByKeyboardPresentationController____params_box
+ (instancetype)instantiationWithKeyboardNotification:(NSNotification*)notification andTargetView:(UIView*)view
{
	NSUUID*	id1	=	[NSUUID UUID];
	
	/*!
	 Very unlikely, but UUID is still possibly duplicated.
	 */
	while ([[self allBoxes] objectForKey:id1] != nil)
	{
		id1	=	[NSUUID UUID];
	}
	
	////
	
	ExtraViewResizingByKeyboardPresentationController____params_box*	box1	=	[self instantiation];
	box1->_parameters	=	build_all_parameters(notification, view);
	box1->_ID			=	[id1 copy];
	
	[[self allBoxes] setObject:box1 forKey:id1];
	return	box1;
}
- (void)dealloc
{
	[[[self class] allBoxes] removeObjectForKey:_ID];
}
+ (NSMutableDictionary*)allBoxes
{
	UNIVERSE_DEBUG_ASSERT([[NSThread currentThread] isEqual:[NSThread mainThread]]);
	
	static NSMutableDictionary*	d1	=	nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		d1	=	[NSMutableDictionary instantiation];
	});
	return	d1;
}
@end

typedef ExtraViewResizingByKeyboardPresentationController____params_box	PBOX;










@implementation ExtraViewResizingByKeyboardPresentationController
{
	@private
	
	BOOL	_keyboard_is_showed_up_assertion_flag;
}






- (void)startKeyboardAppearanceTracking
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_trackingKeyboardAppearance == NO, @"You shouldn't call this while you're tracking.");
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraViewResizingByKeyboardPresentationController____on_keyboard_showup:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ExtraViewResizingByKeyboardPresentationController____on_keyboard_hidedown:) name:UIKeyboardWillHideNotification object:nil];
	
	_trackingKeyboardAppearance	=	YES;
}
- (void)stopKeyboardAppearanceTracking
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_trackingKeyboardAppearance == YES, @"You shouldn't call this while you're not tracking.");
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	_trackingKeyboardAppearance	=	NO;
}






- (id)init
{
	self	=	[super init];
	if (self)
	{
	}
	return	self;
}
- (void)dealloc
{
	if (_trackingKeyboardAppearance == YES)
	{
		[self stopKeyboardAppearanceTracking];
	}
}
- (void)ExtraViewResizingByKeyboardPresentationController____on_keyboard_showup:(NSNotification*)notification
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_keyboard_is_showed_up_assertion_flag == NO, @"You must setup this object when keyboard is hidden. Do not setup this object when keyboard is already appeared.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);
//	NSLog(@"KBD-SHOWUP = %@", notification);

	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardWillShowup:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardWillShowup:self];
	}

	////

	PBOX*							b1		=	[PBOX instantiationWithKeyboardNotification:notification andTargetView:_targetView];
	ViewAnimationParameters const	va1		=	[b1 parameters];

	////

    [UIView beginAnimations:[[b1 ID] UUIDString] context:NULL];
    [UIView setAnimationCurve:va1.keyboardParameters.curveIdentifier];
    [UIView setAnimationDuration:va1.keyboardParameters.duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(ExtraViewResizingByKeyboardPresentationController____showup_animation_will_start:context:)];
	[UIView setAnimationDidStopSelector:@selector(ExtraViewResizingByKeyboardPresentationController____showup_animation_did_stop:context:)];

	CGAffineTransform	t1	=	CGAffineTransformMakeTranslation(0, va1.verticalDisplacement);
	[_targetView setTransform:t1];

    [UIView commitAnimations];
}
- (void)ExtraViewResizingByKeyboardPresentationController____showup_animation_will_start:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);
}
- (void)ExtraViewResizingByKeyboardPresentationController____showup_animation_did_stop:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);
	
	NSUUID*	id1	=	[[NSUUID alloc] initWithUUIDString:animationID];
	PBOX*	b1	=	[[PBOX allBoxes] objectForKey:id1];
	ViewAnimationParameters const	va1	=	[b1 parameters];
	[[PBOX allBoxes] removeObjectForKey:id1];

	[_targetView setTransform:CGAffineTransformIdentity];			//	transform must be identity first to apply frame correctly.
	[_targetView setFrame:va1.viewEndFrame];

	////

	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardDidShowup:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardDidShowup:self];
	}

	_keyboard_is_showed_up_assertion_flag	=	YES;
}









- (void)ExtraViewResizingByKeyboardPresentationController____on_keyboard_hidedown:(NSNotification*)notification
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_keyboard_is_showed_up_assertion_flag == YES, @"You must setup this object when keyboard is hidden. Do not setup this object when keyboard is already appeared.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);
//	NSLog(@"KBD-HIDEDOWN = %@", notification);

	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardWillHidedown:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardWillHidedown:self];
	}

	////

	ViewAnimationParameters const	va1	=	build_all_parameters(notification, _targetView);

	////

	[_targetView setFrame:va1.viewEndFrame];

	CGAffineTransform	t1	=	CGAffineTransformMakeTranslation(0, -va1.verticalDisplacement);
	[_targetView setTransform:t1];

	////

    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:va1.keyboardParameters.curveIdentifier];
    [UIView setAnimationDuration:va1.keyboardParameters.duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(ExtraViewResizingByKeyboardPresentationController____hidedown_animation_will_start:context:)];
	[UIView setAnimationDidStopSelector:@selector(ExtraViewResizingByKeyboardPresentationController____hidedown_animation_did_stop:context:)];

	[_targetView setTransform:CGAffineTransformIdentity];

    [UIView commitAnimations];

	_keyboard_is_showed_up_assertion_flag	=	NO;
}
- (void)ExtraViewResizingByKeyboardPresentationController____hidedown_animation_will_start:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);

}
- (void)ExtraViewResizingByKeyboardPresentationController____hidedown_animation_did_stop:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetView, UIView);

	////

	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardDidHidedown:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardDidHidedown:self];
	}
}


@end
























