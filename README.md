# iOS 倒计时按钮  &&  UITabbarCtr的封装

https://github.com/295060456/JobsTabbarItemLottie

![TabbarItemLottie 【Outlines 01】](https://user-images.githubusercontent.com/13795605/99761303-559d7200-2b28-11eb-9dc1-e0f1916a4f35.png)
![TabbarItemLottie 【Outlines 02】](https://user-images.githubusercontent.com/13795605/99761306-57673580-2b28-11eb-83c9-137d514f763e.png)
![TabbarItemLottie 【Outlines 03】](https://user-images.githubusercontent.com/13795605/99761309-58986280-2b28-11eb-8745-714743cfbd4f.png)
![TabbarItemLottie 【Outlines 04】](https://user-images.githubusercontent.com/13795605/99761310-5930f900-2b28-11eb-8819-b8d3f82ce717.png)
![TabbarItemLottie 【Outlines 05】](https://user-images.githubusercontent.com/13795605/99761311-5930f900-2b28-11eb-93a3-4dc5c8c233b8.png)
![TabbarItemLottie 【Outlines 06】](https://user-images.githubusercontent.com/13795605/99761312-59c98f80-2b28-11eb-9df3-f266d659f78e.png)
![TabbarItemLottie 【Outlines 07】](https://user-images.githubusercontent.com/13795605/99761313-5a622600-2b28-11eb-8c1c-1ed263ee7b52.png)

## 关于验证码倒计时按钮的封装，此框架推到重来无数次，我个人认为已经达到顶峰
### 1、重新梳理业务逻辑，优化代码；
### 2、加入对富文本的支持；
### 3、富文本他终究是文本，只是字符串的入口和形式不一样。于是封装富文本支持在UILabel层，以分类的形式，减少代码入侵；#import "UILabel+RichText.h"
### 4、UIButton里面的titleLabel是继承自UILabel，于是3的拓展对其有效；
### 5、于是在之前的基础上进行了完全意义上的富文本拓展，此倒计时按钮也是用UIButton的分类实现，无入侵性，#import "UIButton+CountDownBtn.h"
## 目前的功能：
### 1、支持普通文本和富文本；
### 2、每一句富文本对应一个model。这样代码简洁
### 3、按钮的timer是用最基础的NSTimer，考虑到使用的频繁以及不需要多大的精度，一般定时器我们都会用NStimer而不会去考虑线程等问题
### 4、关于NStimer这一块也是单独封装了一个工具，详见#import "TimerManager.h"
### 5、支持换行显示，文字居中对齐；
### 6、时间是动态的，也存在一些不变的提示语，这两类字符串支持谁在前谁在后，自定义，有默认值；
### 7、时间有顺时针和逆时针两种模式
### 8、定时器存在自启动和用户手动触发两种模式，根据需求来。
### 9、本来不想把init写的很复杂，也就是我的习惯是不希望init带很多参数，但是自启动模式下，比较难以把握其生命周期，参数会乱，所以一开始创建的时候就进去。另外一个也和系统的初始化方法进行区分
## 关于UITabbarCtr的封装
### 1、在系统基础上做定制，也就是说完全围绕着UITabbarCtr及其子类来进行封装，于网上其他完全抛弃UITabbarCtr的封装是不一样的架构；
### 2、因为是在系统Api UITabbarCtr上进行拓展，所以保留了系统Api一些特性，；
    2.1、比如加入其中的控制器不能超过6个，否则以“更多”按钮展示一个Tableview，且上架Apple Store审核被拒；
    2.2、itemBar无法做成ScrollView的形式左右滑动
    ...
    所以如需更深层次的定制请移步UIViewCtr的架构
    
### 3、因为考虑到苹果的UITabbarCtr可能对底层或多或少做了优化，普适性比较好，其他框架（完全抛弃UITabbarCtr的封装）有一定学习成本，而且很凌乱；
### 4、支持了Lottie动画；
### 5、支持了某位置上凸起；
### 6、支持了按键声；
### 7、支持了按键震动反馈；
### 8、支持了长按手势；
### 9、支持了右上角角标动效；pod 'PPBadgeView' #https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类
### 10、支持了自定义导航条pod 'GKNavigationBar'，
    10.1、如果对系统导航条的生命周期比较头疼难以把握，又没有时间精力去研究可以用此替代，全局屏蔽系统即可；
    10.2、如果项目多人开发某些人对GK有抵触情绪，可以在相关功能模块用系统自带的。


