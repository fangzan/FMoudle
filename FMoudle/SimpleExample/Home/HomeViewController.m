//
//  HomeViewController.m
//  FMoudle
//
//  Created by AoChen on 2019/6/11.
//  Copyright © 2019 Ac. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeProtocol.h"
#import "DetailMoudle.h"

@interface HomeViewController ()
@property (nonatomic, weak) id <HomeProtocol> homeMoudle;
@property (nonatomic, weak) id <DetailProtocol> detailMoudle;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(80, 120, 200, 40);
    btn.center = self.view.center;
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"调用详情模块回传数据" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    NSLog(@"123%@",self.homeMoudle.paramterForHome);
    
}

- (id <HomeProtocol>)homeMoudle
{
    return [FRouter interfaceCacheModuleForProtocol:@protocol(HomeProtocol)];
}

- (id<DetailProtocol>)detailMoudle
{
    return [FRouter interfaceCacheModuleForProtocol:@protocol(DetailProtocol)];
}

- (void)btnAction
{
    
    [self.detailMoudle showAlterViewCallBackInViewController:self];
    
    self.detailMoudle.callbackBlock = ^(id parameter) {
        NSLog(@"------回调函数传过来的参数---------%@",parameter);
    };
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
