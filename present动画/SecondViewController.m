//
//  SecondViewController.m
//  RedBookTransitionDemo
//
//  Created by MKJING on 16/11/17.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "SecondViewController.h"
#import "MKJPresentAnimator.h"
#import "ThirdViewController.h"

@interface SecondViewController ()  <UIViewControllerTransitioningDelegate>

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button1  =[UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 40, 40);
    [button1 setTitle:@"炸弹" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(click1:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click1:(UIButton *)button
{
    ThirdViewController *thirdVC = [[ThirdViewController alloc] init];
    thirdVC.modalPresentationStyle = UIModalPresentationCustom; // 貌似只支持几种模式，自己写还是直接用custom好了
    thirdVC.transitioningDelegate =  self; // 自己成为代理，返回动画
    [self presentViewController:thirdVC animated:YES completion:nil];
}


#pragma - present的时候需要的代理方法
#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MKJPresentAnimator new];
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [MKJPresentAnimator new];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
