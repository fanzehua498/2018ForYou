//
//  PathBuilderView.h
//  Finance
//
//  Created by lp on 16/11/25.
//  Copyright © 2016年 guest. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ShapeView;

@interface PathBuilderView : UIView

@property (nonatomic, strong, readonly) ShapeView *pathShapeView;
@property (nonatomic, strong, readonly) ShapeView *prospectivePathShapeView;
@property (nonatomic, strong, readonly) ShapeView *pointsShapeView;


@property (nonatomic, strong) NSMutableArray *points;
- (void)updatePaths;

@end
