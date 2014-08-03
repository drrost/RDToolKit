//
//  MainViewController.m
//  DragController
//
//  Created by Rostyslav Druzhchenko on 8/3/14.
//  Copyright (c) 2014 Rostyslav Druzhchenko. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "DraggController.h"

@interface MainViewController ()

@property (nonatomic, strong) MainView *view;
@property (nonatomic, strong) DraggController *dragController;

@end

@implementation MainViewController

- (void)loadView
{
    self.view = [MainView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dragController = [[DraggController alloc] initWithView:self.view.rectView];
}

@end
