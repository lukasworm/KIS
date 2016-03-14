//
//  EventsViewController.m
//  kis
//
//  Created by beauty on 1/27/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "EventsViewController.h"
#import "IntroViewController.h"

@interface EventsViewController ()
{
    NSInteger m_countOfPages;
}
@end

@implementation EventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    m_countOfPages = 5;
    self.pageControl.numberOfPages = m_countOfPages;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self initializeViews];
}

-(void) initializeViews
{
    // pageController
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    
    self.pageController.dataSource = self;
    
    //[[self.pageController view] setFrame:CGRectMake(0, 0, [[self view] bounds].size.width, [[self view] bounds].size.height + 37)];
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin = CGPointMake(0, 0);
    contentFrame.size = CGSizeMake(contentFrame.size.width, contentFrame.size.height + 37);
    
    [[self.pageController view] setFrame:contentFrame];
    
    IntroViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.contentView addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    
}


#pragma mark - UIPageViewDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(IntroViewController *)viewController index];
    
    [self.pageControl setCurrentPage:index];
    
    if (index == 0) {
        return nil;
    }
    
    if (index > 0) {
        // Decrease the index by 1 to return
        index -= 1;
    }
    
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(IntroViewController *)viewController index];
    
    [self.pageControl setCurrentPage:index];
    
    // if last intro screen....
    if (index == m_countOfPages - 1)
    {
        return nil;
    }
    
    if (index < m_countOfPages) {
        index += 1;
    }
    
    return [self viewControllerAtIndex:index];
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return m_countOfPages;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

- (IntroViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    IntroViewController *childViewController = [[IntroViewController alloc] initWithNibName:@"IntroViewController" bundle:nil];
    
    childViewController.strPrefix = @"events";
    childViewController.index = index;
    
    return childViewController;
    
}

@end
