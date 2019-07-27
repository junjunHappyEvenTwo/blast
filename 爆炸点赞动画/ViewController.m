//
//  ViewController.m
//  爆炸点赞动画
//
//  Created by wyx on 2019/7/27.
//  Copyright © 2019年 wyx. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *blastBtn;
@property (nonatomic,strong) CAEmitterLayer *emmiLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_blastBtn setImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
     [_blastBtn setImage:[UIImage imageNamed:@"点赞后"] forState:UIControlStateSelected];
    [self  explosition];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)explosition{
    _emmiLayer = [CAEmitterLayer layer];
    CAEmitterCell *cell = [[CAEmitterCell alloc]init];
    cell.name = @"blast";
    cell.lifetime = .5;
    cell.birthRate = 1000;
    cell.velocity = 80;
    cell.velocityRange = 100;
    cell.scale = .03;
    cell.scaleRange = .01;
    cell.contents = (id)[UIImage imageNamed:@"sparkle"].CGImage;
    _emmiLayer.name = @"blost";
    _emmiLayer.emitterShape = kCAEmitterLayerCircle;
    _emmiLayer.emitterMode = kCAEmitterLayerOutline;
    _emmiLayer.emitterSize = CGSizeMake(20, 0);
    _emmiLayer.emitterCells = @[cell];
    _emmiLayer.birthRate = 0;
    _emmiLayer.renderMode = kCAEmitterLayerOldestFirst;
    _emmiLayer.position = CGPointMake(CGRectGetWidth(_blastBtn.frame)/2, CGRectGetHeight(_blastBtn.bounds)/2);
    [_blastBtn.layer addSublayer:_emmiLayer];
    
}
- (IBAction)click:(UIButton *)sender {
    sender.selected = !sender.selected;
    CAKeyframeAnimation *anno = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    if (sender.selected) {
        anno.values = @[@(1.5),@(0.8),@1,@1.2,@1];
        anno.duration = .6;
         [self addAnimation];
    }else{
        anno.values = @[@(0.1),@(0.5),@1];
        anno.duration = .4;
    }
    [_blastBtn.layer addAnimation:anno forKey:nil];
}

- (void)addAnimation{
    _emmiLayer.beginTime = CACurrentMediaTime();
    _emmiLayer.birthRate = 1;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _emmiLayer.birthRate = 0;
    });
    
}
@end
