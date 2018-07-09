# SHSegmentedControl

[![CocoaPods](https://img.shields.io/badge/pod-v1.1.9-cyan.svg)](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/tree/1.1.9)
![Platforms](https://img.shields.io/badge/platforms-iOS-orange.svg)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/LICENSE)
[![QQ](https://img.shields.io/badge/QQ-@HatsuneMiku-blue.svg)](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#qq-479069761)


Both scroll horizontal and vertical for segment scrollview which have a same header. — 类似半糖、美丽说主页与QQ音乐歌曲列表布局效果，实现不同菜单的左右滑动切换，同时支持类似tableview的顶部工具栏悬停（既可以左右滑动，又可以上下滑动）。兼容下拉刷新，上拉加载更多。 支持swift的使用此库，具体方式请看demo，如果有什么问题请戳邮箱或者qq。

## 预览↓↓↓

![](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/snow.gif)

### 2018.05.24新增demo(pod v1.1.9)，修复SHSegmentedControl内容超屏，不能自动滑动问题↓↓↓
#### 在这里感谢[@windkisshao](https://github.com/windkisshao)的指正
![](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/SHSegmentedControl_fixbug.gif)

### 2018.05.22新增demo(pod v1.1.8)，使用控制器的tableview作为内容视图↓↓↓
![](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/ChildVC.gif)

### 2018.04.09新增demo(pod v1.1.7)，头部下拉放大↓↓↓
![](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/headerScale.gif)

### 2018.04.02新增demo(pod v1.1.5)，bar放在头部上，滑动悬停↓↓↓
![](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/header_bar_stop.gif)


# 使用 Cocoapods 导入
SHSegmentedControl is available on [CocoaPods](http://cocoapods.org).  Add the following to your Podfile:

```ruby
pod 'SHSegmentedControl'
```

# 目录
1. [实现原理](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#实现的原理)
2. [基本用法](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#使用方法)
3. [下拉刷新](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#下拉刷新)
4. [混合模式](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#混合模式)
5. [示例代码](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#示例代码)
6. [Demo介绍](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/README.md#使用的详细用法示例)

## 实现的原理
>为了兼容下拉刷新，采用了UITableView作为容器的实现方式

### Mode

![Mode](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/model.png)

1. 使用`UITableView `作为容器，内容视图作为`Cell `，实现上下滑动滑动的功能。

2. 使用`UICollectionView`作为item的载体，实现左右滑动的功能。

3. 因为使用了`UITableView `作为容器，`Cell `上下滑动的时候，item之间的顶部对齐问题就迎刃而解。

4. `topView（header）`作为`UITableView `的`tableViewHeaderView `，`barView `作为`UITableView `的` sectionHeader`，这样就解决了item之间共享同一个header & bar，也解决header & bar跟随item滚动问题，也要具有ScrollView的弹性效果。

5. `footView（bottom）` 作为`UITableView `的` sectionFooter`，目的是为了作为扩展，用于可能需要的底部视图做一些操作。



## 使用用法


**如普通的UIView那样初始化即可**

```objc
[[SHSegmentedControlTableView alloc] initWithFrame:frame]    
```
>初始化一个SHSegmentedControlTableView的容器视图对象


**实现其代理方法** 

```
- (void)segTableViewDidScrollY:(CGFloat)offsetY;
``` 
> offsetY用于告知上下滑动的contentOffset.y的变化

```
- (void)segTableViewDidScroll:(UIScrollView *)tableView;
``` 
> tableView 为容器`UITableView `本身


```
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView;
``` 
> subTableView 为item


```
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;
```    
> progress为滑动的进度，originalIndex为前一个item下标，targetIndex滑动到新的item下标，originalIndex是有可能等于targetIndex，需要切换分栏时，判断targetIndex即可。


**可使用的`SHSegmentControl`作为`barView`**

```
[[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) items:@[@"分栏一",@"分栏二",@"分栏三"]]
```
>初始化一个SHSegmentControl的分栏视图对象


```
SHSegmentControl.curClick = ^(NSInteger index) {
    [weakSelf.segTableView setSegmentSelectIndex:index]
    //index用于切换item
};
```
>实现SHSegmentControl分栏视图的Block用于切换item


#### `备注`
当然`topView`、`barView`、`footView`也都是是可以使用自定义视图


## 刷新

**支持 下拉刷新 和 上拉加载**


**下拉刷新，需要配合`MJRefresh`来使用**

```
__weak __typeof(&*self)weakSelf = self;
MJRefreshNormalHeader *refreshAllHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
    //do somthing
    //weakSelf.segTableView.selectedIndex
}];
[self.segTableView setRefreshHeader:refreshAllHeader];
```
>设置一个`MJRefresh`下拉刷新
>配合selectedIndex使用可刷新单一item的数据


**上拉加载，自定义的item来处理**
>给单独的item设置一个`MJRefresh`上拉加载即可实现

**如果想要更好的扩展性，以及喜欢自己研究的同学，可以尝试修改代码或者自定义下拉控件来解决下拉刷新的兼容问题，同时这里提供一些思路：**

因为容器是`UITableView `，而且是作为属性公开的，

```
/** 主容器 */
@property (nonatomic, strong) SHMAINTableView *tableView;
```
因此，就像对待`UITableView `一样处理容器的刷新问题即可。


## 混合模式

在`UICollectionView `作为item载体的情况下，可扩展支持`UITableView`、`UICollectionView`、`UIScrollView`等各种视图。或者自定义视图作为item，只要是UIView的子类，可无限制支持。


## 示例代码

### 初始化并设置topView、barView、footView
```
_segTableView = [[SHSegmentedControlTableView alloc] initWithFrame:self.view.bounds];
_segTableView.delegateCell = self;
[_segTableView setTopView:self.headerView];
[_segTableView setBarView:self.segmentControl];
[_segTableView setBarView:self.footerView];
```

### 实现代理：
```
#pragma mark -
#pragma mark   ==============SHSegTableViewDelegate==============
- (void)segTableViewDidScrollY:(CGFloat)offsetY {

}
- (void)segTableViewDidScroll:(UIScrollView *)tableView {

}
- (void)segTableViewDidScrollSub:(UIScrollView *)subTableView {

}
- (void)segTableViewDidScrollProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    if (progress == 1) {
        [self.segmentControl setSegmentSelectedIndex:targetIndex];
    }
}
```

### `SHSegmentControl`使用方法：

**支持的属性的属性设置**

```
typedef enum : NSUInteger {
/** 默认状态 */
SHSegmentControlTypeNone,
/** 涌入放大效果 */
SHSegmentControlTypeWater,
/** 右上角小标题 */
SHSegmentControlTypeSubTitle,
/** 涌入放大效果+右上角小标题 */
SHSegmentControlTypeWaterSubTitle,
} SHSegmentControlType;

@interface SHSegmentControl : UIScrollView
/** 间距 */
@property (nonatomic, assign) CGFloat titleMargin;
/** 默认字体大小 (默认15) */
@property (nonatomic, assign) UIFont  *titleNormalFont;
/** 选中字体大小 (默认15) */
@property (nonatomic, assign) UIFont  *titleSelectFont;
/** 小标题字体大小 */
@property (nonatomic, assign) UIFont  *subTitleFont;
/** 字体默认颜色 */
@property (nonatomic, strong) UIColor *titleNormalColor;
/** 小标题默认字体颜色 */
@property (nonatomic, strong) UIColor *subTitleNormalColor;
/** 字体选中颜色 */
@property (nonatomic, strong) UIColor *titleSelectColor;
/** 小标题选中字体颜色 */
@property (nonatomic, strong) UIColor *subTitleSelectColor;
/** 指示器圆角 */
@property (nonatomic, assign) CGFloat progressCornerRadius;
/** 指示器高度 */
@property (nonatomic, assign) CGFloat progressHeight;
/** 指示器宽度（默认 title宽） */
@property (nonatomic, assign) CGFloat progressWidth;
/** 指示器颜色 */
@property (nonatomic, strong) UIColor *progressColor;
/** 分栏类型 */
@property (nonatomic, assign) SHSegmentControlType type;
```

**初始化**


```
_segmentControl = [[SHSegmentControl alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45) items:@[@"分栏一",@"分栏二",@"分栏三"]];
_segmentControl.titleSelectColor = [UIColor redColor];
_segmentControl.type = SHSegmentControlTypeWater;
[_segmentControl reloadViews];
[_segmentControl setSegmentSelectedIndex:0];
__weak __typeof(&*self)weakSelf = self;

_segmentControl.curClick = ^(NSInteger index) {
    //切换item
    [weakSelf.segTableView setSegmentSelectIndex:index];
};
```


## Demo 介绍
### 使用的详细用法示例：

- 默认样式
- 涌入放大
- 右上角小标题
- 涌入放大+右上角小标题
- 导航栏透明
- 无头部
- 无bar
- CollectionView
- tableView+collectionView
- 下拉刷新全部
- 下拉刷新当前选中
- 独立上拉加载
- 头部固定-scrollView容器
- bar放在头部上，滑动悬停
- 下拉头部放大
- 使用ChildVC的处理方式
- 分栏内容超屏显示


**示例代码新增和样式可点击图片查看，Demo中提支持刷新控件`MJRefresh `，支持约束库`Masonry `，以及部分扩展`SHExtension `，供参考**

**Demo的示例可能并不满足你当前的需求，请不用担心，联系下面的QQ，会尽可能的满足，感谢你的支持**



## QQ 479069761

##### 欢迎大家补充添加，有问题请联系企鹅号
##### 想获取更多组件，让你的开发更轻松，那赶快加入组件群746954046

## License

SHSegmentedControl is released under the MIT license. See [LICENSE](https://github.com/HatsuneMikuV/SHSegmentedControlTableView/blob/master/LICENSE) for details.
