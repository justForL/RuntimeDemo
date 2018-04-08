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
@interface ViewController ()
@property(nonatomic,strong)Student *stu;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@---%zd",self.stu.name,self.stu.age);
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self changeInstancePropertyValue];
    
    [self runtimeChangeMethod];
    
    [self.stu eat];
}


- (void)runtimeChangeMethod {
    
    Method runMethod = class_getInstanceMethod([self.stu class], @selector(run));
    
    Method eatMethod = class_getInstanceMethod([self.stu class], @selector(eat));
    
    method_exchangeImplementations(runMethod, eatMethod);
}


- (void)changeInstancePropertyValue {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self.stu class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *propertyName = [NSString stringWithUTF8String:ivarName];
        
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
