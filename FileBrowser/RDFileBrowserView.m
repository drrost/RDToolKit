//
//  RDFileBrowserView.m
//  SongBook
//
//  Created by Rostyslav Druzhchenko on 4/24/15.
//  Copyright (c) 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "RDFileBrowserView.h"

@implementation RDFileBrowserView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    self.tableView.frame = CGRectMake(0.0f, 0.0f, size.width, size.height);
}

@end
