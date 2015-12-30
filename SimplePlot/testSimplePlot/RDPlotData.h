//
//  PlotData.h
//  testSimplePlot
//
//  Created by Rostyslav Druzhchenko on 12/29/15.
//  Copyright © 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RDPlotData : NSObject

@property (nonatomic, strong, readonly) NSData *data;
@property (nonatomic, assign, readonly) NSInteger sampleSize;
@property (nonatomic, assign, readonly) CGFloat maxValue;
@property (nonatomic, assign, readonly) CGFloat minValue;

- (instancetype)initWithData:(NSData *)data sampleSize:(NSUInteger)sampleSize;

@end
