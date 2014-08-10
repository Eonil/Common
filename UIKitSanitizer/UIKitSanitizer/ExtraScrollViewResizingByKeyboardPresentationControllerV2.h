//
//  ExtraScrollViewResizingByKeyboardPresentationControllerV2.h
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import "ExtraKeyboardPresentationNotificationController.h"





/*!
 This class squeezes target scroll-view's frame when keyboard appears, 
 and expands it back when the keyboard disappears.
 
 @classdesign
 This is about smooth and animated transition of target-view by animation
 of keyboard. For this target-view's content needs to adjusted precisely
 by resizing, and only scroll-view can be a proper target.
 
 So do not try to generalize this to target generic @c UIView . It doesn't 
 work due to lack of required conceptual features.
 
 @note
 You must set the target scroll-view to a correct @c UIScrollView object 
 while none of keyboard show/hide animation is performing.
 */
@interface	ExtraScrollViewResizingByKeyboardPresentationControllerV2 : NSObject <ExtraKeyboardPresentationNotificationControllerDelegate>
@property	(readwrite,nonatomic,weak)		UIScrollView*	targetScrollView;
@end

