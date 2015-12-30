//
//  PlotData.m
//  testSimplePlot
//
//  Created by Rostyslav Druzhchenko on 12/29/15.
//  Copyright © 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "RDPlotData.h"

@implementation RDPlotData

- (instancetype)initWithData:(NSData *)data sampleSize:(NSUInteger)sampleSize
{
    self = [super init];
    if (self)
    {
        _data = data;
        _sampleSize = sampleSize;
        [self calculateDataMetrics];
    }
    return self;
}

- (void)calculateDataMetrics
{
    NSUInteger count = self.data.length / self.sampleSize;
    CGFloat *bytes = (CGFloat *)self.data.bytes;
    _maxValue = bytes[0];
    _minValue = bytes[0];
    for (NSInteger i = 0; i < count; i++)
    {
        if (bytes[i] > _maxValue)
        {
            _maxValue = bytes[i];
        }

        if (bytes[i] < _minValue)
        {
            _minValue = bytes[i];
        }
    }
}

@end
