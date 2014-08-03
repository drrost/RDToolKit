//
//  MainView.m
//  DragController
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

#import "MainView.h"

@implementation MainView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.rectView.frame = CGRectMake(100.0f, 100.0f, 150.0f, 44.0f);
}

#pragma mark - Views

- (UIView *)rectView
{
    if (!_rectView) {
        _rectView = [UIView new];
        _rectView.backgroundColor = [UIColor redColor];
        [self addSubview:_rectView];
        
        UIPanGestureRecognizer *panRecognizer = [UIPanGestureRecognizer new];
        [_rectView addGestureRecognizer:panRecognizer];
    }
    return _rectView;
}

@end
