//
//  MKJNavigationViewController.m
//  RedBookTransitionDemo
//
//  Created by MKJING on 16/11/17.
//  Copyright © 2016年 MKJING. All rights reserved.
//

#import "MKJNavigationViewController.h"
#import "MKJAnimator.h"
#import "MKJSuperAnimation.h"

// 弄一个子类继承nvc,在这里实现返回动画的代理方法
@interface MKJNavigationViewController () <UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) CGRect destinationRec;
@property (nonatomic,assign) CGRect originalRec;
@property (nonatomic,assign) BOOL isPush;
@property (nonatomic,assign) id animationDelegate; // 动画的代理temp
@property (nonatomic,assign) BOOL isRight;

@end

@implementation MKJNavigationViewController

- (void)pushViewController:(UIViewController *)viewController imageView:(UIImageView *)imageView desRec:(CGRect)desRec original:(CGRect)originalRec deleagte:(id<MKJAnimatorDelegate>)delegate isRight:(BOOL)isRight
{
    //隐藏子控制器的tabbar
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated:)];
    }
    
    self.isRight = isRight;
    self.delegate = self; //  让自身成为代理，实现下面的方法
    self.imageView = imageView;
    self.destinationRec = desRec;
    self.originalRec = originalRec;
    self.isPush = YES;
    self.animationDelegate = delegate; // 让动画的代理成为destinationVC
    [super pushViewController:viewController animated:YES];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    self.isPush = NO;
    return  [super popViewControllerAnimated:animated];
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    // 普通push的时候就是小红书类型的
    MKJAnimator *animator = [[MKJAnimator alloc] init];
    animator.imageView = self.imageView;
    animator.destinationRec = self.destinationRec;
    animator.originalRec = self.originalRec;
    animator.isPush = self.isPush;
    animator.delegate = self.animationDelegate;
    
    // 左侧push的时候是屏幕碎裂类型的
    MKJSuperAnimation *superAnimator = [[MKJSuperAnimation alloc] init];
    
    if (self.isRight) {
        return animator;
    }
    else
    {
        return superAnimator;
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationBar.tintColor = [UIColor colorWithRed:0.57f green:0.88f blue:0.83f alpha:1.00f];
#pragma mark----隐藏黑线
    [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
    
}


#pragma mark----隐藏子页面的tabbar
//有了动画效果就不再走这个方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(popViewControllerAnimated:)];
    }
    [super pushViewController:viewController animated:animated];
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
