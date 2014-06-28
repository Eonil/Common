//
//  BasicView.m
//  Spacetime
//
//  Created by Hoon H. on 14/5/26.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "BasicView.h"

@implementation BasicView
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (void)addConstraint:(NSLayoutConstraint *)constraint
{
	UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(constraint, NSLayoutConstraint);
	
	////
	
	[super addConstraint:constraint];
}
- (void)addConstraints:(NSArray *)constraints
{
	if (EONIL_APPKITSAN_USE_DEBUGGING_ASSERTIONS)
	{
		UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(constraints, NSArray);
		for (id a in constraints)
		{
			UNIVERSE_DEBUG_ASSERT_OBJECT_TYPE(a, NSLayoutConstraint);
		}
	}
	
	////
	
	[super addConstraints:constraints];
}
@end
