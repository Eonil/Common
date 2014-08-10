//
//  ExtraScrollViewResizingByKeyboardPresentationController.h
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@class		ExtraScrollViewResizingByKeyboardPresentationController;


@protocol	ExtraScrollViewResizingByKeyboardPresentationControllerDelegate <NSObject>
@optional
- (void)	resizingControllerIsNotifyingKeyboardWillShowup:(ExtraScrollViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardDidShowup:(ExtraScrollViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardWillHidedown:(ExtraScrollViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardDidHidedown:(ExtraScrollViewResizingByKeyboardPresentationController*)resizer;
@end



/*!
 This class squeezes target-view's frame when keyboard appears, and
 expands it back to original frame when the keyboard disappears.
 
 Any frame change while keyboard is appeared will be ignored whent
 the keyboard disappear.
 
 You need to call `startKeyboardAppearanceTracking` manually to start
 tracking.
 
 @classdesign
 This is about smooth and animated transition of target-view by animation
 of keyboard. For this target-view's content needs to adjusted precisely 
 by resizing, and only scroll-view can be a proper target.
 
 So do not try to generalize this to generic @c UIView . It doesn't work
 due to lack of required features.
 
 @note
 You must set the target-view to a correct @c UIScrollView object before
 keyboard appears, and the keyboard must be hiddden.
 */
@interface	ExtraScrollViewResizingByKeyboardPresentationController : NSObject
@property	(readwrite,nonatomic,weak)		id<ExtraScrollViewResizingByKeyboardPresentationControllerDelegate>		delegate;
@property	(readonly,nonatomic,assign)		BOOL																	trackingKeyboardAppearance;
@property	(readwrite,nonatomic,weak)		UIScrollView*															targetScrollView;
- (void)	startKeyboardAppearanceTracking;
- (void)	stopKeyboardAppearanceTracking;
@end

