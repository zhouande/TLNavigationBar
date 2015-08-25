//
//  TLTranslationTableViewController.m
//  TLNavigationBar
//
//  Created by andezhou on 15/8/25.
//  Copyright (c) 2015年 andezhou. All rights reserved.
//

#import "TLTranslationTableViewController.h"
#import "UINavigationBar+Helper.h"
static NSString * const identifierID = @"UITableViewCellIdentifierID";

@implementation TLTranslationTableViewController

#pragma mark -
#pragma mark lifecycle
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar tl_dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifierID];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.rowHeight = 65;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
    imageView.image = [UIImage imageNamed:@"bg.jpg"];
    self.tableView.tableHeaderView = imageView;
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        [self.navigationController.navigationBar tl_setTranslationProgress:offsetY >= 44 ? 1 : offsetY / kBarHeight];
    }
    else {
        [self.navigationController.navigationBar tl_setTranslationProgress:0];
    }
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierID forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = @"开始显示，向上滑动动态收起";
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *viewVC = [[UIViewController alloc] init];
    viewVC.view.backgroundColor = [UIColor whiteColor];
    viewVC.title = @"下一页";
    [self.navigationController pushViewController:viewVC animated:YES];
}

@end
