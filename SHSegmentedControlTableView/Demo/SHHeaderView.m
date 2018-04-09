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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark -
#pragma mark   ==============lazy==============
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"123"]];
    }
    return _imageView;
}

@end
