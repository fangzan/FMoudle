//
//  HomeMoudle.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "HomeMoudle.h"
#import "HomeViewController.h"

@implementation HomeModule
// 实现属性扩展
@synthesize paramterForHome;

- (id)interfaceViewController
{
    return [[HomeViewController alloc]init];
}

@end
