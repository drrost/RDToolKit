//
//  PlotView.m
//  testSimplePlot
//
//  Created by Rostyslav Druzhchenko on 12/29/15.
//  Copyright © 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "RDPlotView.h"

@interface RDPlotView ()

@property (nonatomic, strong) RDPlotData *plotData;
@property (nonatomic, assign) CGFloat xCoef;
@property (nonatomic, assign) CGFloat yCoef;
@property (nonatomic, assign) CGFloat yOffset;

@end

@implementation RDPlotView

- (void)updateWithData:(RDPlotData *)plotData
{
    self.plotData = plotData;

    self.xCoef = self.frame.size.width / (self.plotData.data.length / self.plotData.sampleSize);
    self.yCoef = self.frame.size.height / (plotData.maxValue - plotData.minValue);
    self.yOffset = plotData.minValue * self.yCoef;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 0.0f, self.frame.size.height);
    CGContextScaleCTM(context, 1.0f, -1.0f);

    CGContextSetStrokeColorWithColor(context, UIColor.blackColor.CGColor);
    CGContextSetLineWidth(context, 1.0f);
    CGContextMoveToPoint(context, 0.0f, 0.0f); //start at this point

    NSUInteger count = self.plotData.data.length / self.plotData.sampleSize;
    CGFloat *bytes = (CGFloat *)self.plotData.data.bytes;

    for (NSUInteger i = 0; i < count; i++)
    {
        CGContextAddLineToPoint(context, i * self.xCoef, bytes[i] * self.yCoef - self.yOffset);
    }

    CGContextStrokePath(context);

    CGContextRestoreGState(context);
}

@end
