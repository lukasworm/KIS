//
//  DownloadViewController.m
//  kis
//
//  Created by Mauro Olivo on 15/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "DownloadViewController.h"
#import "SideMenuViewController.h"
#import "CompanyViewController.h"
#import "SSZipArchive.h"
#import "Session.h"
#import "Config.h"

@interface DownloadViewController () {
    NSURLSessionDownloadTask *download;
    
}
@property (strong, nonatomic) IBOutlet UILabel *percent;
@property (weak, nonatomic) IBOutlet UILabel *percentChar;
@property (weak, nonatomic) IBOutlet UILabel *catalogIsDownloading;

@property (strong, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, strong)NSURLSession *backgroundSession;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *unzipActivity;

@end

@implementation DownloadViewController

- (IBAction)downloadFile:(id)sender {
    if (nil == download){
        NSURL *url = [NSURL URLWithString:URL_TO_CATALOG];
        download = [self.backgroundSession downloadTaskWithURL:url];
        [download resume];
        [self.downloadButtonOutlet setEnabled:NO];
    }
}
- (IBAction)pauseDownload:(id)sender {
    if (nil != download){
        [download suspend];
    }
}
- (IBAction)resumeDownload:(id)sender {
    if (nil != download){
        [download resume];
    }
}
- (IBAction)cancelDownload:(id)sender {
    if (nil != download){
        [download cancel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.openCatalogOutlet setEnabled:NO];
    
    NSLog(@"%@", [[Session singletonSession] dataDirGet]);

    NSURLSessionConfiguration *backgroundConfigurationObject = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"myBackgroundSessionIdentifier"];
    
    self.backgroundSession = [NSURLSession sessionWithConfiguration:backgroundConfigurationObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];

    [self.progressView setProgress:0 animated:NO];
    [self.unzipActivity setHidden:YES];
    [self.percentChar setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    [self.catalogIsDownloading setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *destinationURL = [NSURL fileURLWithPath:[[[Session singletonSession] dataDirGet] stringByAppendingPathComponent:CATALOG_FOLDER_NAME]];
    
    
    if ([fileManager fileExistsAtPath:[destinationURL path]]){
        NSLog(@"Catalog is there");
        SideMenuViewController *sideMenuViewController = [[CompanyViewController alloc] init];
        
        [self.navigationController pushViewController:sideMenuViewController animated:NO];
    } else {
    
        if (nil == download){
            NSURL *url = [NSURL URLWithString:URL_TO_CATALOG];
            download = [self.backgroundSession downloadTaskWithURL:url];
            [download resume];
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
// 1
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSURL *destinationURL = [NSURL fileURLWithPath:[[[Session singletonSession] dataDirGet] stringByAppendingPathComponent:CATALOG_ZIP_NAME]];
    
    NSError *error = nil;
    
    if ([fileManager fileExistsAtPath:[destinationURL path]]){
        [fileManager replaceItemAtURL:destinationURL withItemAtURL:destinationURL backupItemName:nil options:NSFileManagerItemReplacementUsingNewMetadataOnly resultingItemURL:nil error:&error];
        
        [self showFile:[destinationURL path]];
        
    }else{
        
        if ([fileManager moveItemAtURL:location toURL:destinationURL error:&error]) {
            
            [self showFile:[destinationURL path]];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Power Downloader" message:[NSString stringWithFormat:@"An error has occurred when moving the file: %@",[error localizedDescription]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
}

// 2
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    [self.progressView setProgress:(double)totalBytesWritten/(double)totalBytesExpectedToWrite
                          animated:YES];
    
    NSLog(@"%lld %lld", totalBytesWritten, totalBytesExpectedToWrite);
    
    self.percent.text = [NSString stringWithFormat:@"%.01f", 100*(double)totalBytesWritten/(double)totalBytesExpectedToWrite];
    [self.percent setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
}

// 3
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Power Downloader" message:@"Download is resumed successfully" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [alert show];
}

//
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    
    download = nil;
    [self.progressView setProgress:0];
    
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Power Downloader" message:[error localizedDescription] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}

//
- (void)showFile:(NSString*)path{
    
    NSLog(@"OPERATION DONE: %@", path);
    
    NSString* zipPath = path;
    
    [self.unzipActivity setHidden:NO];
    [self.unzipActivity startAnimating];

    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing

        [SSZipArchive unzipFileAtPath:zipPath toDestination:[[Session singletonSession] dataDirGet] progressHandler:nil completionHandler:nil];
        
        dispatch_async( dispatch_get_main_queue(), ^{
            [self.unzipActivity stopAnimating];
            NSLog(@"end unzipping");
            [self.unzipActivity setHidden:YES];
            
            SideMenuViewController *sideMenuViewController = [[CompanyViewController alloc] init];
            
            [self.navigationController pushViewController:sideMenuViewController animated:YES];
            
        });
    });
    
}


- (IBAction)openCatalogAction:(id)sender {
    
    SideMenuViewController *sideMenuViewController = [[CompanyViewController alloc] init];
    
    [self.navigationController pushViewController:sideMenuViewController animated:YES];
    
}
- (IBAction)forceToCatalog:(id)sender {
    
    SideMenuViewController *sideMenuViewController = [[CompanyViewController alloc] init];
    
    [self.navigationController pushViewController:sideMenuViewController animated:YES];
     
}
@end
