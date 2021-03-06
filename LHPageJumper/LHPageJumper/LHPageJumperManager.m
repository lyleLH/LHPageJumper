//
//  LHPageJumperManager.m
//  LHPageJumper
//
//  Created by lyleKP on 2016/10/17.
//  Copyright © 2016年 lyle. All rights reserved.
//

#import "LHPageJumperManager.h"
#import <objc/runtime.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
#import "UIViewController+TopViewController.h"

@interface LHPageJumperManager ()

@property (nonatomic, copy) NSString *className;
@property (nonatomic, strong) NSDictionary *property;

@end

@implementation LHPageJumperManager



- (instancetype)initWithDictionary:(NSDictionary *)data{
    if (self = [super init]) {
        
        self.className = [data valueForKey:@"page"];
        
        NSDictionary *property = data[@"property"];
        
        if ([property isKindOfClass:[NSDictionary class]]) {
            self.property = property;
        }
    }
    return self;
}

+ (void)jump2Controller:(NSDictionary *)params{
    [self jump2Controller:params popOther:YES];
}


+ (void)jump2Controller:(NSDictionary *)params popOther:(BOOL)pop{
    
    //    if (![params.allKeys containsObject:@"action"]) {
    //        return;
    //    }
    //
    //    NSDictionary *action = params[@"action"];
    
    if (params == nil || ![params isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    LHPageJumperManager *manager = [[LHPageJumperManager alloc] initWithDictionary:params];
    id instance = [self createViewController:manager];
    
    if (![instance isKindOfClass:[UIViewController class]]) {
        return;
    }
    
    UINavigationController *pushClassStance = [UIViewController topViewController].navigationController;
    if (pop) {
        [pushClassStance setViewControllers:@[[pushClassStance.viewControllers firstObject], instance] animated:YES];
    }else{
        [pushClassStance pushViewController:instance animated:YES];
    }
}

+ (id)createViewController:(LHPageJumperManager *)manager{
    NSString *class = manager.className;
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    //根据字符串查找到一个在运行时中已经注册的类
    Class newClass = objc_getClass(className);
    
    if (!newClass)//如果这个字符串所代表的类没有找到就利用运行时接口创建一个UIViewController的子类并注册
    {
        Class superClass = [UIViewController class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        objc_registerClassPair(newClass);
    }
    id instance = [[newClass alloc] init];//实例话这个根据字符串得到的新的类的对象
    
    //为对象已经有的属性赋值
    NSDictionary *propertys = manager.property;
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            [instance setValue:obj forKey:key];
        }
    }];
    
    return instance;
}

+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        //        NSString *attrs = @(property_getAttributes(property));
        //        NSUInteger dotLoc = [attrs rangeOfString:@","].location;
        //        NSString *code = nil;
        //        NSUInteger loc = 1;
        //        if (dotLoc == NSNotFound) { // 没有,
        //            code = [attrs substringFromIndex:loc];
        //        } else {
        //            code = [attrs substringWithRange:NSMakeRange(loc, dotLoc - loc)];
        //        }
        
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}


@end
