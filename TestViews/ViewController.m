//
//  ViewController.m
//  TestViews
//
//  Created by Алексей on 18/05/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) GRPBarView *playerBar;
@property (nonatomic, strong) GRPBarView *opponentBar;
@property (nonatomic, strong) GRPBallView *ballView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat deltaX;
@property (nonatomic, assign) CGFloat deltaY;
@property (nonatomic, assign) BOOL isFingerOnPayerBar;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self setupModel];
    [self setupTimer];
}

#pragma mark - Setup

-(void) setupUI
{
    
    self.opponentBar = [[GRPBarView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width/2.0 - 100.0/2.0,
                                                                     UIScreen.mainScreen.bounds.size.height/12.0,
                                                                     100, 20) andColor:[UIColor greenColor]];
    
    [self.view addSubview:self.opponentBar];
    
    self.playerBar = [[GRPBarView alloc] initWithFrame:CGRectMake(UIScreen.mainScreen.bounds.size.width/2.0 - 100.0/2.0,
                                                                        UIScreen.mainScreen.bounds.size.height*11.0/12.0,
                                                                        100, 20) andColor:[UIColor blackColor]];
    
    [self.view addSubview:self.playerBar];
    
    self.ballView = [[GRPBallView alloc] initWithRadius:7.f andColor:[UIColor redColor]];
    self.ballView.center = CGPointMake(UIScreen.mainScreen.bounds.origin.x + UIScreen.mainScreen.bounds.size.width/2.0,
                                       UIScreen.mainScreen.bounds.origin.y + UIScreen.mainScreen.bounds.size.height/2.0);
    
    [self.view addSubview:self.ballView];
}

-(void) setupTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTick) userInfo:nil repeats:YES];
    self.timer.tolerance = 0.01;
    
}

-(void) setupModel
{
    self.deltaX = 2;
    self.deltaY = 2;
}

#pragma mark - Logic

-(void) timerTick
{
    [self checkWolrdState];
    self.ballView.center = CGPointMake(self.ballView.center.x + self.deltaX, self.ballView.center.y + self.deltaY);
    
    CGFloat coordinateX = self.ballView.center.x - self.opponentBar.frame.size.width/2.0;
    
    coordinateX = MAX(coordinateX, 0);
    coordinateX = MIN(coordinateX, self.view.frame.size.width - self.opponentBar.frame.size.width);
    
    self.opponentBar.frame = CGRectMake(coordinateX,
                                      self.opponentBar.frame.origin.y,
                                      self.opponentBar.frame.size.width,
                                      self.opponentBar.frame.size.height);
    
}

-(void) checkWolrdState
{
    CGFloat rightBallCoordX = self.ballView.center.x + self.ballView.ballRadius;
    if (rightBallCoordX + self.deltaX >= CGRectGetWidth(self.view.frame))
    {
        self.deltaX = -self.deltaX;
    }
    
    CGFloat leftBallCoordX = self.ballView.center.x - self.ballView.ballRadius;
    
    if (leftBallCoordX + self.deltaX <= 0)
    {
        self.deltaX = -self.deltaX;
    }
    
    if ([self ballIntersectsBar]) {
        self.deltaY = -self.deltaY;
        return;
    }
    
    CGFloat topBallCoordX = self.ballView.center.y + self.ballView.ballRadius;
    CGFloat bottomBallCoordX = self.ballView.center.y - self.ballView.ballRadius;

    if (topBallCoordX < self.opponentBar.frame.origin.y + self.opponentBar.frame.size.height ||
        bottomBallCoordX > self.playerBar.frame.origin.y) {
        [self endGame];
    }
    
}

- (BOOL) ballIntersectsBar
{
    
    if (self.ballView.center.x + self.deltaX >= self.playerBar.frame.origin.x &&
         self.ballView.center.x + self.deltaX <= self.playerBar.frame.origin.x + self.playerBar.frame.size.width) {
            if (self.ballView.center.y + self.ballView.ballRadius + self.deltaY >= self.playerBar.frame.origin.y) {
                return YES;
            }
    }
    
    if (self.ballView.center.x + self.deltaX >= self.opponentBar.frame.origin.x &&
        self.ballView.center.x + self.deltaX <= self.opponentBar.frame.origin.x + self.opponentBar.frame.size.width) {
        if (self.ballView.center.y - self.ballView.ballRadius + self.deltaY <= self.opponentBar.frame.origin.y + self.opponentBar.frame.size.height) {
            return YES;
        }
    }
    
    return NO;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];

    UITouch *touch = [touches anyObject];
    NSLog(@"Touches at : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    
    if (touch.view == self.playerBar) {
        self.isFingerOnPayerBar = YES;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];

    if (self.isFingerOnPayerBar) {
        CGFloat coordinateX = self.playerBar.frame.origin.x + [touch preciseLocationInView:self.view].x - [touch precisePreviousLocationInView:self.view].x;
        
        coordinateX = MAX(coordinateX, 0);
        coordinateX = MIN(coordinateX, self.view.frame.size.width - self.playerBar.frame.size.width);
        
        self.playerBar.frame = CGRectMake(coordinateX,
                                          self.playerBar.frame.origin.y,
                                          self.playerBar.frame.size.width,
                                          self.playerBar.frame.size.height);
    }
    
    NSLog(@"Touches moved to : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    self.isFingerOnPayerBar = NO;
    
    NSLog(@"Touches ended at : %f %f", [touch locationInView:self.view].x, [touch locationInView:self.view].y);
    
}

#pragma mark - end

-(void) endGame
{
    [self.timer invalidate];
    self.timer = nil;
    
    NSString *message;
    
    if (self.ballView.center.y > self.view.frame.size.height/2.0)
    {
        message = @"You lose!";
    } else
    {
        message = @"You won!";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Game is finished!" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *restartAction = [UIAlertAction actionWithTitle:@"Restart" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self resetGameField];
    }];

    [alert addAction:defaultAction];
    [alert addAction:restartAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void) resetGameField
{
    self.playerBar.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2.0 - 100.0/2.0,
                                      UIScreen.mainScreen.bounds.size.height*11.0/12.0, 100, 20);
    
    self.opponentBar.frame = CGRectMake(UIScreen.mainScreen.bounds.size.width/2.0 - 100.0/2.0,
                                        UIScreen.mainScreen.bounds.size.height/12.0, 100, 20);
    
    self.ballView.center = CGPointMake(UIScreen.mainScreen.bounds.origin.x + UIScreen.mainScreen.bounds.size.width/2.0,
                                       UIScreen.mainScreen.bounds.origin.y + UIScreen.mainScreen.bounds.size.height/2.0);
    
    [self setupTimer];
    
}

@end
