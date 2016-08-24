//
//  XZMainViewController.m
//  XZChartDemo
//
//  Created by 徐章 on 16/8/22.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "XZMainViewController.h"
#import "XZChartViewController.h"

@interface XZMainViewController ()<UITableViewDelegate,UITableViewDataSource>{

    NSArray *_chartNameArray;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation XZMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
    [self loadUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load_UI
- (void)loadUI{

    self.navigationItem.title = @"XZChartDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    //加载tableView
    [self loadTableView];
}

- (void)loadTableView{

    self.tableView                 = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight       = 44.0f;
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Load_Data
- (void)loadData{
    
    _chartNameArray = @[@"折线图",@"柱状图",@"饼状图",@"雷达图"];
}

#pragma mark - UITableView_DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _chartNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _chartNameArray[indexPath.row];
    
    return cell;
}

#pragma mark - UITableView_Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XZChartViewController *chartVc = [[XZChartViewController alloc] init];
    chartVc.navigationItem.title   = _chartNameArray[indexPath.row];
    chartVc.chartType              = indexPath.row;
    
    [self.navigationController pushViewController:chartVc animated:YES];
}
@end
