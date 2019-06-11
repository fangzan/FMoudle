//
//  MeViewController.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "MeViewController.h"
#import "HomeProtocol.h"
@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(80, 120, 200, 40);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"进入首页模块" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnAction
{
    id <HomeProtocol> mineM = [FRouter interfaceCacheModuleForProtocol:@protocol(HomeProtocol)];
    NSLog(@"%@",mineM.paramterForHome);
    [self.navigationController pushViewController:mineM.interfaceViewController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
