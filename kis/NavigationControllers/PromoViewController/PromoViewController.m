//
//  PromoViewController.m
//  kis
//
//  Created by beauty on 1/28/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "PromoViewController.h"
#import "PromoCell.h"
#import "AFNetworking.h"


@interface PromoViewController ()
{
    NSMutableArray *m_arrPromos;
}
@end

@implementation PromoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float titleFontSize = screenSize.height * 42 / 1536.0f;
    self.lblTitle.font = [UIFont fontWithName:@"ProximaNova-Light" size:titleFontSize];
    
    [self.collectionView registerClass:[PromoCell class] forCellWithReuseIdentifier:@"promoCell"];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    m_arrPromos = [[NSMutableArray alloc] init];
    [self getDatasFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getDatasFromServer
{
    NSString * BaseURLString = @"http://app.civiltadicantiere.it/issues/issues.json";
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"Error: %@", error);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Network Error!" message:@"Network is disconnected. Please check your connection..." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [alert show];
        } else
        {
            //NSLog(@"Success: %@ %@", response, responseObject);
            m_arrPromos = (NSMutableArray*)responseObject;
            NSLog(@"%@", m_arrPromos);
            [self.collectionView reloadData];
        }
    }];
    
    [dataTask resume];
}


#pragma mark - collectionview datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return m_arrPromos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"promoCell";
    
    PromoCell *cell = (PromoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *dataDic = [m_arrPromos objectAtIndex:indexPath.row];
    NSString *strTitle = [dataDic objectForKey:@"Title"];
    NSString *strName = [dataDic objectForKey:@"Name"];
    cell.lblMaterialTitle.text = strTitle;
    cell.lblSubTitle.text = strName;
    
    return cell;

}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float collectionViewWidth = screenSize.width * 1475 / 2048.0f;
    
    float cellWidth = cellWidth = (collectionViewWidth - 60) / 4.0f;
    
    return CGSizeMake(cellWidth, cellWidth);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 20, 0);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dataDic = [m_arrPromos objectAtIndex:indexPath.row];
    
    NSString *strPdfTitle = [dataDic objectForKey:@"Title"];
    self.lblPdfTitle.text = strPdfTitle;
    
    NSString *strContentURL = [dataDic objectForKey:@"Content"];
    
//    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:strContentURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    
    [self.pdfContainterView setHidden:NO];
    [self.view bringSubviewToFront:self.pdfContainterView];
    [self.pdfActivity setHidden:NO];
    [self.pdfActivity startAnimating];
    self.pdfWebView.delegate = self;
    
    self.pdfWebView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.pdfWebView setContentMode:UIViewContentModeScaleAspectFit];
    [self.pdfWebView setScalesPageToFit:YES];
    
    [self.pdfWebView loadRequest:request];
   
    
    /*
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        NSURL *documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
    
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"File downloaded to: %@", filePath);
    }];
    [downloadTask resume];
    */
}

#pragma mark - UIWebView Delegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.pdfActivity stopAnimating];
    [self.pdfActivity setHidden:YES];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nullable NSError *)error
{
    NSLog(@"Load pdf error: %@", error);
//    [self.pdfActivity stopAnimating];
//    self.pdfWebView.delegate = nil;
//    [self.pdfContainterView setHidden:YES];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Load Failed!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//    [alert show];
}

- (IBAction)onPDFClose:(id)sender
{
    [self.pdfActivity stopAnimating];
    self.pdfWebView.delegate = nil;
    [self.pdfContainterView setHidden:YES];
}

@end
