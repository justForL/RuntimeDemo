//
//  ViewController.m
//  Runtime合集
//
//  Created by james on 2018/4/8.
//  Copyright © 2018年 james. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "Student+New.h"
@interface ViewController ()
@property(nonatomic,strong)Student *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@---%zd",self.stu.name,self.stu.age);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //动态改变值属性
//    [self changeInstancePropertyValue];
    //交换方法
//    [self runtimeChangeMethod];
//    [self.stu eat];
    
    //runtime关联
    [self a];
}

- (void)a {
    NSLog(@"%zd",self.stu.isNew);
    self.stu.isNew = YES;
    NSLog(@"%zd",self.stu.isNew);
}

- (void)runtimeChangeMethod {
    
    Method runMethod = class_getInstanceMethod([self.stu class], @selector(run));
    
    Method eatMethod = class_getInstanceMethod([self.stu class], @selector(eat));
    
    method_exchangeImplementations(runMethod, eatMethod);
}


- (void)changeInstancePropertyValue {
    //累加要获取类的属性条数
    unsigned int count = 0;
    //获取属性个数的集合
    Ivar *ivars = class_copyIvarList([self.stu class], &count);
    
    //遍历集合
    for (int i = 0; i < count; i++) {
        //获得单个属性
        Ivar ivar = ivars[i];
        //转化成c字符串
        const char *ivarName = ivar_getName(ivar);
        //将c串转化成oc字符串
        NSString *propertyName = [NSString stringWithUTF8String:ivarName];
        //判断 取出想要改变值的属性
        if ([propertyName isEqualToString:@"_name"]) {
            object_setIvar(self.stu, ivar, @"小红");
        }
    }
    NSLog(@"%@---%zd",self.stu.name,self.stu.age);
}


#pragma mark - lazyload
- (Student *)stu {
    if (_stu == nil) {
        
        _stu = ((Student * (*) (id, SEL, NSString *, NSInteger))objc_msgSend)((id) [Student class], @selector(studentWithName:age:),@"小明",13);
        
    }
    return _stu;
}
@end
