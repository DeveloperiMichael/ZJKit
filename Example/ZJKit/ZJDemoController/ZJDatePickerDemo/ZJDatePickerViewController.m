//
//  ZJDatePickerViewController.m
//  ZJKit_Example
//
//  Created by 张炯 on 2018/7/10.
//  Copyright © 2018年 DeveloperiMichael. All rights reserved.
//

#import "ZJDatePickerViewController.h"
#import <ZJKit/ZJRowPickerView.h>
#import <ZJKit/ZJPickerView.h>
#import <ZJKit/ZJRowPickerTableViewCell.h>
#import <Masonry/Masonry.h>
@interface ZJDatePickerViewController ()
<ZJRowPickerViewDataSource,
ZJRowPickerViewDelegate,
ZJPickerViewDelegate,
ZJPickerViewDataSource>

@property (nonatomic, strong) ZJRowPickerView *rowPickerView;
@property (nonatomic, strong) ZJPickerView *pickerView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray *componentArray;

@end

@implementation ZJDatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIDatePicker *picker = [[UIDatePicker alloc] init];
//    UIPickerView *pickerView = [UIPickerView new];
//    UITableView *tableView = [UITableView new];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"AAAA-0",@"AAAA-1",@"AAAA-2",@"AAAA-3",@"AAAA-4",@"AAAA-5",@"AAAA-6",@"AAAA-7",@"AAAA-8",@"AAAA-9",@"AAAA-10",@"AAAA-11",@"AAAA-12"];
    
    
    NSArray *array1 = @[@"A-0",@"A-1",@"A-2",@"A-3",@"A-4",@"A-5",@"A-6",@"A-7",@"A-8",@"A-9",@"A-10",@"A-11",@"A-12"];
    NSArray *array2 = @[@"B-0",@"B-1",@"B-2",@"B-3",@"B-4",@"B-5",@"B-6",@"B-7",@"B-8",@"B-9"];
    NSArray *array3 = @[@"C-0",@"C-1",@"C-2",@"C-3",@"C-4",@"C-5",@"C-6",@"C-7",@"C-8",@"C-9",@"C-10",@"C-11",@"C-12",@"C-13",@"C-14",@"C-15",@"C-16",@"C-17",@"C-18",@"C-19"];

    self.componentArray = [NSMutableArray arrayWithObjects:array1,array2,array3, nil];
    
    [self addPickerView];
    [self.pickerView selectRow:2 inComponent:0 animated:YES];
    [self.pickerView selectRow:5 inComponent:1 animated:YES];
    [self.pickerView selectRow:8 inComponent:2 animated:YES];
    
    
    
}

#pragma mark---------
#pragma mark------------- ZJRowPickerView

- (void)addRowPickerView {
    [self.view addSubview:self.rowPickerView];
    [self.rowPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(100);
    }];
    [_rowPickerView setSelectRowAtIndex:5];
}

- (ZJRowPickerView *)rowPickerView {
    if (!_rowPickerView) {
        _rowPickerView = [[ZJRowPickerView alloc] init];
        _rowPickerView.delegate = self;
        _rowPickerView.dataSource = self;
        _rowPickerView.backgroundColor = [UIColor brownColor];
    }
    return _rowPickerView;
}

- (CGFloat)zj_heightForRowInRowPickerView:(ZJRowPickerView *)rowPickerView {
    return 40.f;
}

- (NSInteger)zj_numberOfDisplayRowsInRowPickerView:(ZJRowPickerView *)rowPickerView {
    return 6;
}

- (NSInteger)zj_numberOfRowsInRowPickerView:(ZJRowPickerView *)rowPickerView {
    return self.dataArray.count;
}

- (NSString *)zj_rowPickerView:(ZJRowPickerView *)rowPickerView contentForRowAtIndex:(NSInteger)index {
    return self.dataArray[index];
}

- (void)zj_rowPickerView:(UITableView *)rowPickerView didSelectRowAtIndex:(NSInteger)index {
    NSLog(@"===didSelectRowAtIndex:%ld====",index);
}

#pragma mark---------
#pragma mark------------- ZJPickerView

- (void)addPickerView {
    [self.view addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.mas_equalTo(320);
        make.height.mas_equalTo(320);
    }];
}

- (ZJPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[ZJPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor brownColor];
    }
    return _pickerView;
}

- (NSInteger)zj_numberOfComponentsInPickerView:(ZJPickerView *)pickerView {
    return self.componentArray.count;
}


- (NSInteger)zj_pickerView:(ZJPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [(NSArray *)self.componentArray[component] count];
}

- (CGFloat)zj_rowHeightForComponentPickerView:(UIPickerView *)pickerView {
    return 0;
}


- (nullable NSString *)zj_pickerView:(ZJPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.componentArray[component][row];
}


- (void)zj_pickerView:(ZJPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"===didSelectRowAtIndex:%ld==inComponent:%ld===",row,component);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
