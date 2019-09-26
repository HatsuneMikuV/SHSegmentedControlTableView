//
//  SHSegmentControl.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "SHSegmentControl.h"

const NSInteger tag = 20171010;

#pragma mark -
#pragma mark   ==============SHTapButtonView==============
@interface SHTapButtonView : UIView

/** 字体大小 */
@property (nonatomic, assign) UIFont  * _Nonnull titleFont;
/** 小标题字体大小 */
@property (nonatomic, assign) UIFont  * _Nonnull subTitleFont;
/** 字体默认颜色 */
@property (nonatomic, strong) UIColor * _Nonnull titleNormalColor;
/** 小标题默认字体颜色 */
@property (nonatomic, strong) UIColor * _Nonnull subTitleNormalColor;
/** 字体选中颜色 */
@property (nonatomic, strong) UIColor * _Nonnull titleSelectColor;
/** 小标题选中字体颜色 */
@property (nonatomic, strong) UIColor * _Nonnull subTitleSelectColor;
/** 选中 */
@property (nonatomic, assign) BOOL selected;
/** 隐藏小标题 (默认隐藏 yes) */
@property (nonatomic, assign) BOOL subHide;
/** 标题 */
@property (nonatomic, copy) NSString * _Nonnull title;
/** 小标题 */
@property (nonatomic, copy) NSString * _Nonnull subTitle;

/** 点击事件回调block */
@property (nonatomic, copy) void(^ _Nonnull tapClick)(SHTapButtonView * _Nonnull btn);

/** 更新subLabel的frame */
@property (nonatomic, copy) void(^ _Nonnull reloadSubTitleBlock)(UILabel *titleLabel, UILabel *subLabel);

@property (nonatomic, strong) UILabel * _Nonnull titleL;
@property (nonatomic, strong) UILabel * _Nonnull subTitleL;

@end

@implementation SHTapButtonView

- (instancetype)init {
    if (self = [super init]) {
        
        [self addSubview:self.titleL];
        [self addSubview:self.subTitleL];
        [self.titleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapActionClick:)];
        [self addGestureRecognizer:tap];
        
        self.subHide = YES;
    }
    return self;
}
- (void)tapActionClick:(UITapGestureRecognizer *)tap {
    if (self.tapClick) {
        self.tapClick(self);
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.reloadSubTitleBlock) {
        [self.subTitleL sizeToFit];
        self.reloadSubTitleBlock(self.titleL, self.subTitleL);
    } else {
        [self.subTitleL mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.titleL.mas_centerX);
            make.top.equalTo(self.titleL.mas_bottom);
        }];
    }
}
#pragma mark -
#pragma mark   ==============Private==============
- (void)transformAniamtion:(BOOL)animation reset:(BOOL)isReset scale:(CGFloat)scale
{
    if (isReset) {
        [UIView animateWithDuration:0.25 animations:^{
            self.titleL.transform = CGAffineTransformIdentity;
            self.subTitleL.transform = CGAffineTransformIdentity;
        }];
    } else {
        [self layoutIfNeeded];
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        CGFloat x = (scale - 1) * (self.subTitleL.sh_centerX - self.titleL.sh_centerX);
        CGFloat y = (scale - 1) * (self.subTitleL.sh_centerY - self.titleL.sh_centerY);
        if (animation) {
            [UIView animateWithDuration:0.25 animations:^{
                self.titleL.transform = CGAffineTransformMakeScale(scale, scale);
                self.subTitleL.transform = CGAffineTransformTranslate(transform, x, y);
            }];
        }else {
            self.titleL.transform = CGAffineTransformMakeScale(scale, scale);
            self.subTitleL.transform = CGAffineTransformTranslate(transform, x, y);
        }
    }
}
#pragma mark -
#pragma mark   ==============set==============
- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    self.titleL.font = titleFont;
}
- (void)setSubTitleFont:(UIFont *)subTitleFont {
    _subTitleFont = subTitleFont;
    self.subTitleL.font = subTitleFont;
}
- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    self.titleL.textColor = titleNormalColor;
}
- (void)setTitleSelectColor:(UIColor *)titleSelectColor {
    _titleSelectColor = titleSelectColor;
    self.titleL.highlightedTextColor = titleSelectColor;
}
- (void)setSubTitleNormalColor:(UIColor *)subTitleNormalColor {
    _subTitleNormalColor = subTitleNormalColor;
    self.subTitleL.textColor = subTitleNormalColor;
}
- (void)setSubTitleSelectColor:(UIColor *)subTitleSelectColor {
    _subTitleSelectColor = subTitleSelectColor;
    self.subTitleL.highlightedTextColor = subTitleSelectColor;
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleL.text = title;
}
- (void)setSubTitle:(NSString *)subTitle {
    _subTitle = subTitle;
    self.subTitleL.text = subTitle;
}
- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.titleL.highlighted = selected;
    self.subTitleL.highlighted = selected;
}
- (void)setSubHide:(BOOL)subHide {
    _subHide = subHide;
    self.subTitleL.hidden = subHide;
}
#pragma mark -
#pragma mark   ==============UI-lazy==============
- (UILabel *)titleL {
    if (!_titleL) {
        _titleL = [[UILabel alloc] init];
        _titleL.textAlignment = NSTextAlignmentCenter;
    }
    return _titleL;
}
- (UILabel *)subTitleL {
    if (!_subTitleL) {
        _subTitleL = [[UILabel alloc] init];
    }
    return _subTitleL;
}

@end


@interface SHSegmentControl ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentView;

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray<SHTapButtonView *> *btnArray;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) UIImageView *lineV;

@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic,strong) SHTapButtonView *selectBtn;

@end

@implementation SHSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self init_setup];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.progressView];
        self.lineV.frame = CGRectMake(0, frame.size.height - self.bottomLineHeight, frame.size.width, self.bottomLineHeight);
        [self addSubview:self.lineV];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    if (self = [super initWithFrame:frame]) {
        
        self.titleArray = items.mutableCopy;
        
        [self init_setup];
        self.contentView.frame = self.bounds;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.progressView];
        
        [self addSubview];
        self.lineV.frame = CGRectMake(0, frame.size.height - self.bottomLineHeight, frame.size.width, self.bottomLineHeight);
        [self addSubview:self.lineV];
    }
    return self;
}
- (void)init_setup {
    
    _titleMargin = 0;
    _titleNormalFont  = [UIFont sh_pingFangSCFontOfSize:15];
    _titleSelectFont  = [UIFont sh_pingFangSCFontOfSize:15];
    _titleNormalColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _titleSelectColor = [UIColor blackColor];
    _subTitleFont     = [UIFont sh_pingFangSCFontOfSize:10];
    
    _progressColor = [UIColor lightGrayColor];
    _progressCornerRadius = 1.5f;
    _progressWidth = 65.f;
    _progressHeight = 3.f;
    _bottomLineColor = [UIColor sh_colorWithHexString:@"#DEDEDE"];
    _bottomLineHeight = 0.5f;
    _curIndex = 0;
    _type = SHSegmentControlTypeNone;
    _style = SHSegmentControlStyleScatter;
    _itemScale = 1.2;
    _progressBottom = 0.f;
    
    self.backgroundColor = [UIColor whiteColor];
}
#pragma mark -
#pragma mark   ==============addSubview==============
- (void)addSubview {
    [self.btnArray removeAllObjects];
    for (NSInteger index = 0; index < self.titleArray.count; index++) {
        NSString *title = self.titleArray[index];
        SHTapButtonView *selectBtn = [[SHTapButtonView alloc] init];
        selectBtn.title = title;
        selectBtn.tag = tag + index;
        __weak __typeof(self)weakSelf = self;
        selectBtn.tapClick = ^(SHTapButtonView *btn) {
            [weakSelf btnClick:btn isBlock:YES];
        };
        [self.contentView addSubview:selectBtn];
        [self.btnArray addObject:selectBtn];
    }
}
#pragma mark -
#pragma mark   ==============restItmes==============
- (void)restItmes:(NSArray<NSString *> *)items {
    self.titleArray = items.mutableCopy;
    [self.btnArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self addSubview];
    [self reloadViews];
}
- (void)setSegmentSelectedIndex:(NSInteger)index {
    if (index < self.btnArray.count) {
        [self btnClick:self.btnArray[index] isBlock:NO];
    }
}
- (NSInteger)totalCount {
    return self.titleArray.count;
}
- (NSInteger)selectIndex {
    return self.curIndex;
}
- (void)setMenuItemWidth:(CGFloat)menuItemWidth
{
    _menuItemWidth = menuItemWidth;
    
    NSMutableArray *itemsWidths = [NSMutableArray array];
    for (NSInteger index = 0; index < self.btnArray.count; index++) {
        [itemsWidths addObject:@(menuItemWidth)];
    }
    self.itemsWidths = [itemsWidths copy];
}
#pragma mark -
#pragma mark   ==============setItmesSubTitle==============
- (void)setItmesSubTitle:(NSArray<NSString *> *)items {
    if (items.count == self.titleArray.count && items.count > 0 && (self.type == SHSegmentControlTypeSubTitle || self.type == SHSegmentControlTypeWaterSubTitle)) {
        for (NSInteger index = 0; index < items.count; index++) {
            NSString *subTitle = items[index];
            SHTapButtonView *btn = self.btnArray[index];
            btn.reloadSubTitleBlock = self.reloadSubTitleBlock;
            btn.subTitle = subTitle;
        }
    }
}
#pragma mark -
#pragma mark   ==============btnClick==============
- (void)btnClick:(SHTapButtonView *)btn isBlock:(BOOL)isRun{
    
    //恢复按钮初始状态
    for (SHTapButtonView *btns in self.btnArray) {
        btns.selected = NO;
        btns.titleFont = self.titleNormalFont;
        if (self.type == SHSegmentControlTypeWater || self.type == SHSegmentControlTypeWaterSubTitle) {
            [btns transformAniamtion:NO reset:YES scale:1];
        }
    }
    
    //按钮放大效果
    if (self.type == SHSegmentControlTypeWater || self.type == SHSegmentControlTypeWaterSubTitle) {
        [btn transformAniamtion:isRun reset:NO scale:self.itemScale];
    }
    
    //移动下划线
    CGRect frame = self.progressView.frame;
    CGFloat titleWidth = ceilf([btn.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleSelectFont} context:nil].size.width) + 30;
    frame.size.width = self.progressWidth > 0 ? self.progressWidth : titleWidth;
    frame.origin.x = btn.sh_centerX - frame.size.width * 0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.frame = frame;
    } completion:^(BOOL finished) {
        btn.selected = YES;
        btn.titleFont = self.titleSelectFont;
    }];
    
    //横向内容超屏后，判断按钮中心位置，改变contentOffset
    if (self.contentView.contentSize.width > self.sh_width) {
        //居左
        CGFloat offsetX = btn.sh_centerX- self.sh_width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        
        //居右
        CGFloat maxOffsetX = self.contentView.contentSize.width - self.sh_width;
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        [self.contentView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    self.curIndex = btn.tag - tag;
    
    if (self.type == SHSegmentControlTypeSubTitle) {
        self.selectBtn.backgroundColor = self.backgroundNormalColor;
        btn.backgroundColor = self.backgroundSelectColor;
        self.selectBtn = btn;
    }
    
    if (isRun) {
        if (self.curClick) {
            self.curClick(self.curIndex);
        }
    }
}
#pragma mark -
#pragma mark   ==============reloadViews==============
- (void)reloadViews {
    
    if (self.titleArray.count == self.btnArray.count && self.titleArray.count > 0) {
        UIView *lastView = nil;
        
        for (NSInteger index = 0; index < self.btnArray.count; index++) {
            SHTapButtonView *btn = self.btnArray[index];
            
            if (self.type == SHSegmentControlTypeSubTitle) {
                btn.backgroundColor = self.backgroundNormalColor;
                //设置圆角的半径
                [btn.layer setCornerRadius:5];
                
                //切割超出圆角范围的子视图
                btn.layer.masksToBounds = YES;
            }
            
            btn.subHide = !(self.type == SHSegmentControlTypeSubTitle || self.type == SHSegmentControlTypeWaterSubTitle);
            btn.subTitleFont = self.subTitleFont;
            btn.subTitleNormalColor = self.subTitleNormalColor;
            btn.subTitleSelectColor = self.subTitleSelectColor;
            btn.titleFont = self.titleNormalFont;
            btn.titleNormalColor = self.titleNormalColor;
            btn.titleSelectColor = self.titleSelectColor;
            NSString *title = self.titleArray[index];
            
            CGFloat btnW = ceilf([title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn.titleFont} context:nil].size.width) + 30;
            if (self.itemsWidths.count == self.titleArray.count) {
                btnW = [self.itemsWidths[index] floatValue];
            }
            CGFloat btnY = 5;
            CGFloat btnH = self.sh_height - self.progressHeight - btnY;
            CGFloat btnX = CGRectGetMaxX(lastView.frame) + self.titleMargin;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.selected = (index == 0);
            lastView = btn;
        }
        //总宽小于父视图宽
        if (CGRectGetMaxX(lastView.frame) < self.sh_width) {
            if (SHSegmentControlStyleLeft == self.style) {
                
            } else if (SHSegmentControlStyleCenter == self.style) {
                if (self.btnArray.count % 2 == 0) {//偶数
                    CGFloat centerXLeft = self.sh_width * 0.5;
                    CGFloat centerXRight = self.sh_width * 0.5;
                    for (NSInteger index = self.btnArray.count / 2; index < self.btnArray.count; index++) {
                        SHTapButtonView *btnLeft = self.btnArray[self.btnArray.count - 1 - index];
                        SHTapButtonView *btnRight = self.btnArray[index];
                        centerXLeft = centerXLeft - (self.titleMargin + btnLeft.sh_width);
                        btnLeft.sh_x = centerXLeft;
                        
                        btnRight.sh_x = centerXRight;
                        centerXRight = centerXRight + (self.titleMargin + btnRight.sh_width);
                    }
                } else {//奇数
                    SHTapButtonView *btnCenter = self.btnArray[self.btnArray.count / 2];
                    btnCenter.sh_x = self.sh_width * 0.5 - btnCenter.sh_width * 0.5;
                    CGFloat centerXLeft = btnCenter.sh_x - self.titleMargin;
                    CGFloat centerXRight = btnCenter.sh_x + btnCenter.sh_width + self.titleMargin;
                    for (NSInteger index = self.btnArray.count / 2; index < self.btnArray.count - 1; index++) {
                        SHTapButtonView *btnLeft = self.btnArray[self.btnArray.count - 2 - index];
                        SHTapButtonView *btnRight = self.btnArray[index + 1];
                        centerXLeft = centerXLeft - (self.titleMargin + btnLeft.sh_width);
                        btnLeft.sh_x = centerXLeft;
                        btnRight.sh_x = centerXRight;
                        centerXRight = centerXRight + (self.titleMargin + btnRight.sh_width);
                    }
                }
            } else if (SHSegmentControlStyleRight == self.style) {
                CGFloat minX = self.sh_width;
                for (NSInteger index = self.btnArray.count - 1; index >= 0; index--) {
                    SHTapButtonView *btn = self.btnArray[index];
                    minX = minX - (self.titleMargin + btn.sh_width);
                    btn.sh_x = minX;
                }
            } else if (SHSegmentControlStyleScatter == self.style) {
                CGFloat btnW = (self.sh_width - self.titleMargin * (self.btnArray.count + 1)) / self.btnArray.count;
                CGFloat btnY = 5;
                CGFloat btnH = self.sh_height - self.progressHeight - btnY;
                for (NSInteger index = 0; index < self.btnArray.count; index++) {
                    SHTapButtonView *btn = self.btnArray[index];
                    CGFloat btnX = self.titleMargin + (self.titleMargin + btnW) * index;
                    btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
                }
            }
        }
        
        self.contentView.contentSize = CGSizeMake(CGRectGetMaxX(lastView.frame) + self.titleMargin, 0);
        self.progressView.layer.cornerRadius = self.progressCornerRadius;
        self.progressView.backgroundColor = self.progressColor;
        
        CGFloat titleWidth = ceilf([[self.titleArray firstObject] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleSelectFont} context:nil].size.width) + 30;
        
        self.progressWidth = self.progressWidth > 0 ? self.progressWidth : titleWidth;
        CGFloat progressX = [self.btnArray firstObject].sh_centerX - self.progressWidth * 0.5;
        CGFloat progressY = self.sh_height - self.progressHeight - self.bottomLineHeight - self.progressBottom;
        self.progressView.frame = CGRectMake(progressX, progressY, self.progressWidth, self.progressHeight);
    }
    self.lineV.backgroundColor = self.bottomLineColor;
}
#pragma mark -
#pragma mark   ==============lazy==============
- (UIScrollView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.delegate = self;
    }
    return _contentView;
}
- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.clipsToBounds = YES;
    }
    return _progressView;
}
- (UIImageView *)lineV {
    if (!_lineV) {
        _lineV = [[UIImageView alloc] init];
        _lineV.backgroundColor = self.bottomLineColor;
    }
    return _lineV;
}
- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
@end
