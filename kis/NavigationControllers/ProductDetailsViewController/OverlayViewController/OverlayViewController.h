//
//  OverlayViewController.h
//  kis
//
//  Created by beauty on 1/18/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OverlayDelegate <NSObject>

- (void)didCloseOverlay;

@end


@interface OverlayViewController : UIViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) NSArray *mArrImgNames;

@property (strong, nonatomic) UIPageViewController *pageController;

@property (nonatomic, strong) id<OverlayDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnClose;

- (IBAction)onCloseButton:(id)sender;

@end
