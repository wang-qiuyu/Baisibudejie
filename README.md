
# 仿百思不得姐app

----

##首先感谢李明杰MJ老师，([@M了个J](http://weibo.com/exceptions?from=myfollow_all&is_all=1))。

![项目截图](http://upload-images.jianshu.io/upload_images/1116587-aaa8133b29dbea88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

目前只完成了一些简单的界面，使用cocoaPods管理代码，用到了一些常用的第三方库，包括AFNetworking，DACircularProgress，M13ProgressSuite，MJExtension，MJRefresh，pop，SDWebImage，SVProgressHUD。

后面还会继续更新。

代码以及更新地址：

## [github地址](https://github.com/hrscy/Baisibudejie)

---

下面是记录编码过程中的一些记录：

## UITabBarController.h

通过appearance统一设置tabbarItem的样式;
后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置。


```
NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    //通过appearance统一设置tabbarItem的样式
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
```

设置tabbarItem的图片不进行渲染（默认进行渲染）。

方法一：

```
image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//设置选中图片不进行渲染
vc1.tabBarItem.selectedImage = image;
```
方法二：

在Assets.xcassets中选择需要设置的图片：


只读属性可以通过KVC来改变
	
```
vc.title = title;
```
等价于下面的代码：

```
vc.navigationItem.title = title;
vc.tabBarItem.title = title;
```

# 分类

	在分类中声明@property，只会生成方法的声明，不会生成方法的实现和带有_下划线的成员变量。


## 在xib或storyboard中，输入的文字如果想换行，可以按住option，然后回车，即可实现换行。

使用Xcode安装pods的时候，可能会出现下面的情况：

```
Updating local specs repositories
````

解决办法使用终端，切换到项目目录，执行下面命令：

```
pod install  换成pod install --verbose --no-repo-update这个命令
```

## 在UITableViewCell中，设置selection为None之后，即使cell被选中，内部的子控件也不会进入高亮状态。

解决办法：

```
/*
*  可以在这个方法中监听cell的选中和取消选中
*/
-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
	//在这里重新设置选中状态的属性
}
```

## 修改占位文字的颜色

方法一：

```
NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    //带有属性的文字（富文本）
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"手机号" attributes:attrs];
    self.phoneField.attributedPlaceholder = placeholder;
```

方法二：

重写UITextField的方法：

```
-(void)drawPlaceholderInRect:(CGRect)rect；
```

设置UITextField的属性。

## 运行时(Runtime)

能做底层操作（比如访问隐藏的成员变量）。

```
+(void)initialize {
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([UITextView class], &count);
    for (int i = 0; i < count; i++) {
        //去除成员变量
         Ivar ivar = *(ivars + i);
        //打印成员变量名字
        YMLog(@"%s",ivar_getName(ivar));
    }
    //释放
    free(ivars);
}
```

```
-(void)setHighlighted:(BOOL)highlighted {
    //聚焦
    //修改占位符文字颜色
    [self setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
}
```


```
//如果发现控件的位置和尺寸不是自己设置的，那么有可能是自动伸缩属性导致
    self.autoresizingMask = UIViewAutoresizingNone;
```


判断图片是否为gif图片

取出图片的第一个字节，就可以判断出图片的真是类型。

窗口级别：

```
UIWindowLevelNormal < UIWindowLevelStatusBar < UIWindowLevelAlert
```