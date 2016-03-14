//
//  Config.h
//  kis
//
//  Created by Mauro Olivo on 21/12/15.
//  Copyright © 2015 Mauro Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

#define DARK_GRAY               [UIColor colorWithRed:47.0/255.0 green:47.0/255.0 blue:47.0/255.0 alpha:1.0]
#define KIS_TINT_COLOR          [UIColor colorWithRed:0.0/255.0 green:78.0/255.0 blue:152.0/255.0 alpha:1.0]
#define KIS_TINT_COLOR_HIGH     [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]

#define AP_TINT_COLOR          [UIColor colorWithRed:208.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1.0]
#define AP_TINT_COLOR_HIGH     [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]

#define DBLADE_TINT_COLOR          [UIColor colorWithRed:248.0/255.0 green:167.0/255.0 blue:0.0/255.0 alpha:1.0]
#define DBLADE_TINT_COLOR_HIGH     [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:1.0]

#define COLORS [NSDictionary dictionaryWithObjectsAndKeys:KIS_TINT_COLOR, @"KIS_TINT_COLOR", KIS_TINT_COLOR_HIGH, @"KIS_TINT_COLOR_HIGH", AP_TINT_COLOR, @"AP_TINT_COLOR", AP_TINT_COLOR_HIGH, @"AP_TINT_COLOR_HIGH", DBLADE_TINT_COLOR, @"DBLADE_TINT_COLOR", DBLADE_TINT_COLOR_HIGH, @"DBLADE_TINT_COLOR_HIGH", nil]


#define USER_AREA_TINT [UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0]

#define URL_TO_CATALOG                  @"http://staging.onenetlab.com/Catalog.zip"
#define CATALOG_ZIP_NAME                @"Catalog.zip"

#define CATALOG_FOLDER_NAME             @"Catalog"
@end
