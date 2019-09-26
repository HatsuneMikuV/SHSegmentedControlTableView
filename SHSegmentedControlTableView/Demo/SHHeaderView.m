//
//  SHHeaderView.m
//  SHSegmentedControlTableView
//
//  Created by angle on 2018/4/9.
//  Copyright © 2018 angle. All rights reserved.
//

#import "SHHeaderView.h"


@interface SHHeaderView ()

@property (nonatomic, strong) UIImageView *imageView;


@end


@implementation SHHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.frame = self.bounds;
        [self addSubview:self.imageView];
        
        CGFloat width = frame.size.width;
        CGFloat height = frame.size.height;
        
        __weak __typeof(&*self)weakSelf = self;
        self.scaleHeaderBlock = ^(CGFloat scaleH) {
            if (scaleH >= 0) {
                CGFloat imgH = scaleH + height;
                CGFloat imgW = width * imgH / height;
                CGFloat imgX = (width - imgW) * 0.5;
                CGFloat imgY = -scaleH;
                weakSelf.imageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
            }
        };
    }
    return self;
}


#pragma mark -
#pragma mark   ==============lazy==============
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123"]];
    }
    return _imageView;
}

@end


@interface SHHeaderOneView ()

@property (nonatomic, strong) UIButton *changeHButton;

@end


@implementation SHHeaderOneView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.changeHButton.frame = CGRectMake(200, 150, 80, 40);
        [self addSubview:self.changeHButton];
    }
    return self;
}

- (void)click:(UIButton *)btn {
    btn.selected = !btn.selected;
    /**
     这里需要注意的是，高度必须是0.5的整数倍，保证头部的高度也是0.5的整数倍，防止系统浮点计算取余导致滑动时判断出错，
     比如设置头部高度为200.6，设置后的头部高度实际为200.5999（9循环），然后mainTableview的contentoffset的y值则是200.5
     导致的结果就是mainTableview.contentoffset.y  一直小于  headerView.height
     因此建议值必须是0.5的整数倍，或者可以使用向上取整函数ceilf();
     */
    if (btn.selected) {
        self.sh_height += ceilf(50.5);
    }else {
        self.sh_height -= ceilf(50.5);
    }
    if (self.changeHeightBlock) {
        self.changeHeightBlock();
    }
}

#pragma mark -
#pragma mark   ==============lazy==============
- (UIButton *)changeHButton {
    if (!_changeHButton) {
        _changeHButton = [[UIButton alloc] init];
        _changeHButton.backgroundColor = [UIColor cyanColor];
        [_changeHButton setTitle:@"全文增高" forState:UIControlStateNormal];
        [_changeHButton setTitle:@"收起减矮" forState:UIControlStateSelected];
        [_changeHButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_changeHButton addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeHButton;
}

@end

