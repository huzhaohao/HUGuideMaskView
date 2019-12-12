//
//  ViewController.m
//  GuideMaskView
//
//  Created by huzhaohao on 2019/12/11.
//  Copyright © 2019 huzhaohao. All rights reserved.
//

#import "ViewController.h"
#import "GuideMaskView.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIButton *tapBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:0.99 alpha:1];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated {
  [self setupGuideView];
}
- (void)setupGuideView{
    NSArray * imageArr = @[@"image_01",@"image_02",@"image_03"];
    CGRect rect1 = self.textLabel.frame;
    CGRect rect2 = self.tapBtn.frame;
    CGRect rect3 = self.bgImg.frame;
    NSArray * imgFrameArr = @[
                              [NSValue valueWithCGRect:CGRectMake(rect1.origin.x-118, CGRectGetMaxY(rect1)-123, 118, 123)],
                              [NSValue valueWithCGRect:CGRectMake(CGRectGetMaxX(rect2), rect2.origin.y-108, 206, 108)],
                              [NSValue valueWithCGRect:CGRectMake(CGRectGetMaxX(rect3)-80, CGRectGetMaxY(rect3), 144 , 113)]
                              ];
    NSArray * transparentRectArr = @[[NSValue valueWithCGRect:rect1],[NSValue valueWithCGRect:rect2],[NSValue valueWithCGRect:rect3]];
    // @[@3]
    // @[@1,@1,@1]
    // @[@1,@2]
    NSArray * orderArr =  @[@1,@2];
    GuideMaskView *maskView = [GuideMaskView new];
    [maskView addImages:imageArr imageFrame:imgFrameArr TransparentRect:transparentRectArr orderArr:orderArr];
    [maskView showMaskViewInView:self.view];
}
@end
