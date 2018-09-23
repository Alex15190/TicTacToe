//
//  TTTTicTacView.h
//  Tic Tac toe
//
//  Created by Alex Chekodanov on 22.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EnumForGame.h"

NS_ASSUME_NONNULL_BEGIN

@interface TTTTicTacView : UIView

@property (nonatomic) GameViewState state;

- (void)drawX;
- (void)drawO;
- (void)clear;

@end

NS_ASSUME_NONNULL_END
