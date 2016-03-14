//
//  ThumbViewController.m
//  kis
//
//  Created by beauty on 1/18/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "ThumbViewController.h"

@interface ThumbViewController ()

@end

@implementation ThumbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mImage.image = [UIImage imageNamed:self.strImgName];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    
}

@end
