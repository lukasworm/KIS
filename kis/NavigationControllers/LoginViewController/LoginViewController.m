//
//  LoginViewController.m
//  kis
//
//  Created by Mauro Olivo on 14/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "LoginViewController.h"
#import "DownloadViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.usernameTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.usernameTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.usernameTextField setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    self.usernameTextField.layer.borderWidth = 1.0f;
    
    self.passwordTextField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    [self.passwordTextField setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    self.passwordTextField.layer.borderWidth = 1.0f;
    
    self.usernameTextField.placeholder = NSLocalizedString(@"email", nil);
    self.passwordTextField.placeholder = NSLocalizedString(@"password", nil);
    
    //usernameTextField.text = @"admin";
    //passwordTextField.text = @"admin";
    
    [self.loginButtonOutlet.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    [self.loginButtonOutlet setTitle:NSLocalizedString(@"Login", nil) forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)loginButtonAction:(id)sender {
    
    DownloadViewController *downloadViewController = [[DownloadViewController alloc] init];
    
    [self.navigationController pushViewController:downloadViewController animated:NO];
}

@end
