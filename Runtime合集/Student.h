//
//  Student.h
//  Runtime合集
//
//  Created by james on 2018/4/8.
//  Copyright © 2018年 james. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;
+ (instancetype)studentWithName:(NSString *)name age:(NSInteger)age;

- (void)eat;
- (void)run;
@end
