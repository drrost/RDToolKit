//
//  DraggController.h
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

@interface DraggController : NSObject

/**
 * The method takes UIView object with added UIPanGestureRecognizer. It finds
 * UIPanGestureRecognizer added to the view and handles it's callbacks.
 * If the view has more then one UIPanGestureRecognizer it handles only first
 * one returned by [UIView gestureReconizers] method and ignores others.
 *
 *  @param view View with UIPanGestureRecognizer
 *
 *  @return Initialized instance
 */
- (instancetype)initWithView:(UIView *)view;

@end
