//
//  GRPBallView.m
//  TestViews
//
//  Created by Алексей on 05/06/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import "GRPBallView.h"

@interface GRPBallView ()

@property (nonatomic, assign) CGFloat ballRadius;
@property (nonatomic, strong) UIColor *ballColor;

@end


@implementation GRPBallView

- (instancetype)initWithRadius:(CGFloat)radius andColor:(UIColor *)color
{
    self = [super initWithFrame:CGRectMake(0, 0, radius*2, radius*2)];
    if (self)
    {
        _ballRadius = radius;
        _ballColor = color;
    }
    
    return self;
}

- (void)didMoveToSuperview
{
    self.backgroundColor = self.ballColor;
    self.layer.cornerRadius = self.ballRadius;
    self.layer.masksToBounds = YES;
}

@end

