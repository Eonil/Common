//
//  BasicPanel.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicPanel.h"







@implementation BasicPanel
#if EONIL_DEBUG_MODE
{
	BOOL	_first_init_done;
}
- (id)init
{
	UNIVERSE_DEBUG_ASSERT(_first_init_done == NO);
	
	self	=	[super init];
	if (self)
	{
		_first_init_done	=	YES;
	}
	return	self;
}
#endif
#if EONIL_DEBUG_MODE
- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
	self	=	[super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:false];
	if (self)
	{
		[self setContentView:[BasicView instantiation]];
		if (! [[super contentView] isKindOfClass:[BasicView class]])
		{
			[super setContentView:[BasicView instantiation]];
		}
	}
	return	self;
}
- (BasicView *)contentView
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL([super contentView], BasicView);
	}

	////
	
	return	(id)[super contentView];
}
- (void)setContentView:(BasicView *)aView
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL(aView, BasicView);
	}
	
	////
	
	[super setContentView:aView];
}
#endif
@end
