//
//  FamilyViewController.h
//  kis
//
//  Created by Mauro Olivo on 11/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "ProductsViewController.h"

@interface FamilyViewController : ProductsViewController <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *productsCollectionView;

@property (nonatomic, strong) NSMutableArray *products;

@end
