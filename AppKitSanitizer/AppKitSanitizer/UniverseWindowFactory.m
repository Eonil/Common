//
//  UniverseWindowFactory.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "UniverseWindowFactory.h"

@implementation UniverseWindowFactory
+ (BasicWindow *)typicalWindow
{
	NSUInteger	m1	=	NSTitledWindowMask
					|	NSClosableWindowMask
					|	NSMiniaturizableWindowMask
					|	NSResizableWindowMask
					;
				
//	NSTexturedBackgroundWindowMask
	
	BasicWindow*	w1	=	[[BasicWindow alloc] init];
	[w1 setStyleMask:m1];
	
	return	w1;
}
+ (BasicPanel *)typicalToolPanel
{
	NSUInteger	m1	=	NSTitledWindowMask
					|	NSClosableWindowMask
					|	NSMiniaturizableWindowMask
					|	NSResizableWindowMask
					|	NSUtilityWindowMask
					;
				
	BasicPanel*	w1	=	[BasicPanel instantiation];
	[w1 setStyleMask:m1];
	[w1 setFloatingPanel:YES];
	[w1 setRestorable:YES];
	return	w1;
}
+ (id)alloc
{
	UNIVERSE_DELETED_METHOD();
}
- (id)init
{
	UNIVERSE_DELETED_METHOD();
}
+ (instancetype)instantiation
{
	UNIVERSE_DELETED_METHOD();
}
@end
