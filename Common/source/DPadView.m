//
//  DPadView.m
//  Controller
//
//  Created by James Addyman on 28/03/2013.
//  Copyright (c) 2013 James Addyman. All rights reserved.
//

#import "DPadView.h"

@interface DPadView () {
	
	DPadViewDirection _currentDirection;
	
	UIImageView *_dPadImageView;
	
}

@end

@implementation DPadView

- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame]))
	{
		[self commonInit];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
	if ((self = [super initWithCoder:decoder]))
	{
		[self commonInit];
	}
	
	return self;
}

- (void)commonInit
{
	_dPadImageView = [[UIImageView alloc] initWithImage:[self imageForDirection:DPadViewDirectionNone]];
	[_dPadImageView setFrame:CGRectMake(0, 0, [self bounds].size.width, [self bounds].size.height)];
	[self addSubview:_dPadImageView];
	
	_currentDirection = DPadViewDirectionNone;
}

- (void)dealloc
{
	self.delegate = nil;
}

- (DPadViewDirection)currentDirection
{
	return _currentDirection;
}

- (DPadViewDirection)directionForPoint:(CGPoint)point
{
	CGFloat x = point.x;
	CGFloat y = point.y;
	
	if (((x < 0) || (x > [self bounds].size.width)) ||
		((y < 0) || (y > [self bounds].size.height)))
	{
		return DPadViewDirectionNone;
	}
	
	NSUInteger column = x / ([self bounds].size.width / 3);
	NSUInteger row = y / ([self bounds].size.height / 3);

	DPadViewDirection direction = (row * 3) + column + 1;
	
	return direction;
}

- (UIImage *)imageForDirection:(DPadViewDirection)direction
{
	return [UIImage imageNamed:@"dPad-None"];
	/*
	UIImage *image = nil;
	
	switch (direction) {
		case DPadViewDirectionNone:
			image = [UIImage imageNamed:@"dPad-None"];
			break;
		case DPadViewDirectionUp:
			image = [UIImage imageNamed:@"dPad-Up"];
			break;
		case DPadViewDirectionDown:
			image = [UIImage imageNamed:@"dPad-Down"];
			break;
		case DPadViewDirectionLeft:
			image = [UIImage imageNamed:@"dPad-Left"];
			break;
		case DPadViewDirectionRight:
			image = [UIImage imageNamed:@"dPad-Right"];
			break;
		case DPadViewDirectionUpLeft:
			image = [UIImage imageNamed:@"dPad-UpLeft"];
			break;
		case DPadViewDirectionUpRight:
			image = [UIImage imageNamed:@"dPad-UpRight"];
			break;
		case DPadViewDirectionDownLeft:
			image = [UIImage imageNamed:@"dPad-DownLeft"];
			break;
		case DPadViewDirectionDownRight:
			image = [UIImage imageNamed:@"dPad-DownRight"];
			break;
		default:
			image = [UIImage imageNamed:@"dPad-None"];
			break;
	}
	
	return image;
	*/
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	DPadViewDirection direction = [self directionForPoint:point];
	
	if (direction != _currentDirection)
	{
		_currentDirection = direction;
		
		[_dPadImageView setImage:[self imageForDirection:_currentDirection]];
		
		if ([self.delegate respondsToSelector:@selector(dPad:didPressDirection:)])
		{
			[self.delegate dPad:self didPressDirection:_currentDirection];
		}
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint point = [touch locationInView:self];
	
	DPadViewDirection direction = [self directionForPoint:point];
	
	if (direction != _currentDirection)
	{
		_currentDirection = direction;
		[_dPadImageView setImage:[self imageForDirection:_currentDirection]];
		
		if ([self.delegate respondsToSelector:@selector(dPad:didPressDirection:)])
		{
			[self.delegate dPad:self didPressDirection:_currentDirection];
		}
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	_currentDirection = DPadViewDirectionNone;
	[_dPadImageView setImage:[self imageForDirection:_currentDirection]];
	
	if ([self.delegate respondsToSelector:@selector(dPadDidReleaseDirection:)])
	{
		[self.delegate dPadDidReleaseDirection:self];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	_currentDirection = DPadViewDirectionNone;
	[_dPadImageView setImage:[self imageForDirection:_currentDirection]];
	
	if ([self.delegate respondsToSelector:@selector(dPadDidReleaseDirection:)])
	{
		[self.delegate dPadDidReleaseDirection:self];
	}
}

@end

