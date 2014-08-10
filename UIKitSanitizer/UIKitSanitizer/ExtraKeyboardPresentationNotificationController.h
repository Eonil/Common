//
//  ExtraKeyboardPresentationNotificationController.h
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <FoundationExtras/FoundationExtras.h>
#import <UIKit/UIKit.h>












typedef
struct
{
	UIViewAnimationCurve	curveIdentifier;
	NSTimeInterval			duration;
	CGRect					beginFrameInScreenSpace;
	CGRect					endFrameInScreenSpace;
}
ExtraKeyboardPresentationParameters;











@class		ExtraKeyboardPresentationNotificationController;

@protocol	ExtraKeyboardPresentationNotificationControllerDelegate <NSObject>
- (void)	notifyKeyboardWillShowWithParameters:(ExtraKeyboardPresentationParameters)parameters;
- (void)	notifyKeyboardDidShowWithParameters:(ExtraKeyboardPresentationParameters)parameters;
- (void)	notifyKeyboardWillHideWithParameters:(ExtraKeyboardPresentationParameters)parameters;
- (void)	notifyKeyboardDidHideWithParameters:(ExtraKeyboardPresentationParameters)parameters;
@optional
- (void)	notifyKeyboardWillChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters;
- (void)	notifyKeyboardDidChangeFrameWithParameters:(ExtraKeyboardPresentationParameters)parameters;
@end







/*!
 Simplified notification of keyboard presentation.
 */
@interface	ExtraKeyboardPresentationNotificationController : BasicObject
@property	(readwrite,nonatomic,assign)		id<ExtraKeyboardPresentationNotificationControllerDelegate>		delegate;
+ (void)	performAnimationBlock:(void(^)(void))block withParameters:(ExtraKeyboardPresentationParameters)parameters;			///<	Use parameters obtained from delegate methods of @c ExtraKeyboardPresentationNotificationControllerDelegate to perform equally styled animation with keyboard.
@end
