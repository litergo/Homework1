//
//  GRPBallView.h
//  TestViews
//
//  Created by Алексей on 05/06/2019.
//  Copyright © 2019 Alexey. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Класс-представление мяча
 */
@interface GRPBallView : UIView

@property (nonatomic, readonly) UIColor *ballColor;
@property (nonatomic, readonly) CGFloat ballRadius;

/**
 Создает экземпляр класса GRPBallView с нужным радиусом и цветом
 
 @param radius радиус мяча
 @param color цвет мяча
 @return GRPBallView
 */
- (instancetype)initWithRadius:(CGFloat)radius andColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
