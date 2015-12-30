//
//  ViewController.m
//  testSimplePlot
//
//  Created by Rostyslav Druzhchenko on 12/29/15.
//  Copyright © 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "ViewController.h"

#import "RDPlotView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet RDPlotView *plotView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    RDPlotData *plotData = [self createPlotData];
    [self.plotView updateWithData:plotData];
}

- (RDPlotData *)createPlotData
{
    NSUInteger length = 200;
    NSUInteger sampleSize = sizeof(CGFloat);

    CGFloat *bytes = malloc(length * sampleSize);

    for (NSUInteger i = 0; i < length; i++)
    {
        bytes[i] = sin(i * 0.1f);
    }

    NSData *data = [NSData dataWithBytes:bytes length:sampleSize * length];
    RDPlotData *plotData = [[RDPlotData alloc] initWithData:data sampleSize:sampleSize];

    return plotData;
}

@end
