//
//  PromoCell.h
//  kis
//
//  Created by beauty on 2/2/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PromoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgThumb;
@property (weak, nonatomic) IBOutlet UILabel *lblMaterialTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblSubTitle;

@end
