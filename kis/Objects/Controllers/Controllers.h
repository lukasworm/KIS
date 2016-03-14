//
//  Controllers.h
//  sidemenu
//
//  Created by Mauro Olivo on 22/09/15.
//  Copyright (c) 2015 Mauro Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Controllers : NSObject

+(UIViewController*)getControllerForObject:(NSDictionary*)menuDict andIndex:(int)index;

+(UIViewController*)getRootController;

@end
