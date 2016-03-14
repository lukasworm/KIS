//
//  MaterialViewController.m
//  kis
//
//  Created by beauty on 1/17/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "MaterialViewController.h"
#import "ProductDetailsCell.h"

#define kCollectionCellWidth 150

@interface MaterialViewController ()

@end

@implementation MaterialViewController
@synthesize mNumberOfItems;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializeViews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initializeViews
{
    UINib *nib = [UINib nibWithNibName:@"ProductDetailsCell" bundle:[NSBundle mainBundle]];
    [self.mCollectionView registerNib:nib forCellWithReuseIdentifier:@"ProductDetailsCell"];
    self.mCollectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - UICollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.mNumberOfItems;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"ProductDetailsCell";
    
    ProductDetailsCell *cell = (ProductDetailsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    //NSInteger row = [indexPath row];
    
    cell.imageOutlet.image = [UIImage imageNamed:@"template_material.png"];
    cell.titleLabel.text = @"material title";
    cell.subTitleLabel.text = @"subTitle...";
    
    
    // Return the cell
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kCollectionCellWidth, kCollectionCellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 20, 0);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    NSLog(@"%@", indexPath);
    
}

@end
