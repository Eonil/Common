//
//  ExtraScrollViewResizingByKeyboardPresentationControllerV2.m
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "ExtraScrollViewResizingByKeyboardPresentationControllerV2.h"
#import <FoundationExtras/FoundationExtras.h>
#import "ExtraScrollViewMetricConverter.h"







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
	
	ExtraKeyboardPresentationParameters			keyboardParameters;
}
ViewAnimationParameters;








static CGRect
screen_to_superview_of(UIView* view, CGRect r1)
{
	CGRect	r2	=	[[view window] convertRect:r1 fromWindow:nil];
	CGRect	r3	=	[[view superview] convertRect:r2 fromView:[view window]];
	return	r3;
}

static ViewAnimationParameters
analyze_view_animation_parameters(ExtraKeyboardPresentationParameters const keyboard_params, UIView* target_view)
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






























@implementation ExtraScrollViewResizingByKeyboardPresentationControllerV2
{
@private
	
	ExtraScrollViewMetricConverter*						_conv;
	ExtraKeyboardPresentationNotificationController*	_kbd_notify;
	
	BOOL		_kbd_is_presenting;
	BOOL		_kbd_is_dismissing;

	/*
	 These variables are used only for keyboard-show-up context.
	 */
	
	CGSize		_last_displacement_at_top_left;
	CGSize		_last_displacement_at_bottom_right;
	BOOL		_last_collapse_at_top;
	
}



- (void)setTargetScrollView:(UIScrollView *)targetScrollView
{
	_targetScrollView	=	targetScrollView;
	[_conv setScrollView:_targetScrollView];
}



- (void)notifyKeyboardWillShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_presenting == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_dismissing == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
	////
	
	ViewAnimationParameters const	va1		=	analyze_view_animation_parameters(parameters, _targetScrollView);
	
	CGSize			top_left_disp			=	[_conv displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
	CGSize			bottom_right_disp		=	[_conv displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline];
	BOOL			content_clipped			=	[_targetScrollView contentSize].height > [_targetScrollView bounds].size.height;		//	is content-height larger than bounds.
	BOOL			collapse_at_top			=	content_clipped;
//	BOOL			collapse_at_top			=	top_left_disp.height >= 0;
	
	_last_displacement_at_top_left			=	top_left_disp;
	_last_displacement_at_bottom_right		=	bottom_right_disp;
	_last_collapse_at_top					=	collapse_at_top;
	
	////
	
	[ExtraKeyboardPresentationNotificationController performAnimationBlock:^{
		if (collapse_at_top)
		{
			CGAffineTransform	t1	=	CGAffineTransformMakeTranslation(0, va1.verticalDisplacement);
			[_targetScrollView setTransform:t1];
		}
		else
		{
			[_targetScrollView setFrame:va1.viewEndFrame];
		}
	} withParameters:parameters];
	
	_kbd_is_presenting	=	YES;
}
- (void)notifyKeyboardDidShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_presenting == YES, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_dismissing == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
	
	////
	
	if (_last_collapse_at_top)
	{
		[_targetScrollView setTransform:CGAffineTransformIdentity];			//	transform must be identity first to apply frame correctly.
		
		ViewAnimationParameters const	va1		=	analyze_view_animation_parameters(parameters, _targetScrollView);	//	must be evaluated after transform becomes identity.

		[_targetScrollView setFrame:va1.viewEndFrame];
		[_conv setDisplacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline:_last_displacement_at_bottom_right];
	}
	else
	{
	}
	
	////
	
	_kbd_is_presenting	=	NO;
}



- (void)notifyKeyboardWillHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_presenting == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_dismissing == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
	////
	
	ViewAnimationParameters const	va1		=	analyze_view_animation_parameters(parameters, _targetScrollView);
	
	CGRect			current_bounds			=	[_targetScrollView bounds];
	CGRect			future_bounds			=	[[_targetScrollView superview] convertRect:va1.viewEndFrame toView:_targetScrollView];
	
	CGSize			content_size			=	[_targetScrollView contentSize];
	
	CGSize			top_left_disp			=	[_conv displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
	CGSize			bottom_right_disp		=	[_conv displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline];
	BOOL			expands_at_top			=	(-top_left_disp.height + current_bounds.size.height) >= future_bounds.size.height;		//	expands top side of target scroll view.
	
	////
	
	if (expands_at_top)
	{
		[_targetScrollView setFrame:va1.viewEndFrame];
		
		if (content_size.height < future_bounds.size.height)
		{
			[_targetScrollView scrollsToTop];
		}
		else
		{
			[_conv setDisplacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline:bottom_right_disp];
		}
		
		CGAffineTransform	t1	=	CGAffineTransformMakeTranslation(0, -va1.verticalDisplacement);
		[_targetScrollView setTransform:t1];
	}
	else
	{
		CGSize	s1	=	[_conv displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
		[_targetScrollView setFrame:va1.viewEndFrame];
		[_conv setDisplacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline:s1];
	}
	
	////
	
	[ExtraKeyboardPresentationNotificationController performAnimationBlock:^{
		if (expands_at_top)
		{
			[_targetScrollView setTransform:CGAffineTransformIdentity];
		}
		else
		{
			[_targetScrollView setContentOffset:CGPointZero];		//	this is relying on assumption of the scrolling will be animated by curently set animation parameters. this is not guranteed and might be broken in future versions.
		}
		
	} withParameters:parameters];
	
	_kbd_is_dismissing	=	YES;
}
- (void)notifyKeyboardDidHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_presenting == NO, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_kbd_is_dismissing == YES, @"You shouldn't setup this object while keyboard show/hide animation is performing.");
	
	_kbd_is_dismissing	=	NO;
}
- (void)notifyKeyboardWillChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
}
- (void)notifyKeyboardDidChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
}




- (id)init
{
	self	=	[super init];
	if (self)
	{
		_kbd_notify	=	[ExtraKeyboardPresentationNotificationController instantiation];
		[_kbd_notify setDelegate:self];
		
		_conv	=	[ExtraScrollViewMetricConverter instantiation];
	}
	return	self;
}
- (void)dealloc
{
}


@end
















