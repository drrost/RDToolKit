//
//  RDFsItem.m
//  SongBook
//
//  Created by Rostyslav Druzhchenko on 4/24/15.
//  Copyright (c) 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "RDFsItem.h"

@implementation RDFsItem

+ (instancetype)itemWithPath:(NSString *)path
{
    RDFsItem *inst = [RDFsItem new];

    inst.fullPath = path;
    inst.name = [path lastPathComponent];
    inst.type = RDFsItemTypeDirectory;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error = nil;
    NSArray *dirContents = [fileManager contentsOfDirectoryAtPath:path error:&error];
    if (error != nil)
    {
        NSLog(@"%@", error);
    }
    
    NSMutableArray *children = [NSMutableArray arrayWithCapacity:dirContents.count];
    [dirContents enumerateObjectsUsingBlock:^(NSString *name, NSUInteger idx, BOOL *stop) {
        RDFsItem *item = [RDFsItem new];
        item.name = name;
        item.fullPath = [inst.fullPath stringByAppendingPathComponent:name];
        if ([fileManager fileExistsAtPath:item.fullPath])
        {
            BOOL isDirectory = NO;
            [fileManager fileExistsAtPath:item.fullPath isDirectory:&isDirectory];
            item.type = isDirectory ? RDFsItemTypeDirectory : RDFsItemTypeFile;
            if (item.type == RDFsItemTypeFile)
            {
                NSError *error = nil;
                NSDictionary *fileAttributes = [fileManager attributesOfItemAtPath:item.fullPath error:&error];
                if (error != nil)
                {
                    NSLog(@"%@", error);
                }
                else
                {
                    NSNumber *fileSizeNumber = [fileAttributes objectForKey:NSFileSize];
                    item.size = [fileSizeNumber longLongValue];
                }
            }
        }
        [children addObject:item];
    }];
    
    inst.children = children;
    
    return inst;
}

@end
