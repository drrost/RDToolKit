//
//  UIPanGestureRecognizer_mock.h
//  testDragging
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

@interface UIPanGestureRecognizer_mock : NSObject

@property (nonatomic, assign) UIGestureRecognizerState state;
@property (nonatomic, assign) NSUInteger numberOfTouches;
@property (nonatomic, assign) CGPoint point;

@end
