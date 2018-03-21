//
//  NBTableViewController.m
//  NBTableView
//
//  Created by 刘彬 on 16/3/10.
//  Copyright © 2016年 NewBee. All rights reserved.
//

#import "NBTableViewController.h"
#import "NBBaseViewModel.h"

@interface NBTableViewController ()<NBBaseViewModelDelegate>


@end

@implementation NBTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    if (self.automaticallyAdjustsScrollViewInsets && self.navigationController.navigationBar.translucent) {
        if ([self.navigationController isNavigationBarHidden]) {
            self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        } else {
            self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
        }
    }
}

- (void)dealloc{
    _tableView.dataSource = nil;
    _tableView.delegate   = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor  = COLOR_TABLE_BACKGROUND_GRAY;
        //_tableView.backgroundColor  = COLOR_SYSTEM_WHITE;
        _tableView.backgroundView   = nil;
        _tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
        _tableView.exclusiveTouch   = YES;// 排除多点触控时出现未知异常响应
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
    }
    return _tableView;
}

- (NBTableViewAdaptor *)tableViewAdaptor{
    if (_tableViewAdaptor == nil) {
        _tableViewAdaptor = [NBTableViewAdaptor adaptorWithTableView:self.tableView];
        _tableViewAdaptor.delegate = self;
    }
    return _tableViewAdaptor;
}

@end
