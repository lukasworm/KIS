//
//  IntroViewController.h
//  kis
//
//  Created by beauty on 1/27/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroViewController : UIViewController

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSString *strPrefix;

@property (weak, nonatomic) IBOutlet UIImageView *imgIntro;

@end
