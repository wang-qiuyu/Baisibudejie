//
//  YMPublishViewController.m
//  Baisibudejie
//
//  Created by 杨蒙 on 16/5/10.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMPublishViewController.h"
#import "YMVerticalButton.h"
#import "POP.h"

static CGFloat const YMAnimationDelay = 0.1;
static CGFloat const YMSpringFactor = 10;

@interface YMPublishViewController ()

@end

@implementation YMPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //让控制器的 view 不能被点击
    self.view.userInteractionEnabled = NO;
    
    //数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    //中间 6 个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (SCREENH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (SCREENW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (NSInteger i = 0; i< images.count; i++) {
        YMVerticalButton *button = [[YMVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        // 计算X\Y
        int row = (int)(i / maxCols);
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - SCREENH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = YMSpringFactor;
        anim.springSpeed = YMSpringFactor;
        anim.beginTime = CACurrentMediaTime() + YMAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:nil];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
-(void)cancelWithCompletionBlock:(void (^)())completionBlock {
    //让控制器的 view 不能被点击
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + SCREENH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * YMAnimationDelay;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

/**
 pop和Core Animation的区别
 1.Core Animation的动画只能添加到layer上
 2.pop的动画能添加到任何对象
 3.pop的底层并非基于Core Animation, 是基于CADisplayLink
 4.Core Animation的动画仅仅是表象, 并不会真正修改对象的frame\size等值
 5.pop的动画实时修改对象的属性, 真正地修改了对象的属性
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:nil];
}

@end
