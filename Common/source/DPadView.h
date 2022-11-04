//
//  DPadView.h
//  Controller
//
//  Created by James Addyman on 28/03/2013.
//  Copyright (c) 2013 James Addyman. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DPadViewDirection)
{
	DPadViewDirectionNone = 0,
	DPadViewDirectionUpLeft = 1,
	DPadViewDirectionUp,
	DPadViewDirectionUpRight,
	DPadViewDirectionLeft,
	DPadViewDirectionMiddle,
	DPadViewDirectionRight,
	DPadViewDirectionDownLeft,
	DPadViewDirectionDown,
	DPadViewDirectionDownRight
};

@class DPadView;

@protocol DPadViewDelegate <NSObject>

- (void)dPad:(DPadView *)dPad didPressDirection:(DPadViewDirection)direction;
- (void)dPadDidReleaseDirection:(DPadView *)dPad;

@end

@interface DPadView : UIView

@property (nonatomic, weak) IBOutlet id <DPadViewDelegate> delegate;

- (DPadViewDirection)currentDirection;

@end
