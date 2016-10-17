//
//  ViewController.m
//  LHPageJumper
//
//  Created by lyleKP on 2016/10/17.
//  Copyright © 2016年 lyle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)UITableView * tableView;


@property (nonatomic,retain) NSMutableArray * dataSource ;


@end

@implementation ViewController







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Master";
    [self.view addSubview:self.tableView];
    
}


- (void)fakeData  {
    
    NSDictionary  * dic1 =  @{
                              @"page": @"KPWebViewController",
                              @"property": @{
                                      @"strUrl": @"http://www.baidu.com",
                                      @"strtitle": @"这是某个webView"
                                      }
                              };
    
}



#pragma mark  -Delegate Method
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {\
    return self.dataSource.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell) {
    
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    
    
    
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark  -  Property
- (UITableView *)tableView {
    if(!_tableView){
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource =self;
        
        
    }
    return _tableView;
}

@end
