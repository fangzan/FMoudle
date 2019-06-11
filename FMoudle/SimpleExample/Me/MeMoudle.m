//
//  MeMoudle.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "MeMoudle.h"
#import "MeViewController.h"
@implementation MeMoudle
- (id)interfaceViewController
{
    return [[MeViewController alloc]init];
}
- (void)presentHomeViewController:(UIViewController *)vc
{
    [vc presentViewController:[[MeViewController alloc] init] animated:YES completion:nil];
}
@end
