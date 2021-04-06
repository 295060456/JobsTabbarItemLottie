# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

# 下面两行是指明依赖库的来源地址
source 'https://github.com/CocoaPods/Specs.git'# 使用官方默认地址（默认）
source 'https://github.com/Artsy/Specs.git'# 使用其他来源地址

# install! 只走一次，多次使用只以最后一个标准执行
# deterministic_uuids 解决与私有库的冲突
# generate_multiple_pod_projects 可以让每个依赖都作为一个单独的项目引入，大大增加了解析速度；cocoapods 1.7 以后支持
# disable_input_output_paths ？？？
# 需要特别说明的：在 post_install 时，为了一些版本的兼容，需要遍历所有 target，调整一部分库的版本；但是如果开启了 generate_multiple_pod_projects 的话，由于项目结构的变化，installer.pod_targets 就没办法获得所有 pods 引入的 target 了
install! 'cocoapods',:deterministic_uuids=>false,generate_multiple_pod_projects: true,disable_input_output_paths: true

platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!

# 特别说明：Ruby对大小写敏感，所以方法名不要用大写，否则执行失败
def func
  pod 'lottie-ios', '~> 2.5.3'
  pod 'PPBadgeView' #https://github.com/jkpang/PPBadgeView iOS自定义Badge组件, 支持UIView, UITabBarItem, UIBarButtonItem以及子类
  pod 'Masonry' # https://github.com/SnapKit/Masonry 布局
  pod 'ReactiveObjC'  # https://github.com/ReactiveCocoa/ReactiveObjC 重量级框架
  
  pod 'BRPickerView'
  pod 'GKNavigationBar'
  pod 'GKPhotoBrowser' # https://github.com/QuintGao/GKPhotoBrowser iOS仿微信、今日头条等图片浏览器 
  pod 'JXCategoryView' # https://github.com/pujiaxin33/JXCategoryView
  pod 'JXPagingView/Pager' # https://github.com/pujiaxin33/JXPagingView NO_SMP
  pod 'MJRefresh'
  pod 'MJExtension'
  pod 'JPImageresizerView' # https://github.com/Rogue24/JPImageresizerView 一个专门裁剪图片、GIF、视频的轮子，简单易用，功能丰富（高自由度的参数设定、支持旋转和镜像翻转、蒙版、压缩等），能满足绝大部分裁剪的需求。
  pod 'SPAlertController'# https://github.com/SPStore/SPAlertController 深度定制AlertController
  pod 'SDWebImage' # https://github.com/SDWebImage/SDWebImage
  pod 'YYImage'
  pod 'WHToast' # https://github.com/remember17/WHToast 一个轻量级的提示控件，没有任何依赖
  pod 'TXFileOperation' # 文件夹操作 https://github.com/xtzPioneer/TXFileOperation
  pod 'TABAnimated' # https://github.com/tigerAndBull/TABAnimated
  pod 'LYEmptyView'
  end

# 基础的公共配置
def cocoPodsConfig
  target 'TabbarItemLottieTests' do
    inherit! :search_paths # abstract! 指示当前的target是抽象的，因此不会直接链接Xcode target。与其相对应的是 inherit！
    # Pods for testing
    end
  
  target 'TabbarItemLottieUITests' do
    inherit! :search_paths
    # Pods for testing
    end
  
  # 当我们下载完成，但是还没有安装之时，可以使用hook机制通过pre_install指定要做更改，更改完之后进入安装阶段。 格式如下：
  pre_install do |installer|
      # 做一些安装之前的更改
    end
  
  # 这个是cocoapods的一些配置,官网并没有太详细的说明,一般采取默认就好了,也就是不写.
  post_install do |installer|
    installer.pods_project.targets.each do |target|

      # 当我们安装完成，但是生成的工程还没有写入磁盘之时，我们可以指定要执行的操作。 比如，我们可以在写入磁盘之前，修改一些工程的配置：

      puts "!!!! #{target.name}"
      end
    end
  end

target 'TabbarItemLottie' do
  # Pods for TabbarItemLottie
  func
  cocoPodsConfig # 基础的公共配置
end
