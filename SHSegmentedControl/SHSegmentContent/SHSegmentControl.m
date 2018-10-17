//
//  SHSegmentControl.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2017/10/10.
//  Copyright © 2017年 angle. All rights reserved.
//

#import "SHSegmentControl.h"


@interface SHSegmentControl ()

@property (nonatomic, strong) NSMutableArray *titleArray;

@property (nonatomic, strong) NSMutableArray<SHTapButtonView *> *btnArray;

@property (nonatomic, strong) UIView *progressView;

@property (nonatomic, strong) UIImageView *lineV;

@property (nonatomic, assign) NSInteger curIndex;

@end

const NSInteger tag = 20171010;

@implementation SHSegmentControl

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        [self init_setup];
        [self addSubview:self.progressView];
        self.lineV.frame = CGRectMake(0, frame.size.height - self.bottomLineHeight, frame.size.width, self.bottomLineHeight);
        [self addSubview:self.lineV];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    if (self = [super initWithFrame:frame]) {
        
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.titleArray = items.mutableCopy;
        
        [self init_setup];
        [self addSubview:self.progressView];
        
        [self addSubview];
        self.lineV.frame = CGRectMake(0, frame.size.height - self.bottomLineHeight, frame.size.width, self.bottomLineHeight);
        [self addSubview:self.lineV];
    }
    return self;
}
- (void)init_setup {
    
    _titleMargin = 0;
    _titleNormalFont  = [UIFont pingFangSCFontOfSize:15];
    _titleSelectFont  = [UIFont pingFangSCFontOfSize:15];
    _titleNormalColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    _titleSelectColor = [UIColor blackColor];
    _subTitleFont     = [UIFont pingFangSCFontOfSize:10];
    
    _progressColor = [UIColor lightGrayColor];
    _progressCornerRadius = 1.5f;
    _progressWidth = 65.f;
    _progressHeight = 3.f;
    _bottomLineColor = [UIColor colorWithHexString:@"#DEDEDE"];
    _bottomLineHeight = 0.5f;
    _curIndex = 0;
    _type = SHSegmentControlTypeNone;
    
    
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
        selectBtn.tapClick = ^(SHTapButtonView *btn) {
            [self btnClick:btn isBlock:YES];
        };
        [self addSubview:selectBtn];
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
#pragma mark -
#pragma mark   ==============setItmesSubTitle==============
- (void)setItmesSubTitle:(NSArray<NSString *> *)items {
    if (items.count == self.titleArray.count && items.count > 0 && (self.type == SHSegmentControlTypeSubTitle || self.type == SHSegmentControlTypeWaterSubTitle)) {
        for (NSInteger index = 0; index < items.count; index++) {
            NSString *subTitle = items[index];
            SHTapButtonView *btn = self.btnArray[index];
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
            btns.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }
    }
    
    //按钮放大效果
    if (self.type == SHSegmentControlTypeWater || self.type == SHSegmentControlTypeWaterSubTitle) {
        if (isRun) {
            [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
            [UIView setAnimationDuration:0.25];
            btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
            [UIView commitAnimations];
        }else {
            btn.transform = CGAffineTransformMakeScale(1.2, 1.2);
        }
    }
    
    //移动下划线
    CGRect frame = self.progressView.frame;
    CGFloat titleWidth = ceilf([btn.title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleSelectFont} context:nil].size.width) + 30;
    frame.size.width = self.progressWidth > 0 ? self.progressWidth : titleWidth;
    frame.origin.x = btn.centerX - frame.size.width * 0.5;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.frame = frame;
    } completion:^(BOOL finished) {
        btn.selected = YES;
        btn.titleFont = self.titleSelectFont;
    }];
    
    //横向内容超屏后，判断按钮中心位置，改变contentOffset
    if (self.contentSize.width > self.width) {
        //居左
        CGFloat offsetX = btn.centerX- self.width * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        }
        
        //居右
        CGFloat maxOffsetX = self.contentSize.width - self.width;
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
    
    self.curIndex = btn.tag - tag;
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
            btn.subHide = !(self.type == SHSegmentControlTypeSubTitle || self.type == SHSegmentControlTypeWaterSubTitle);
            btn.subTitleFont = self.subTitleFont;
            btn.subTitleNormalColor = self.subTitleNormalColor;
            btn.subTitleSelectColor = self.subTitleSelectColor;
            btn.titleFont = self.titleNormalFont;
            btn.titleNormalColor = self.titleNormalColor;
            btn.titleSelectColor = self.titleSelectColor;
            NSString *title = self.titleArray[index];
            
            CGFloat btnW = ceilf([title boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:btn.titleFont} context:nil].size.width) + 30;
            CGFloat btnH = self.height - self.progressHeight - 10;
            CGFloat btnX = CGRectGetMaxX(lastView.frame) + self.titleMargin;
            CGFloat btnY = 5;
            
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            
            btn.selected = (index == 0);
            lastView = btn;
        }
        //总宽小于父视图宽
        if (CGRectGetMaxX(lastView.frame) < self.width) {
            CGFloat btnW = (self.width - self.titleMargin * (self.btnArray.count + 1)) / self.btnArray.count;
            CGFloat btnH = self.height - self.progressHeight - 10;
            CGFloat btnY = 5;
            
            for (NSInteger index = 0; index < self.btnArray.count; index++) {
                CGFloat btnX = self.titleMargin + (self.titleMargin + btnW) * index;
                SHTapButtonView *btn = self.btnArray[index];
                btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
                lastView = btn;
            }
        }
        
        self.contentSize = CGSizeMake(CGRectGetMaxX(lastView.frame) + self.titleMargin, 0);
        self.progressView.layer.cornerRadius = self.progressCornerRadius;
        self.progressView.backgroundColor = self.progressColor;
        
        CGFloat titleWidth = ceilf([[self.titleArray firstObject] boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleSelectFont} context:nil].size.width) + 30;
        
        self.progressWidth = self.progressWidth > 0 ? self.progressWidth : titleWidth;
        CGFloat progressX = [self.btnArray firstObject].centerX - self.progressWidth * 0.5;
        self.progressView.frame = CGRectMake(progressX, self.height - self.progressHeight - self.bottomLineHeight, self.progressWidth, self.progressHeight);
    }
    self.lineV.frame = CGRectMake(0, self.height - self.bottomLineHeight, self.width, self.bottomLineHeight);
    self.lineV.backgroundColor = self.bottomLineColor;
}
#pragma mark -
#pragma mark   ==============lazy==============
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


#pragma mark -
#pragma mark   ==============SHTapButtonView==============
@interface SHTapButtonView ()

@property (nonatomic, strong) UILabel *titleL;
@property (nonatomic, strong) UILabel *subTitleL;

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
        
        [self.subTitleL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleL.mas_right);
            make.top.equalTo(self.titleL.mas_top);
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

