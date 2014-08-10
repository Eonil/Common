//
//  TestMenuTableViewController.m
//  InteractiveTestKit
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "TestMenuTableViewController.h"
#import "TestItemViewController.h"
#import "Test____AutoresizingScrollViewByKeyboard_LongVersion____TestViewController.h"


//typedef UIViewController* (^ViewControllerGenerator)(void);
//
//@interface	TestMenuTableViewController____menuitem : BasicObject
//@property	(readwrite,nonatomic,copy)		NSString*					title;
//@property	(readwrite,nonatomic,copy)		NSString*					subtitle;
//@property	(readwrite,nonatomic,copy)		ViewControllerGenerator		testItemViewControllerGenerator;
//@end
//
//@implementation TestMenuTableViewController____menuitem
//@end
//
//#define MenuItem	TestMenuTableViewController____menuitem
//
//static MenuItem*
//make_menu_item(NSString* title, NSString* subtitle, ViewControllerGenerator testItemViewControllerGenerator)
//{
//	MenuItem*	m1	=	[MenuItem instantiation];
//	[m1 setTitle:title];
//	[m1 setSubtitle:subtitle];
//	[m1 setTestItemViewControllerGenerator:testItemViewControllerGenerator];
//	return	m1;
//}







static NSString* const	CRID	=	@"MENU-CELL";

@implementation TestMenuTableViewController
{
	NSArray*	_test_items;
}
- (void)loadView
{
	[super loadView];
	
	_test_items	=	@
	[
	 [Test____AutoresizingScrollViewByKeyboard_LongVersion____TestViewController class],
	];
	
	NSBundle *bundle = [NSBundle mainBundle];
    NSDictionary *info = [bundle infoDictionary];
    NSString *prodName = [info objectForKey:@"CFBundleDisplayName"];
	[[self navigationItem] setTitle:prodName];
	
	[[self tableView] setRowHeight:66];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return	1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return	[_test_items count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell*		c1	=	[tableView dequeueReusableCellWithIdentifier:CRID];
	if (c1 == nil)
	{
		c1	=	[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle) reuseIdentifier:CRID];
	}
	Class					c2	=	[_test_items objectAtIndex:[indexPath row]];
	id<TestInformation>		m1	=	(id)c2;
	[[c1 textLabel] setText:[m1 testTitle]];
	[[c1 textLabel] setMinimumScaleFactor:0.5];
	[[c1 textLabel] setAdjustsFontSizeToFitWidth:YES];
	[[c1 detailTextLabel] setText:[m1 testSubtitle]];
	[[c1 detailTextLabel] setNumberOfLines:2];
	return	c1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Class				c1	=	[_test_items objectAtIndex:[indexPath row]];
	UIViewController*	vc1	=	[c1 instantiation];
	
	[[self navigationController] pushViewController:vc1 animated:YES];
}
@end











