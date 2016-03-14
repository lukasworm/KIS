//
//  EventsViewController.h
//  kis
//
//  Created by beauty on 1/27/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuViewController.h"

@interface EventsViewController : SideMenuViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
