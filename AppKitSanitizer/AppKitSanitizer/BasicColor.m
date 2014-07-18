////
////  BasicColor.m
////  Spacetime
////
////  Created by Hoon H. on 14/5/26.
////  Copyright (c) 2014 Eonil. All rights reserved.
////
//
//#import "BasicColor.h"
//
//@implementation BasicColor
//
//#if EONIL_DEBUG_MODE
//{
//	BOOL	_is_ready;
//	BOOL	_is_ctor;
//}
//- (id)init
//{
//	self	=	[super init];
//	if (self)
//	{
//		UNIVERSE_DEBUG_ASSERT((_is_ready == NO && _is_ctor == YES) || [[self class] isSubclassOfClass:[BasicColor class]] == NO);
//		_is_ready	=	YES;
//		_is_ctor	=	NO;
//	}
//	return	self;
//}
//+ (instancetype)instantiation
//{
//	BasicColor*	d1	=	[super alloc];
//	d1->_is_ctor	=	YES;
//	d1				=	[(id)d1 init];
//	return	d1;
//}
//#endif
//
//@end
