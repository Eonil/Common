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
- (CGSize)displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline
{
	CGPoint	p1	=	[_scrollView contentOffset];
	return	CGSizeMake(-p1.x, -p1.y);
}
- (void)setDisplacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline:(CGSize)displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline
{
	CGSize	p1	=	displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline;
	p1.width	=	-p1.width;
	p1.height	=	-p1.height;
	
	CGPoint	p2	=	CGPointMake(p1.width, p1.height);
	[_scrollView setContentOffset:p2];
}
- (CGSize)displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline
{
	CGSize	invisible_sz	=	[self invisiblePortionSizeInBounds];
	CGSize	disp			=	[self displacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline];
	CGSize	disp_at_bottom	=	CGSizeMake(disp.width + invisible_sz.width, disp.height + invisible_sz.height);
	
	return	disp_at_bottom;
}
- (void)setDisplacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline:(CGSize)displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline
{
	CGSize	invisible_sz	=	[self invisiblePortionSizeInBounds];
	CGSize	disp_at_bottom	=	displacementOfContentBottomRightBorderlineAtBoundsBottomRightBorderline;
	CGSize	disp			=	CGSizeMake(disp_at_bottom.width - invisible_sz.width, disp_at_bottom.height - invisible_sz.height);
	
	[self setDisplacementOfContentTopLeftBorderlineAtBoundsTopLeftBorderline:disp];
}
@end