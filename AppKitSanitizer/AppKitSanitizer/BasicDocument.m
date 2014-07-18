//
//  BasicDocument.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicDocument.h"

@implementation BasicDocument
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
@end
