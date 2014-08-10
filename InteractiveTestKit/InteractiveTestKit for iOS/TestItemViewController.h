//
//  TestItemViewController.h
//  InteractiveTestKit
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol	TestInformation
- (NSString*)testTitle;
- (NSString*)testSubtitle;
@end

@interface	TestItemViewController : UIViewController
+ (NSString*)testTitle;
+ (NSString*)testSubtitle;
@end
