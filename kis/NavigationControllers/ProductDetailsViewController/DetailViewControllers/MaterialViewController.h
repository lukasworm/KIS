//
//  MaterialViewController.h
//  kis
//
//  Created by beauty on 1/17/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property NSInteger mNumberOfItems;

@property (weak, nonatomic) IBOutlet UICollectionView *mCollectionView;
@end
