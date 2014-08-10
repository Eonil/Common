//
//  ExtraScrollViewResizingByKeyboardPresentationController.m
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "ExtraScrollViewResizingByKeyboardPresentationController.h"
#import <FoundationExtras/FoundationExtras.h>
#import "ExtraScrollViewMetricConverter.h"






typedef	ExtraKeyboardPresentationParameters	KBD_ANIM_PARAMS;




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
	
	KBD_ANIM_PARAMS			keyboardParameters;
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
analyze_view_animation_parameters(KBD_ANIM_PARAMS const keyboard_params, UIView* target_view)
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
build_all_parameters(KBD_ANIM_PARAMS const keyboard_params, UIView* target_view)
{
	ViewAnimationParameters const					va1	=	analyze_view_animation_parameters(keyboard_params, target_view);
	return	va1;
}




















@interface	ExtraScrollViewResizingByKeyboardPresentationController____animation_context_informations : NSObject
@property	(readonly,nonatomic,copy)		NSUUID*						ID;
@property	(readonly,nonatomic,assign)		ViewAnimationParameters		parameters;
@property	(readwrite,nonatomic,assign)	BOOL						collapseTopSideOfTargetScrollView;
@property	(readwrite,nonatomic,assign)	CGSize						displacementAtTopLeft;
@property	(readwrite,nonatomic,assign)	CGSize						displacementAtBottomRight;
@end
@implementation ExtraScrollViewResizingByKeyboardPresentationController____animation_context_informations
+ (instancetype)instantiationWithKeyboardNotification:(KBD_ANIM_PARAMS)ka1 andTargetView:(UIView*)view
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
	
	ExtraScrollViewResizingByKeyboardPresentationController____animation_context_informations*	box1	=	[self instantiation];
	box1->_parameters	=	build_all_parameters(ka1, view);
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

//#define AnimationContextInformation	ExtraScrollViewResizingByKeyboardPresentationController____animation_context_informations;
typedef ExtraScrollViewResizingByKeyboardPresentationController____animation_context_informations	AnimationContextInformation;






















@implementation ExtraScrollViewResizingByKeyboardPresentationController
{
@private
	
	ExtraKeyboardPresentationNotificationController*	_kbd_notify;
	
	BOOL							_keyboard_is_shown_up_assertion_flag;
	ExtraScrollViewMetricConverter*	_conv;
}



- (void)setTargetScrollView:(UIScrollView *)targetScrollView
{
	_targetScrollView	=	targetScrollView;
	[_conv setScrollView:_targetScrollView];
}




- (void)startKeyboardAppearanceTracking
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_trackingKeyboardAppearance == NO, @"You shouldn't call this while you're tracking.");
	
	_trackingKeyboardAppearance	=	YES;
}
- (void)stopKeyboardAppearanceTracking
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_trackingKeyboardAppearance == YES, @"You shouldn't call this while you're not tracking.");
	
	_trackingKeyboardAppearance	=	NO;
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
	if (_trackingKeyboardAppearance == YES)
	{
		[self stopKeyboardAppearanceTracking];
	}
}




- (void)notifyKeyboardWillShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_keyboard_is_shown_up_assertion_flag == NO, @"You must setup this object when keyboard is hidden. Do not setup this object when keyboard is already appeared.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	//	NSLog(@"KBD-SHOWUP = %@", notification);
	
	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardWillShowup:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardWillShowup:self];
	}
	
	////
	
	CGSize			top_left_disp			=	[_conv displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
	CGSize			bottom_right_disp		=	[_conv displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline];
	BOOL			content_clipped			=	[_targetScrollView contentSize].height > [_targetScrollView bounds].size.height;		//	is content-height larger than bounds.
	BOOL			collapse_at_top			=	content_clipped;
	
//	BOOL			collapse_at_top			=	top_left_disp.height >= 0;
	
//	AnimationContextInformation*	b1		=	[AnimationContextInformation instantiationWithKeyboardNotification:notification andTargetView:_targetScrollView];
	AnimationContextInformation*	b1		=	[AnimationContextInformation instantiationWithKeyboardNotification:parameters andTargetView:_targetScrollView];
	ViewAnimationParameters const	va1		=	[b1 parameters];
	
	[b1 setDisplacementAtTopLeft:top_left_disp];
	[b1 setDisplacementAtBottomRight:bottom_right_disp];
	[b1 setCollapseTopSideOfTargetScrollView:collapse_at_top];
	
	////
	
    [UIView beginAnimations:[[b1 ID] UUIDString] context:NULL];
    [UIView setAnimationCurve:va1.keyboardParameters.curveIdentifier];
    [UIView setAnimationDuration:va1.keyboardParameters.duration];
	[UIView setAnimationWillStartSelector:@selector(ExtraScrollViewResizingByKeyboardPresentationController____showup_animation_will_start:context:)];
	[UIView setAnimationDidStopSelector:@selector(ExtraScrollViewResizingByKeyboardPresentationController____showup_animation_did_stop:context:)];
	[UIView setAnimationDelegate:self];
	
	if (collapse_at_top)
	{
		CGAffineTransform	t1	=	CGAffineTransformMakeTranslation(0, va1.verticalDisplacement);
		[_targetScrollView setTransform:t1];
	}
	else
	{
		[_targetScrollView setFrame:va1.viewEndFrame];
	}
	
    [UIView commitAnimations];
}
- (void)notifyKeyboardDidShowWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
}
- (void)notifyKeyboardWillHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
	UNIVERSE_DEBUG_ASSERT_WITH_MESSAGE(_keyboard_is_shown_up_assertion_flag == YES, @"You must setup this object when keyboard is shown. Do not setup this object when keyboard is already disappeared.");
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	//	NSLog(@"KBD-HIDEDOWN = %@", notification);
	
	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardWillHidedown:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardWillHidedown:self];
	}
	
	////
	
	ViewAnimationParameters const	va1		=	build_all_parameters(parameters, _targetScrollView);
	
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
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:va1.keyboardParameters.curveIdentifier];
    [UIView setAnimationDuration:va1.keyboardParameters.duration];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationWillStartSelector:@selector(ExtraScrollViewResizingByKeyboardPresentationController____hidedown_animation_will_start:context:)];
	[UIView setAnimationDidStopSelector:@selector(ExtraScrollViewResizingByKeyboardPresentationController____hidedown_animation_did_stop:context:)];
	
	
	if (expands_at_top)
	{
		[_targetScrollView setTransform:CGAffineTransformIdentity];
 	}
	else
	{
		[_targetScrollView setContentOffset:CGPointZero];		//	this is relying on assumption of the scrolling will be animated by curently set animation parameters. this is not guranteed and might be broken in future versions.
	}
	
    [UIView commitAnimations];
	
	_keyboard_is_shown_up_assertion_flag	=	NO;
}
- (void)notifyKeyboardDidHideWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
}
- (void)notifyKeyboardWillChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
}
- (void)notifyKeyboardDidChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters
{
	
}



- (void)ExtraScrollViewResizingByKeyboardPresentationController____showup_animation_will_start:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
}
- (void)ExtraScrollViewResizingByKeyboardPresentationController____showup_animation_did_stop:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
	NSUUID*	id1	=	[[NSUUID alloc] initWithUUIDString:animationID];
	AnimationContextInformation*	b1	=	[[AnimationContextInformation allBoxes] objectForKey:id1];
	ViewAnimationParameters const	va1	=	[b1 parameters];
	[[AnimationContextInformation allBoxes] removeObjectForKey:id1];
	
	////
	
	if ([b1 collapseTopSideOfTargetScrollView])
	{
		[_targetScrollView setTransform:CGAffineTransformIdentity];			//	transform must be identity first to apply frame correctly.
		[_targetScrollView setFrame:va1.viewEndFrame];
		[_conv setDisplacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline:[b1 displacementAtBottomRight]];
	}
	else
	{
	}
	
	////
	
	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardDidShowup:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardDidShowup:self];
	}
	
	_keyboard_is_shown_up_assertion_flag	=	YES;
}








- (void)ExtraScrollViewResizingByKeyboardPresentationController____hidedown_animation_will_start:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
}
- (void)ExtraScrollViewResizingByKeyboardPresentationController____hidedown_animation_did_stop:(NSString *)animationID context:(void*)context
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(_targetScrollView, UIView);
	
	////
	
	if ([[self delegate] respondsToSelector:@selector(resizingControllerIsNotifyingKeyboardDidHidedown:)])
	{
		[[self delegate] resizingControllerIsNotifyingKeyboardDidHidedown:self];
	}
}


@end
























