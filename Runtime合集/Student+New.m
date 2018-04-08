//
//  Student+New.m
//  Runtime合集
//
//  Created by james on 2018/4/8.
//  Copyright © 2018年 james. All rights reserved.
//

#import "Student+New.h"
#import <objc/runtime.h>
@implementation Student (New)


//static const char _isNew;



//- (void)setIsNew:(BOOL)isNew {
//    objc_setAssociatedObject(self, &_isNew, @(isNew), OBJC_ASSOCIATION_ASSIGN);
//}
//
//
//- (BOOL)isNew {
//    return [objc_getAssociatedObject(self, &_isNew) boolValue];
//}



- (void)setIsNew:(BOOL)isNew {
    objc_setAssociatedObject(self, @selector(isNew), @(isNew), OBJC_ASSOCIATION_ASSIGN);
}


- (BOOL)isNew {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
@end
