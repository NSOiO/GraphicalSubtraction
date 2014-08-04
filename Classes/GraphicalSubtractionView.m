//
//  GraphicalSubtractionView.m
//  GraphicalSubtraction
//
//  Created by Matt Gallagher on 2010/05/18.
//  Copyright 2010 Matt Gallagher. All rights reserved.
//

#import "GraphicalSubtractionView.h"


@implementation GraphicalSubtractionView

//
// Coordinates are:
//
// A-------------B     A(0,0), B(100,0), C(100,100), D(0,100)
// |      E      |     E(50,10), F(10,10), G(90,90)
// |     / \     |     H(50,90), I(50,100)
// |    /   \    |
// |   /     \   |
// |  F---H---G  |
// D------I------C
//

#define Ax	0
#define Ay	0
#define Bx	100
#define By	0
#define Cx	100
#define Cy	100
#define Dx	0
#define Dy	100
#define Ex	50
#define Ey	10
#define Fx	10
#define Fy	90
#define Gx	90
#define Gy	90
#define Hx	50
#define Hy	90
#define Ix	50
#define Iy	100

- (void)drawRect:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();

#define GRADIENT_BACKGROUND 1
#if GRADIENT_BACKGROUND
	CGContextDrawLinearGradient(
		context,
		[self backgroundGradient],
		CGPointMake(CGRectGetMinX(rect), CGRectGetMinY(rect)),
		CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect)),
		0);
#endif
	
	// Move to the first location
	CGContextTranslateCTM(context, 30, 30);

	// Technique 1: overpaint
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextSetRGBFillColor(context, 0.5, 0, 0, 1);
	CGContextFillPath(context);
	CGContextMoveToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextAddLineToPoint(context, Ex, Ey);
	CGContextSetRGBFillColor(context, 1, 1, 1, 1);
	CGContextFillPath(context);
	
	// Undo the first translation and move to the second location
	CGContextTranslateCTM(context, -30, -30);
	CGContextTranslateCTM(context, 190, 30);

	// Technique 2: false hole
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Ix, Iy);
	CGContextAddLineToPoint(context, Hx, Hy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextAddLineToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Hx, Hy);
	CGContextAddLineToPoint(context, Ix, Iy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextSetRGBFillColor(context, 0, 0.5, 0, 1);
	CGContextFillPath(context);

#define FALSE_HOLE_STROKE 1
#if FALSE_HOLE_STROKE
    // False hole stroke
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Ix, Iy);
	CGContextAddLineToPoint(context, Hx, Hy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextAddLineToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Hx, Hy);
	CGContextAddLineToPoint(context, Ix, Iy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
	CGContextStrokePath(context);
#endif

	// Undo the second translation and move to the third location
	CGContextTranslateCTM(context, -190, -30);
	CGContextTranslateCTM(context, 30, 180);

    // Technique 3: winding count fill rule
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextClosePath(context);
	CGContextMoveToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextClosePath(context);
	CGContextSetRGBFillColor(context, 0.5, 0.0, 0.75, 1);
	CGContextFillPath(context);

	// Undo the third translation and move to the fourth location
	CGContextTranslateCTM(context, -30, -180);
	CGContextTranslateCTM(context, 190, 180);

    // Technique 4: even-odd fill rule
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextClosePath(context);
	CGContextMoveToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextClosePath(context);
	CGContextSetRGBFillColor(context, 0.75, 0.5, 0, 1);
	CGContextEOFillPath(context);

	// Undo the fourth translation and move to the fifth location
	CGContextTranslateCTM(context, -190, -180);
	CGContextTranslateCTM(context, 30, 330);

    // Technique 5: remove the inner hole using a clipping region
	CGContextSaveGState(context);
	CGContextAddRect(context, CGContextGetClipBoundingBox(context));
	CGContextMoveToPoint(context, Ex, Ey);
	CGContextAddLineToPoint(context, Fx, Fy);
	CGContextAddLineToPoint(context, Gx, Gy);
	CGContextClosePath(context);
	CGContextEOClip(context);
	CGContextMoveToPoint(context, Ax, Ay);
	CGContextAddLineToPoint(context, Bx, By);
	CGContextAddLineToPoint(context, Cx, Cy);
	CGContextAddLineToPoint(context, Dx, Dy);
	CGContextAddLineToPoint(context, Ax, Ay);
	CGContextSetRGBFillColor(context, 0, 0, 0.5, 1);
	CGContextFillPath(context);
	CGContextRestoreGState(context);
}

- (CGGradientRef)backgroundGradient
{
	static CGGradientRef backgroundGradient = NULL;
	if (!backgroundGradient)
	{
		UIColor *contentColorTop = [UIColor colorWithRed:0.35 green:0.35 blue:0.35 alpha:1.0];
		UIColor *contentColorBottom = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0];

		CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
		CGFloat backgroundColorComponents[2][4];
		memcpy(
			backgroundColorComponents[0],
			CGColorGetComponents(contentColorTop.CGColor),
			sizeof(CGFloat) * 4);
		memcpy(
			backgroundColorComponents[1],
			CGColorGetComponents(contentColorBottom.CGColor),
			sizeof(CGFloat) * 4);
		
		const CGFloat endpointLocations[2] = {0.0, 1.0};
		backgroundGradient =
			CGGradientCreateWithColorComponents(
				colorspace,
				(const CGFloat *)backgroundColorComponents,
				endpointLocations,
				2);
		CFRelease(colorspace);
	}
	
	return backgroundGradient;
}

@end
