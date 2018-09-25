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

static const NSInteger kNumOfLines = 5;
static const NSInteger kNumOfCells = 25;

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) CAShapeLayer *layer;
@property (nonatomic, assign) BOOL playerOne;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *acc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.playerOne = YES;
    self.collectionView.alpha = 0.7;
    self.acc = [[NSMutableArray alloc] init];
}



- (IBAction)restartGame
{
    self.playerOne = YES;
    [self clearGame];
}

#pragma mark CollectionView Delegate and Data source methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return kNumOfCells;
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
    if ([self checkForWinAtIndexPath:indexPath viewState:gameView.state])
    {
        NSLog(@"WIN");
        [self stopGame];
        [self alertForWinner];
        
    }
    [gameView setNeedsDisplay];
}

#pragma mark Game methods


/*
 
 1 2 3 4 5      0  1  2  3  4
 2 3 4 5 6      5  6  7  8  9
 3 4 5 6 7      10 11 12 13 14
 4 5 6 7 8      15 16 17 18 19
 5 6 7 8 9      20 21 22 23 24
 
            +i-j  +i  +i+j
             -j    x   +j
            -i-j  -i  -i+j
 
 */

- (BOOL)checkForWinAtIndexPath:(NSIndexPath *)indexPath viewState:(GameViewState)state
{
    BOOL win = NO;
    for (int i = -1; i < 2; i++)
        for (int j = -1; j < 2; j++)
        {
            if((i == 0)&&(j == 0))
                continue;
            [self checkStateInCellAtIndexPath:indexPath forState:state withStep:(i*kNumOfLines + j)];
            [self checkStateInCellAtIndexPath:indexPath forState:state withStep:((- i)*kNumOfLines - j)];
            if ([self.acc count] > 1)
            {
                win = YES;
                self.acc = [[NSMutableArray alloc] init];
                break;
            }
            else
                self.acc = [[NSMutableArray alloc] init];
        }
    return win;
}


- (void)checkStateInCellAtIndexPath:(NSIndexPath *)indexPath forState:(GameViewState)state withStep: (NSInteger)step
{
    if (indexPath.row >= 0 && indexPath.row < kNumOfCells)
    {
        NSIndexPath *customIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + step) inSection:0];
        TTTTicTacView *gameView = [[self.collectionView cellForItemAtIndexPath:customIndexPath] viewWithTag:2];
        if (gameView.state == state)
        {
            [self.acc addObject:@1];
            [self checkStateInCellAtIndexPath:customIndexPath forState:state withStep:step];
        }
    }
}

- (GameViewState)gameViewStateInCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    TTTTicTacView *gameView = [[collectionView cellForItemAtIndexPath:indexPath] viewWithTag:2];
    return gameView.state;
}

- (void)stopGame
{
    for (int i = 0; i < kNumOfCells ; i++)
    {
        UIView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:0];
        gameView.userInteractionEnabled = NO;
    }
}

- (void)clearGame
{
    for (int i = 0; i < kNumOfCells ; i++)
    {
        TTTTicTacView *gameView = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:2];
        UIView *view = [[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:0];
        view.userInteractionEnabled = YES;
        [gameView clear];
    }
}

#pragma mark Alert

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

@end
