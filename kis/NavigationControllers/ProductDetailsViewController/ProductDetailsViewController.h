//
//  ProductDetailsViewController.h
//  kis
//
//  Created by Mauro Olivo on 11/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "ProductsViewController.h"
#import "OverlayViewController.h"


@interface ProductDetailsViewController : SideMenuViewController <OverlayDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>

@property (strong, nonatomic) UIView *mDetailSubView;


@property (weak, nonatomic) IBOutlet UIScrollView *mScrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollContentWidth;

// top constraint
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTopBarTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *mTopView;

// thumbnails...
@property (weak, nonatomic) IBOutlet UIImageView *imgThumb;
@property (weak, nonatomic) IBOutlet UIButton *imgThumb1;
@property (weak, nonatomic) IBOutlet UIButton *imgThumb2;
@property (weak, nonatomic) IBOutlet UIButton *imgThumb3;
@property (weak, nonatomic) IBOutlet UIButton *imgThumb4;

// buttons...
@property (weak, nonatomic) IBOutlet UIButton *mBtnMaterial;
@property (weak, nonatomic) IBOutlet UIButton *mBtnLogistics;
@property (weak, nonatomic) IBOutlet UIButton *mBtnPromo;


// other measures & colours button
@property (weak, nonatomic) IBOutlet UIButton *btnOtherMeasures;
@property (weak, nonatomic) IBOutlet UIView *otherMeasureUnderline;
@property (weak, nonatomic) IBOutlet UIButton *btnColours;
@property (weak, nonatomic) IBOutlet UIView *coloursUnderline;

// collection view
@property (weak, nonatomic) IBOutlet UICollectionView *mOtherMeasuresCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *mColoursCollectionView;

// detail view
@property (weak, nonatomic) IBOutlet UIView *mDetailView;

// overlay view
@property (weak, nonatomic) IBOutlet UIView *mOverlayView;


// events
- (IBAction)onButton:(id)sender;
- (IBAction)onCloseButton:(id)sender;
- (IBAction)onPlusButton:(id)sender;
- (IBAction)onThumbs:(id)sender;


- (IBAction)onOtherMeasuresOrColours:(id)sender;



@end
