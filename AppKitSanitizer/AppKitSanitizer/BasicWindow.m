//
//  BasicWindow.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicWindow.h"

@implementation BasicWindow
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
- (BasicView *)contentView
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(self, BasicWindow);
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL([super contentView], NSView);
	}
	
	////
	
	return	[super contentView];
}
#endif
@end
