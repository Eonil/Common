//
//  BasicViewController.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicViewController.h"

@interface BasicViewController ()
@end



@implementation BasicViewController
#if EONIL_DEBUG_MODE
{
	BOOL	_first_init_done;
}
- (id)init
{
	UNIVERSE_DEBUG_ASSERT(_first_init_done == NO);
	
	self	=	[super initWithNibName:nil bundle:nil];
	if (self)
	{
		_first_init_done	=	YES;
	}
	return	self;
}
#endif
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	UNIVERSE_DELETED_METHOD();
}
@end
