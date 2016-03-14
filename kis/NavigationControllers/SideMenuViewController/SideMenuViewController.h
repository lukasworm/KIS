//
//  SideMenuViewController.h
//  kis
//
//  Created by Mauro Olivo on 19/12/15.
//  Copyright © 2015 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@interface SideMenuViewController : UIViewController {

    IBOutlet UIView *sideMenuView;
    IBOutlet UIView *sideMenuFooterView;
}

@property (nonatomic, strong) NSArray *menu;
@property (nonatomic, strong) NSMutableArray *subMenuProducts;

@property (nonatomic, strong) NSDictionary *product;

@end
