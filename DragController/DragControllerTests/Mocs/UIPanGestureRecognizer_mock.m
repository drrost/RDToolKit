//
//  UIPanGestureRecognizer_mock.m
//  testDragging
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 ANODA. All rights reserved.
//

#import "UIPanGestureRecognizer_mock.h"

@implementation UIPanGestureRecognizer_mock

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.numberOfTouches = 1;
    }
    return self;
}

- (CGPoint)locationOfTouch:(NSUInteger)touchIndex inView:(UIView*)view
{
    return self.point;
}

@end
