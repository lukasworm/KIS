//
//  Controllers.m
//  sidemenu
//
//  Created by Mauro Olivo on 22/09/15.
//  Copyright (c) 2015 Mauro Olivo. All rights reserved.
//

#import "Controllers.h"
#import "SideMenuViewController.h"
#import "LoginViewController.h"

@implementation Controllers

+(UIViewController*)getControllerForObject:(NSDictionary*)menuDict andIndex:(int)index{
    
    
    UIViewController * viewController ;
    NSString * classType = [menuDict valueForKey:@"type"];
    
    if(!viewController)
        viewController = [self getUIViewControllerStandardInit:classType andMenuIndex:index];
    
    assert(viewController);
    
    
    return viewController;
    
}

+(UIViewController*)getRootController{
    
    /*
    NSString * pathPlist = [[NSBundle mainBundle] pathForResource:@"SideMenu" ofType:@"plist"];
    NSArray *menuArray = [[NSArray alloc] initWithContentsOfFile:pathPlist];
    NSDictionary * dict = [menuArray objectAtIndex:1];
    
    SideMenuViewController * viewController= [self getUIViewControllerStandardInit:[dict valueForKey:@"type"] andMenuIndex:0];
    
    //viewController.analyticsPageName = [dict objectForKey:@"Title"];
    
    NSLog(@"root is: %@", NSStringFromClass([viewController class]));
    */
    
    //SideMenuViewController *viewController = [[NSClassFromString(@"CompanyViewController") alloc] initWithNibName:@"CompanyViewController" bundle:nil];
    
    
    LoginViewController *loginViewController = [[LoginViewController alloc] init];
    return loginViewController;
    
    //return viewController;
    
}

+(SideMenuViewController*)getUIViewControllerStandardInit:(NSString*)className andMenuIndex:(int)index{
    
    SideMenuViewController * controller = [[NSClassFromString(className) alloc] initWithNibName:className bundle:nil];
    
    return controller;
    
}

@end
