//
//  LHPageJumperManager.h
//  LHPageJumper
//
//  Created by lyleKP on 2016/10/17.
//  Copyright © 2016年 lyle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHPageJumperManager : NSObject

//根据参数字典跳转到某个控制器
+ (void)jump2Controller:(NSDictionary *)params;

//根据参数字典跳转到某个控制器，跳转后是否pop回上级界面
+ (void)jump2Controller:(NSDictionary *)params popOther:(BOOL)pop ;


@end
