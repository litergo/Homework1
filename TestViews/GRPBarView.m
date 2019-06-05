//
//  MyView.m
//  TestViews
//
//  Created by Алексей on 18/05/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import "GRPBarView.h"

@implementation GRPBarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = color;
    }
    return self;
}


@end
