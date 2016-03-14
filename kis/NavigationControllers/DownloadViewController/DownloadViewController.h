//
//  DownloadViewController.h
//  kis
//
//  Created by Mauro Olivo on 15/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownloadViewController : UIViewController <NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIButton *downloadButtonOutlet;

- (IBAction)openCatalogAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *openCatalogOutlet;
- (IBAction)forceToCatalog:(id)sender;

@end
