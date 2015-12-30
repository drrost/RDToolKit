//
//  PlotView.h
//  testSimplePlot
//
//  Created by Rostyslav Druzhchenko on 12/29/15.
//  Copyright © 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RDPlotData.h"

@interface RDPlotView : UIView

- (void)updateWithData:(RDPlotData *)plotData;

@end
