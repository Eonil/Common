//
//  Tests___FoundationExtras___iOS___Static_Library.m
//  Tests - FoundationExtras - iOS - Static Library
//
//  Created by Hoon H. on 8/26/14.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <FoundationExtras/FoundationExtras.h>






@interface Test_Universe_Macros : XCTestCase
@end






@implementation Test_Universe_Macros

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMacro1
{
	if (EONIL_DEBUG_MODE)
	{
		
	}
	else
	{
		XCTFail("This test must be performed in DEBUG mode.");
	}
	
	////
		
	BOOL	f1	=	NO;
	
	@try
	{
		UNIVERSE_DEBUG_ASSERT(NO);
	}
	@catch (NSException* exc)
	{
		f1	=	YES;
	}
	
	XCTAssert(f1);
}
- (void)testMacro2
{
	BOOL	f1	=	YES;
	@try
	{
		NSObject*	c1	=	[NSObject new];
		UNIVERSE_DEBUG_ASSERT_PROTOCOL_CONFORMANCE(c1, NSObject);
	}
	@catch (NSException* exc)
	{
		f1	=	NO;
	}
	
	XCTAssert(f1);
}
- (void)testMacro3
{
	BOOL	f1	=	NO;
	@try
	{
		NSObject*	c1	=	[NSObject new];
		UNIVERSE_DEBUG_ASSERT_PROTOCOL_CONFORMANCE(c1, NSFileManagerDelegate);
	}
	@catch (NSException* exc)
	{
		f1	=	YES;
	}
	
	XCTAssert(f1);
}

@end
