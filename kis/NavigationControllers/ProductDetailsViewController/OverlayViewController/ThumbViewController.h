//
//  ThumbViewController.h
//  kis
//
//  Created by beauty on 1/18/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThumbViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSString *strImgName;

@property (weak, nonatomic) IBOutlet UIImageView *mImage;

@end
