//
//  CompanyViewController.h
//  kis
//
//  Created by Mauro Olivo on 04/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "SideMenuViewController.h"

@interface CompanyViewController : SideMenuViewController <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageController;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (weak, nonatomic) IBOutlet UIView *m_contentView;


@end
