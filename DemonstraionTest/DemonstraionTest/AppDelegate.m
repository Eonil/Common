//
//  AppDelegate.m
//  DemonstraionTest
//
//  Created by Hoon H. on 2014/06/28.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "AppDelegate.h"
#import <FoundationExtras/FoundationExtras.h>
#import <AppKitSanitizer/AppKitSanitizer.h>



@interface		AAAVC : BasicViewController
@end
@implementation AAAVC
@end

@interface		BBBWC : BasicWindowController
@end
@implementation BBBWC
@end



@implementation AppDelegate
{
	AAAVC*		_aaa;
	BBBWC*		_bbb;
}
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	// Insert code here to initialize your application
	if (EONIL_DEBUG_MODE)
	{
		[[NSAlert alertWithMessageText:@"debug mode." defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@""] runModal];
	}
	else
	{
		[[NSAlert alertWithMessageText:@"release mode." defaultButton:@"OK" alternateButton:nil otherButton:nil informativeTextWithFormat:@""] runModal];
	}
	
	////
	
//	_aaa	=	[AAAVC instantiation];
	_bbb	=	[BBBWC instantiation];
	[_bbb.window orderFront:nil];
}

@end
