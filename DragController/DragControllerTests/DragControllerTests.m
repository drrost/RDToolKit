//
//  DragControllerTests.m
//  DragControllerTests
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

#import <objc/runtime.h>
#import <XCTest/XCTest.h>
#import "DraggController.h"
#import "UIPanGestureRecognizer_mock.h"

#pragma GCC diagnostic ignored "-Wundeclared-selector"

@interface DragControllerTests : XCTestCase

@property (nonatomic, strong) DraggController *dragController;
@property (nonatomic, strong) UIPanGestureRecognizer_mock *recognizer;
@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UIView *superView;

@end

@implementation DragControllerTests

- (void)setUp
{
    [super setUp];
    
    self.recognizer = [UIPanGestureRecognizer_mock new];
    CGRect rect = CGRectMake(20.0f, 30.0f, 100.0f, 44.0f);
    self.view = [[UIView alloc] initWithFrame:rect];
    
    CGRect superRect = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
    self.superView = [[UIView alloc] initWithFrame:superRect];
    [self.superView addSubview:self.view];
    
    self.dragController = [[DraggController alloc] initWithView:self.view];
}

- (void)tearDown
{
    self.dragController = nil;
    [super tearDown];
}

#pragma mark - Inits

- (void)testInitWithOnePanRecognizer
{
    UIView *view = [UIView new];
    UIPanGestureRecognizer *recognizer = [UIPanGestureRecognizer new];
    [view addGestureRecognizer:recognizer];
    DraggController *dragController = [[DraggController alloc] initWithView:view];
    
    Ivar targetsIvar = class_getInstanceVariable([UIPanGestureRecognizer class], "_targets");
    NSArray *targets = object_getIvar(recognizer, targetsIvar);
    
    XCTAssertTrue([targets count] == 1, @"");
    dragController = nil;
}

- (void)testInitWithTwoPanRecognizer
{
    UIView *view = [UIView new];
    UIPanGestureRecognizer *recognizer1 = [UIPanGestureRecognizer new];
    [view addGestureRecognizer:recognizer1];
    UIPanGestureRecognizer *recognizer2 = [UIPanGestureRecognizer new];
    [view addGestureRecognizer:recognizer2];
    DraggController *dragController = [[DraggController alloc] initWithView:view];
    
    Ivar targetsIvar = class_getInstanceVariable([UIPanGestureRecognizer class], "_targets");
    NSArray *targets1 = object_getIvar(recognizer1, targetsIvar);
    NSArray *targets2 = object_getIvar(recognizer2, targetsIvar);
    
    XCTAssertTrue([targets1 count] == 1, @"");
    XCTAssertTrue([targets2 count] == 0, @"");
    dragController = nil;
}

- (void)testNumberOfTouches
{
    UIPanGestureRecognizer_mock *recognizer = [UIPanGestureRecognizer_mock new];
    [self.dragController performSelector:@selector(didPan:) withObject:recognizer];
    
    recognizer.numberOfTouches = 0;
    [self.dragController performSelector:@selector(didPan:) withObject:recognizer];
}

#pragma mark - Dragging

- (void)testDrag
{
    // start
    self.recognizer.state = UIGestureRecognizerStateBegan;
    self.recognizer.point = CGPointMake(120.0f, 130.0f);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    // move
    self.recognizer.state = UIGestureRecognizerStateChanged;
    self.recognizer.point = CGPointMake(125.0f, 132.0f);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    XCTAssertTrue(self.view.x == 25.0f, @"");
    XCTAssertTrue(self.view.y == 32.0f, @"");
}

#pragma mark - Limits

- (void)testDragWrongLeftXTopY
{
    // start
    self.recognizer.state = UIGestureRecognizerStateBegan;
    self.recognizer.point = CGPointMake(20.0f, 30.0f);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    // move
    self.recognizer.state = UIGestureRecognizerStateChanged;
    self.recognizer.point = CGPointMake(-15.0f, -32.0f);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    // end
    self.recognizer.state = UIGestureRecognizerStateEnded;
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    XCTAssertTrue(self.view.x == 0.0f, @"");
    XCTAssertTrue(self.view.y == 0.0f, @"");
}

- (void)testDragWrongRightXBottomY
{
    // start
    self.recognizer.state = UIGestureRecognizerStateBegan;
    self.recognizer.point = CGPointMake(20.0f, 30.0f);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    // move
    self.recognizer.state = UIGestureRecognizerStateChanged;
    self.recognizer.point = CGPointMake(self.superView.width + 1.0f, self.superView.height + 1);
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    // end
    self.recognizer.state = UIGestureRecognizerStateEnded;
    [self.dragController performSelector:@selector(didPan:) withObject:self.recognizer];
    
    XCTAssertTrue(CGRectGetMaxX(self.view.frame) == self.superView.width, @"");
    XCTAssertTrue(CGRectGetMaxY(self.view.frame) == self.superView.height, @"");
}

@end
