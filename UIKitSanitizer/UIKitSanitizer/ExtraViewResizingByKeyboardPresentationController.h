//
//  ExtraViewResizingByKeyboardPresentationController.h
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <FoundationExtras/FoundationExtras.h>

@class		ExtraViewResizingByKeyboardPresentationController;

UNIVERSE_DEPRECATED_CLASS
@protocol	ExtraViewResizingByKeyboardPresentationControllerDelegate <NSObject>
@optional
- (void)	resizingControllerIsNotifyingKeyboardWillShowup:(ExtraViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardDidShowup:(ExtraViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardWillHidedown:(ExtraViewResizingByKeyboardPresentationController*)resizer;
- (void)	resizingControllerIsNotifyingKeyboardDidHidedown:(ExtraViewResizingByKeyboardPresentationController*)resizer;
@end



/*!
 This class squeezes target-view's frame when keyboard appears, and
 expands it back to original frame when the keyboard disappears.
 
 Any frame change while keyboard is appeared will be ignored whent 
 the keyboard disappear.
 
 You need to call `startKeyboardAppearanceTracking` manually to start
 tracking.
 
 @note
 You must set the target-view to a correct @c UIView object before
 keyboard appears, and the keyboard must be hiddden.
 
 @deprecated
 @c UIView is not enough to do this thing. Do not use this class.
 */
UNIVERSE_DEPRECATED_CLASS
@interface	ExtraViewResizingByKeyboardPresentationController : NSObject
@property	(readwrite,nonatomic,weak)		id<ExtraViewResizingByKeyboardPresentationControllerDelegate>		delegate;
@property	(readonly,nonatomic,assign)		BOOL		trackingKeyboardAppearance;
@property	(readwrite,nonatomic,weak)		UIView*		targetView;
- (void)	startKeyboardAppearanceTracking;
- (void)	stopKeyboardAppearanceTracking;
@end

