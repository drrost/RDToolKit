//
//  DraggController.m
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

#import "DraggController.h"

@interface DraggController ()

@property (strong, nonatomic) UIView *view;

@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint prevPoint;

@end

@implementation DraggController

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        self.view = view;
        __block NSInteger pansCount = 0;
        [[self.view gestureRecognizers] enumerateObjectsUsingBlock:^(UIGestureRecognizer *recognizer, NSUInteger idx, BOOL *stop) {
            if ([recognizer isKindOfClass:[UIPanGestureRecognizer class]])
            {
                pansCount++;
                if (pansCount == 1)
                {
                    [recognizer addTarget:self action:@selector(didPan:)];
                }
                else if (pansCount > 1)
                {
                    NSLog(@"%@", @"View has more then one UIPanGestureRecognizer-s. The first one used only.");
                    *stop = YES;
                }
            }
        }];

    }
    return self;
}

#pragma mark - Actions

- (void)didPan:(UIPanGestureRecognizer *)recognizer
{
    if ([recognizer numberOfTouches] != 0)
    {
        CGPoint point = [recognizer locationOfTouch:0 inView:[self.view superview]];
        if (recognizer.state == UIGestureRecognizerStateBegan)
        {
            self.startPoint = point;
            self.prevPoint = point;
        }
        
        else if (recognizer.state == UIGestureRecognizerStateChanged)
        {
            self.view.x -= self.prevPoint.x - point.x;
            self.view.y -= self.prevPoint.y - point.y;
            
            self.prevPoint = point;
        }
    }

    if (recognizer.state == UIGestureRecognizerStateEnded ||
        recognizer.state == UIGestureRecognizerStateCancelled ||
        recognizer.state == UIGestureRecognizerStateFailed) {

        [UIView
         animateWithDuration:0.25f
         animations:^{
             [self performEndLimits];
         }];
    }
}

#pragma mark - Private

- (void)performEndLimits
{
    if (self.view.x < 0.0f)
    {
        self.view.x = 0.0f;
    }
    if (self.view.y < 0.0f)
    {
        self.view.y = 0.0f;
    }
    if (CGRectGetMaxX(self.view.frame) > [self.view superview].width)
    {
        self.view.x = [self.view superview].width - self.view.width;
    }
    if (CGRectGetMaxY(self.view.frame) > [self.view superview].height)
    {
        self.view.y = [self.view superview].height - self.view.height;
    }
}

@end
