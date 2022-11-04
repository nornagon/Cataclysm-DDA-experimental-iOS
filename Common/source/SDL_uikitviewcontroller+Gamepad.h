//
// Created by Аполлов Юрий Андреевич on 17.01.2021.
// Copyright (c) 2021 Аполлов Юрий Андреевич. All rights reserved.
//

#import "external/sdl2/src/video/uikit/SDL_uikitviewcontroller.h"

@interface SDL_uikitviewcontroller (Gamepad) <UIGestureRecognizerDelegate>

@property (nonatomic, assign) int keyboardHeight;

- (void)maybeUpdateFrameTo:(CGSize)size;
- (void)resizeRootView;

@end
