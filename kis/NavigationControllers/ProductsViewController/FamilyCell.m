//
//  FamilyCell.m
//  kis
//
//  Created by Mauro Olivo on 11/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "FamilyCell.h"

@implementation FamilyCell

 - (id)initWithFrame:(CGRect)frame
 {
     self = [super initWithFrame:frame];
     if (self) {
     
     // Initialization code
     NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"FamilyCell" owner:self options:nil];
     
     if ([arrayOfViews count] < 1) {
         return nil;
     }
     
     if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
         return nil;
     }
     
     self = [arrayOfViews objectAtIndex:0];
     
     }
     
     return self;
 
}

@end
