//
//  RDFileBrowser.m
//  SongBook
//
//  Created by Rostyslav Druzhchenko on 4/24/15.
//  Copyright (c) 2015 Rostyslav Druzhchenko. All rights reserved.
//

#import "RDFileBrowser.h"
#import "RDFileBrowserView.h"
#import "RDFsItem.h"

@interface RDFileBrowser () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) RDFsItem *rootItem;
@property (nonatomic, strong) RDFileBrowserView *view;

@end

@implementation RDFileBrowser

@dynamic view;

+ (void)presentFileBrowserWithPaht:(NSString *)path
{
    RDFileBrowser *inst = [[RDFileBrowser alloc] initWithPaht:path];
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:inst];
    
    inst.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:inst
                                                                                          action:@selector(cancelTapped)];
    
    [UIViewController showAsModal:naviVC];
}

- (instancetype)initWithPaht:(NSString *)path;
{
    self = [super init];
    if (self)
    {
        if (path == nil || [path isEqualToString:@""])
        {
            path = [self applicationDirectroy];
            self.title = @"/";
        }
        
        self.rootItem = [RDFsItem itemWithPath:path];
    }
    return self;
}

- (void)loadView
{
    self.view = [RDFileBrowserView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.tableView.delegate = self;
    self.view.tableView.dataSource = self;
    [self.view.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - Tabble stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = self.rootItem.children.count;
    return result;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    RDFsItem *item = self.rootItem.children[indexPath.row];
    cell.textLabel.text = item.name;
    cell.textLabel.textColor = item.type == RDFsItemTypeDirectory ? [UIColor blackColor] : [UIColor blueColor];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *result = @"";
    return result;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO animated:YES];

    RDFsItem *item = self.rootItem.children[indexPath.row];
    if (item.type == RDFsItemTypeDirectory)
    {
        RDFileBrowser *fileBrowserVC = [[RDFileBrowser alloc] initWithPaht:item.fullPath];
        fileBrowserVC.title = item.name;
        [self.navigationController pushViewController:fileBrowserVC animated:YES];
    }
    
    if (item.type == RDFsItemTypeFile)
    {
        NSString *title = @"";
        NSString *bytesString = [NSByteCountFormatter stringFromByteCount:item.size countStyle:NSByteCountFormatterCountStyleFile];
        NSString *message = [NSString stringWithFormat:@"File name: \"%@\"\nSize: %@", item.name, bytesString];
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:nil
                          cancelButtonTitle:NSLocalizedString(@"Ok", @"")
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Actions

- (void)cancelTapped
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Helpers

- (NSString *)applicationDirectroy
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    basePath = [basePath stringByDeletingLastPathComponent];
    
    return basePath;
}

@end
