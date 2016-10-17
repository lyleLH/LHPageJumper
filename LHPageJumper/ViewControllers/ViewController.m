//
//  ViewController.m
//  LHPageJumper
//
//  Created by lyleKP on 2016/10/17.
//  Copyright © 2016年 lyle. All rights reserved.
//

#import "ViewController.h"
#import "LHPageJumperManager.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,retain)UITableView * tableView;


@property (nonatomic,retain) NSMutableArray * dataSource ;


@end

@implementation ViewController







- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"Master";
    [self fakeData];
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
    NSDictionary  * dic2 =  @{
                              @"page": @"ChatViewContorller",
                              @"property": @{
                                      @"conversationId": @"13992",
                                      }
                              };
    NSDictionary  * dic3 =  @{
                              @"page": @"ProductViewController",
                              @"property": @{
                                      @"productId": @"123456789098765434",
                                      }
                              };
    
    [self.dataSource addObject:dic1];
    [self.dataSource addObject:dic2];
    [self.dataSource addObject:dic3];
    
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
    NSDictionary * dic = self.dataSource[indexPath.row];
    cell.textLabel.text = dic[@"page"];
    
    
    return cell;
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [LHPageJumperManager jump2Controller:self.dataSource[indexPath.row]];
    
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

- (NSMutableArray *)dataSource {
    if(!_dataSource ){
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return _dataSource;
}
@end
