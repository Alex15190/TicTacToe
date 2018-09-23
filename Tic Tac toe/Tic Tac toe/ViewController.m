//
//  ViewController.m
//  Tic Tac toe
//
//  Created by Alex Chekodanov on 22.09.2018.
//  Copyright © 2018 MERA. All rights reserved.
//

#import "ViewController.h"
#import "TTTTicTacView.h"
#import "EnumForGame.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, assign) BOOL playerOne;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playerOne = YES;
    self.collectionView.alpha = 0.7;
}



- (IBAction)restartGame
{
    self.playerOne = YES;
    [self clearGame];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TicTacID" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTTTicTacView *gameView = [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:2];
    UIView *view = [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:0];
    view.userInteractionEnabled = NO;
    if (self.playerOne)
    {
        gameView.state = GameViewStateX;
        self.playerOne = NO;
    }
    else
    {
        gameView.state = GameViewStateO;
        self.playerOne = YES;
    }
    if ([self checkForWinInCollectionView:collectionView viewState:gameView.state])
    {
        NSLog(@"WIN");
        [self stopGame];
        [self alertForWinner];
        
    }
    [gameView setNeedsDisplay];
}

- (void)alertForWinner
{
    NSString *msg;
    if (self.playerOne)
        msg = @"Player 2 WIN!";
    else
        msg = @"Player 1 WIN!";
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Game over" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
    [controller addAction:action];
    [self presentViewController:controller animated:YES completion:NULL];
}

- (BOOL)checkForWinInCollectionView:(UICollectionView *)collectionView viewState:(GameViewState)state
{
    BOOL win = NO;
    
    if ((state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:0 inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:4 inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:8 inSection:0]]))
        win = YES;
    else if ((state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:2 inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:4 inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:6 inSection:0]]))
        win = YES;
    else
        for (int i = 0; i < 3; i++)
        {
            if ((state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(0 + i*3) inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(1 + i*3) inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(2 + i*3) inSection:0]]))
                win = YES;
            else if ((state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(0 + i) inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(3 + i) inSection:0]]) && (state == [self gameViewStateInCollectionView:collectionView indexPath:[NSIndexPath indexPathForRow:(6 + i) inSection:0]]))
                win = YES;
        }
    return win;
}

- (GameViewState)gameViewStateInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    TTTTicTacView *gameView = [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:2];
    return gameView.state;
}

- (void)stopGame
{
    for (int i = 0; i < 9; i++)
    {
        UIView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:0];
        gameView.userInteractionEnabled = NO;
    }
}

- (void)clearGame
{
    for (int i = 0; i < 9; i++)
    {
        TTTTicTacView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:2];
        UIView *view = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:0];
        view.userInteractionEnabled = YES;
        [gameView clear];
    }
}

@end
