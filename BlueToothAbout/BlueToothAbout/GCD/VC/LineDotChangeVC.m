//
//  LineDotChangeVC.m
//  Finance
//
//  Created by lp on 16/11/25.
//  Copyright © 2016年 guest. All rights reserved.
//

#import "LineDotChangeVC.h"

#import "PathBuilderView.h"
#import "ShapeView.h"

static CFTimeInterval const kDuration = 2.0;
static CFTimeInterval const kInitialTimeOffset = 2.0;


@interface LineDotChangeVC ()
@property (nonatomic, strong) PathBuilderView *pathBuilderView;
@end

@implementation LineDotChangeVC



-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
     [self drawPathButtonTapped];
    
    
    if (_PointValueArray) {
        
        for (int i=0; i<_PointValueArray.count; i++) {
            
            
            
            NSValue* pointValue=[_PointValueArray objectAtIndex:i];
            
 
            [_pathBuilderView.points addObject:pointValue];
        }
    }
    
    
    
    CGPoint p1 =CGPointMake(70, 200);
    CGPoint p2 =CGPointMake(180, 190);
    CGPoint p3 =CGPointMake(90, 380);
    CGPoint p4 =CGPointMake(300, 270);
    NSValue *xy1= [NSValue valueWithCGPoint:p1];
    NSValue *xy2= [NSValue valueWithCGPoint:p2];
    NSValue *xy3= [NSValue valueWithCGPoint:p3];
    NSValue *xy4= [NSValue valueWithCGPoint:p4];
    [_pathBuilderView.points addObject:xy1];
    [_pathBuilderView.points addObject:xy2];
    [_pathBuilderView.points addObject:xy3];
    [_pathBuilderView.points addObject:xy4];
    
    [_pathBuilderView updatePaths];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.pathBuilderView = [[PathBuilderView alloc] init];
    self.pathBuilderView.frame= CGRectMake(0, 0, 347, 768);
    
    [self.view addSubview:_pathBuilderView];
    
    
    self.pathBuilderView.pathShapeView.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    self.pathBuilderView.prospectivePathShapeView.shapeLayer.strokeColor = [UIColor grayColor].CGColor;
//    self.pathBuilderView.pointsShapeView.shapeLayer.strokeColor = [UIColor redColor].CGColor;
    self.pathBuilderView.pointsShapeView.shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.removedOnCompletion = NO;
    animation.duration = kDuration;
    [self.pathBuilderView.pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    self.pathBuilderView.pathShapeView.shapeLayer.speed = 0;
    self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = 0.0;
    
    [CATransaction flush];
    
    self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = kInitialTimeOffset;
    
    
    
    
    
    
    /*
     
     
     */
    
    UISwitch *showDotsSwitch = [[UISwitch alloc] init];
    showDotsSwitch.on = YES;
    [showDotsSwitch addTarget:self action:@selector(showDotsSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    showDotsSwitch.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:showDotsSwitch];
    
    UILabel *showDotsLabel = [[UILabel alloc] init];
    showDotsLabel.text = NSLocalizedString(@"Show dots", nil);
    showDotsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:showDotsLabel];
    
    UISlider *strokeEndSlider = [[UISlider alloc] init];
    strokeEndSlider.minimumValue = 0.0;
    strokeEndSlider.maximumValue = kDuration;
    strokeEndSlider.value = kInitialTimeOffset;
    strokeEndSlider.continuous = YES;
    [strokeEndSlider addTarget:self action:@selector(strokeEndSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    strokeEndSlider.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:strokeEndSlider];
    
//    showDotsSwitch.hidden=YES;//隐藏 switch
//    showDotsLabel.hidden=YES;//隐藏 lab
//    strokeEndSlider.hidden=YES;//隐藏 slider
    
    CGRect frame = CGRectMake(0, 70, 72, 37);
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:@"上一页" forState: UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    button.tag = 2000;
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    /* button.layer.borderWidth=1.0;
     button.layer.borderColor=[UIColor yellowColor].CGColor;
     button.layer.cornerRadius=80*KScaleFactor/2;
     button.layer.masksToBounds=YES;
     */
    
    
    UIButton *drawPathButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [drawPathButton setTitle:NSLocalizedString(@"Draw Path", nil) forState:UIControlStateNormal];
    [drawPathButton addTarget:self action:@selector(drawPathButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    drawPathButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:drawPathButton];
    
    drawPathButton.backgroundColor=[UIColor redColor];
   
    
//     drawPathButton.hidden=YES;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(showDotsLabel, showDotsSwitch, drawPathButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[showDotsLabel]-[showDotsSwitch]->=20-[drawPathButton]-|"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[showDotsSwitch]-|" options:0 metrics:nil views:views]];
    
    id topLayoutGuide = self.topLayoutGuide;
    views = NSDictionaryOfVariableBindings(strokeEndSlider, topLayoutGuide);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[strokeEndSlider]-|"
                                                                      options:NSLayoutFormatAlignAllCenterY
                                                                      metrics:nil
                                                                        views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayoutGuide][strokeEndSlider]" options:0 metrics:nil views:views]];
}

-(void)buttonClicked{

[self dismissViewControllerAnimated:YES completion:^{
    
}];
}

//- (PathBuilderView *)pathBuilderView
//{
//    return (PathBuilderView *)self.view;
//}

- (void)showDotsSwitchValueChanged:(UISwitch *)showDotsSwitch
{
    [UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.pathBuilderView.pointsShapeView.alpha = showDotsSwitch.on ? 1.0 : 0.0;
                     }
                     completion:nil];
}

- (void)strokeEndSliderValueChanged:(UISlider *)strokeEndSlider
{
    self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = strokeEndSlider.value;
}

- (void)drawPathButtonTapped
{
    CFTimeInterval timeOffset = self.pathBuilderView.pathShapeView.shapeLayer.timeOffset;
    [CATransaction setCompletionBlock:^{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
        animation.fromValue = @0.0;
        animation.toValue = @1.0;
        animation.removedOnCompletion = NO;
        animation.duration = kDuration;
        self.pathBuilderView.pathShapeView.shapeLayer.speed = 0;
        self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = 0;
        [self.pathBuilderView.pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
        [CATransaction flush];
        self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = timeOffset;
    }];
    
    self.pathBuilderView.pathShapeView.shapeLayer.timeOffset = 1.0;
    self.pathBuilderView.pathShapeView.shapeLayer.speed = 1.0;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0.0;
    animation.toValue = @1.0;
    animation.duration = kDuration;
    
    [self.pathBuilderView.pathShapeView.shapeLayer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
}


@end
