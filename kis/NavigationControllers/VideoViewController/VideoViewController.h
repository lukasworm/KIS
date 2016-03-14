//
//  VideoViewController.h
//  kis
//
//  Created by beauty on 1/28/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"
#import "YTPlayerView.h"

@interface VideoViewController : SideMenuViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, YTPlayerViewDelegate>

@property (nonatomic, strong) NSMutableArray *videoURLArray;


@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@end
