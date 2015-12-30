//
//  RDFsItem.h
//  SongBook
//
//  Created by Rostyslav Druzhchenko on 4/24/15.
//  Copyright (c) 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, RDFsItemType)
{
    RDFsItemTypeNone = 0,
    RDFsItemTypeFile,
    RDFsItemTypeDirectory
};

@interface RDFsItem : NSObject

+ (instancetype)itemWithPath:(NSString *)path;

@property (nonatomic, assign) RDFsItemType type;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, strong) NSString *fullPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) long long size;

@end
