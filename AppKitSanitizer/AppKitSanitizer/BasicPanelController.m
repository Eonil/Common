//
//  BaiscPanelController.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicPanelController.h"

@interface BasicPanelController ()
@end










@implementation BasicPanelController
#if EONIL_DEBUG_MODE
{
	BOOL	_first_init_done;
}
- (id)init
{
	UNIVERSE_DELETED_METHOD();
}
- (id)initWithWindow:(BasicPanel *)window
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicPanel);
	}
	
	////
	
	UNIVERSE_DEBUG_ASSERT(_first_init_done == NO);
	
	self	=	[super initWithWindow:window];
	if (self)
	{
		_first_init_done	=	YES;
	}
	return	self;
}
#endif
#if EONIL_DEBUG_MODE
- (BasicPanel *)window
{
	return	(id)[super window];
}
- (void)setWindow:(BasicPanel *)window
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{		
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicPanel);
	}
	
	////
	
	[super setWindow:window];
}
#endif
+ (instancetype)instantiation
{
	return	[self instantiationWithWindow:[BasicPanel instantiation]];
}
+ (instancetype)instantiationWithWindow:(BasicPanel *)window
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicPanel);
	
	return	[[self alloc] initWithWindow:window];
}
@end













