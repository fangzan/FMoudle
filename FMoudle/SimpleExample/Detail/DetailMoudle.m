//
//  DetailMoudle.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "DetailMoudle.h"
@interface DetailModule()<UIAlertViewDelegate>

@end
@implementation DetailModule
@synthesize callbackBlock;

- (void)showAlterViewCallBackInViewController:(UIViewController*)viewController
{
    UIAlertController *alter = [UIAlertController alertControllerWithTitle:@"" message:@"测试回调函数" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self.callbackBlock) {
            self.callbackBlock(@"1234");
        }
    }];
    [alter addAction:sureAction];
    
    [viewController presentViewController:alter animated:YES completion:nil];
}


@end
