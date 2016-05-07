//
//  YMShowPictureViewController.m
//  ImitateBaisi
//
//  Created by 杨蒙 on 16/2/24.
//  Copyright © 2016年 hrscy. All rights reserved.
//

#import "YMShowPictureViewController.h"
#import "UIImageView+WebCache.h"
#import "YMTopic.h"
#import "SVProgressHUD.h"
#import "YMProgressView.h"

@interface YMShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) UIImageView *imageView;

@property (weak, nonatomic) IBOutlet YMProgressView *progressView;

@end

@implementation YMShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButton:)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    //图片尺寸
    CGFloat pictureW = SCREENW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > SCREENH) {
        //图片显示高度超过一个屏幕,屏幕需要滚动查看
        self.imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(pictureW, pictureH);
        
    } else {
        self.imageView.size = CGSizeMake(pictureW, pictureH);
        self.imageView.centerY = SCREENH * 0.5;
    }
    //马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:NO];
    
    //下载图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 返回按钮
- (IBAction)backButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 保存按钮
- (IBAction)save:(UIButton *)sender {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并未下载完毕!"];
        return;
    }
    //将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark 保存成功
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
    
}


@end
