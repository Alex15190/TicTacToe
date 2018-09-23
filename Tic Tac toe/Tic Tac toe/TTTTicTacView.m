//
//  TTTTicTacView.m
//  Tic Tac toe
//
//  Created by Alex Chekodanov on 22.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "TTTTicTacView.h"

@implementation TTTTicTacView


- (void)drawRect:(CGRect)rect {
    switch (self.state) {
        case GameViewStateX:
            [self drawX];
            break;
        case GameViewStateO:
            [self drawO];
            break;
        case GameViewStateEmpty:
            [self clear];
            break;
    }
}

- (void)drawX
{
    self.state = GameViewStateX;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(0 + 10, 0 + 10)];
    [path addLineToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height - 10)];
    [path moveToPoint:CGPointMake(self.bounds.size.width - 10, 0 + 10)];
    [path addLineToPoint:CGPointMake(0 + 10, self.bounds.size.height - 10)];
    [[UIColor redColor] setStroke];
    path.lineWidth = 3.0;
    [path stroke];
    [self setNeedsDisplay];
}

- (void)drawO
{
    self.state = GameViewStateO;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, self.bounds.size.width - 20, self.bounds.size.height - 20)]];
    [[UIColor greenColor] setStroke];
    path.lineWidth = 3.0;
    [path stroke];
    [self setNeedsDisplay];
}

- (void)clear
{
    self.state = GameViewStateEmpty;
    
    [self setNeedsDisplay];
}

@end
