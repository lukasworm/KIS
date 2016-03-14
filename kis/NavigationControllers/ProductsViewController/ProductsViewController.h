//
//  ProductsViewController.h
//  kis
//
//  Created by Mauro Olivo on 04/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "SideMenuViewController.h"

@interface ProductsViewController : SideMenuViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *familiesCollectionView;
@property int commLineId;

@property (nonatomic, strong) NSArray *families;
@end
