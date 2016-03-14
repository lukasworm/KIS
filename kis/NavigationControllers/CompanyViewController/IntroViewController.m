//
//  IntroViewController.m
//  kis
//
//  Created by beauty on 1/27/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.imgIntro.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%ld.png", self.strPrefix, (long)self.index + 1]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
