//
//  OverlayViewController.m
//  kis
//
//  Created by beauty on 1/18/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "OverlayViewController.h"
#import "ThumbViewController.h"

@interface OverlayViewController ()

@end

@implementation OverlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}

-(void) viewDidLayoutSubviews
{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    
    CGSize size = [[self view] bounds].size;
    float width = size.width / 2;
    float height = size.height / 2;
    float offsetX = (size.width - width) / 2.0f;
    float offsetY = (size.height - height) / 2.0f;
    CGRect pageRect = CGRectMake(offsetX, offsetY, width, height);
    [[self.pageController view] setFrame:pageRect];
    
    [self.btnClose setFrame:CGRectMake(size.width - offsetX - 50, offsetY, 50, 50)];
    
    
    ThumbViewController *thumbViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:thumbViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    
    
    
    [self.view bringSubviewToFront:self.btnClose];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ThumbViewController *)viewControllerAtIndex:(NSInteger)index
{
    ThumbViewController *thumbViewController = [[ThumbViewController alloc] initWithNibName:@"ThumbViewController" bundle:nil];
    thumbViewController.strImgName = self.mArrImgNames[index];
    thumbViewController.index = index;
    
    return thumbViewController;
}

#pragma mark - UIPageViewDelegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(ThumbViewController *)viewController index];
    
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
    
    NSUInteger index = [(ThumbViewController *)viewController index];
    
    // if last intro screen....
    if (index == (self.mArrImgNames.count - 1) )
    {
        return nil;
    }
    
    if (index < self.mArrImgNames.count) {
        index += 1;
    }
    
    return [self viewControllerAtIndex:index];
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    
    return self.mArrImgNames.count;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    
    return 0;
}

#pragma mark - close button event

- (IBAction)onCloseButton:(id)sender
{
    [self.delegate didCloseOverlay];
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}
@end
