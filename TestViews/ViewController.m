//
//  ViewController.m
//  TestViews
//
//  Created by Алексей on 18/05/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addViewsToRootView];
}

- (void)addViewsToRootView
{
//    UIView *someView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 150, 150)];
//    someView.backgroundColor = [UIColor redColor];
//
//    [self.view addSubview:someView];
    
//    MyView *myView = [[MyView alloc] initWithFrame:CGRectMake(200, 400, 50, 50)];
    MyView *myView = [[MyView alloc] initWithFrame:CGRectMake(50, 50, 50, 50) andColor:[UIColor greenColor]];
    [self.view addSubview:myView];
    MyView *anotherView = [[MyView alloc] initWithFrame:CGRectMake(250, 50, 50, 50) andColor:[UIColor blackColor]];
    [self.view addSubview:anotherView];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    NSLog(@"Touches at : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    
    if ([touch.view class] == [MyView class]) {
        [self.view bringSubviewToFront:touch.view];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    NSLog(@"Touches moved to : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    NSLog(@"Touches ended at : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    
}

@end
