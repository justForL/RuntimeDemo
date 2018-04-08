//
//  Student.m
//  Runtime合集
//
//  Created by james on 2018/4/8.
//  Copyright © 2018年 james. All rights reserved.
//

#import "Student.h"

@implementation Student
- initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        self.name = name;
        self.age = age;
    }
    return self;
}

+ (instancetype)studentWithName:(NSString *)name age:(NSInteger)age {
    return [[self alloc] initWithName:name age:age];
}

- (void)eat {
    NSLog(@"eat....");
}

- (void)run {
    NSLog(@"run....");
}

@end
