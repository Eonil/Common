//
//  ExtraScrollViewMetricConverter.m
//  UIKitSanitizer
//
//  Created by Hoon H. on 14/8/10.
//  Copyright (c) 2014 Eonil. All rights reserved.
//

#import "ExtraScrollViewMetricConverter.h"
#import <FoundationExtras/FoundationExtras.h>


@implementation ExtraScrollViewMetricConverter
- (CGSize)visiblePortionSizeInBounds
{
	CGRect	b1	=	[_scrollView bounds];
	return	b1.size;
}
- (CGSize)invisiblePortionSizeInBounds
{
	CGSize	s1				=	[_scrollView contentSize];
	CGSize	visible_sz		=	[self visiblePortionSizeInBounds];
	CGSize	invisible_sz	=	CGSizeMake(s1.width - visible_sz.width, s1.height - visible_sz.height);
	return	invisible_sz;
}
- (CGPoint)displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline
{
	CGPoint	p1	=	[_scrollView contentOffset];
	return	CGPointMake(-p1.x, -p1.y);
}
- (void)setDisplacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline:(CGPoint)displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline
{
	CGPoint	p1	=	displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline;
	p1.x		=	-p1.x;
	p1.y		=	-p1.y;
	[_scrollView setContentOffset:p1];
}
- (CGPoint)displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline
{
	CGSize	invisible_sz	=	[self invisiblePortionSizeInBounds];
	CGPoint	disp			=	[self displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
	CGPoint	disp_at_bottom	=	CGPointMake(disp.x + invisible_sz.width, disp.y + invisible_sz.height);
	
	return	disp_at_bottom;
}
- (void)setDisplacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline:(CGPoint)displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline
{
	CGSize	invisible_sz	=	[self invisiblePortionSizeInBounds];
	CGPoint	disp_at_bottom	=	displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline;
	CGPoint	disp			=	CGPointMake(disp_at_bottom.x - invisible_sz.width, disp_at_bottom.y - invisible_sz.height);
	
	[self setDisplacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline:disp];
}
@end