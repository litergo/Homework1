//
//  MyView.m
//  TestViews
//
//  Created by Алексей on 18/05/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import "MyView.h"

@implementation MyView

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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    NSLog(@"Touches of MyView at : %f %f", [touch locationInView:self].x, [touch locationInView:self].y);
    NSLog(@"Touches of MyView at : %f %f", [touch locationInView:self.superview].x, [touch locationInView:self.superview].y);
    NSLog(@"Frame origins is : %f %f",self.frame.origin.x, self.frame.origin.y);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    NSLog(@"Touches of MyView moved to : %f %f", [touch locationInView:self].x, [touch locationInView:self].y);
    
    CGFloat dx = [touch preciseLocationInView:self.superview].x - [touch precisePreviousLocationInView:self.superview].x;
    CGFloat dy = [touch preciseLocationInView:self.superview].y - [touch precisePreviousLocationInView:self.superview].y;

    self.frame = CGRectMake(self.frame.origin.x + dx, self.frame.origin.y + dy,
                            self.frame.size.width, self.frame.size.height);
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    NSLog(@"Touches of MyView ended at : %f %f", [touch locationInView:self].x, [touch locationInView:self].y);
    
}

@end
