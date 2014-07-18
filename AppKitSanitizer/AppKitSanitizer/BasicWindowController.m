//
//  BasicWindowController.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicWindowController.h"
#import "BasicDocument.h"



@interface BasicWindowController ()
@end




@implementation BasicWindowController
#if EONIL_DEBUG_MODE
{
	BOOL	_first_init_done;
}
- (id)init
{
	UNIVERSE_DELETED_METHOD();
}
- (id)initWithWindow:(BasicWindow *)window
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicWindow);
	UNIVERSE_DEBUG_ASSERT(_first_init_done == NO);
	
	self	=	[super initWithWindow:window];
	if (self)
	{
		_first_init_done	=	YES;
	}
	return	self;
}
#endif
+ (instancetype)instantiation
{
	return	[self instantiationWithWindow:[BasicWindow instantiation]];
}
+ (instancetype)instantiationWithWindow:(BasicWindow *)window
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicWindow);
	
	////
	
	return	[[super alloc] initWithWindow:window];
//	NSWindowController*	c1	=	[super alloc];
//	return	(id)[c1 initWithWindow:window];
}
#if EONIL_DEBUG_MODE
- (void)windowDidLoad
{
	UNIVERSE_DELETED_METHOD();
}
- (id)initWithWindowNibName:(NSString *)windowNibName
{
	UNIVERSE_DELETED_METHOD();
}
- (id)initWithWindowNibName:(NSString *)windowNibName owner:(id)owner
{
	UNIVERSE_DELETED_METHOD();
}
- (id)initWithWindowNibPath:(NSString *)windowNibPath owner:(id)owner
{
	UNIVERSE_DELETED_METHOD();
}
- (BasicWindow *)window
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL([super window], BasicWindow);
	
	////
	
	return	(id)[super window];
}
- (void)setWindow:(BasicWindow *)window
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(window, BasicWindow);
	
	////
	
	[super setWindow:window];
}
- (id)document
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL([super document], BasicDocument);
	
	////
	
	return	[super document];
}
- (void)setDocument:(id)document
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE_OR_NIL([super document], BasicDocument);
	
	////
	
	[super setDocument:document];
}
#endif
@end


















