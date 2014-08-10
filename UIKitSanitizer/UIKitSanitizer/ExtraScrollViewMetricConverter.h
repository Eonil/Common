//
//  ExtraScrollViewMetricConverter.h
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface	ExtraScrollViewMetricConverter : NSObject
@property	(readwrite,nonatomic,weak)		UIScrollView*		scrollView;
@property	(readonly,nonatomic,assign)		CGSize				visiblePortionSizeInBounds;
@property	(readonly,nonatomic,assign)		CGSize				invisiblePortionSizeInBounds;
@property	(readwrite,nonatomic,assign)	CGSize				displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline;
@property	(readwrite,nonatomic,assign)	CGSize				displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline;
@end
