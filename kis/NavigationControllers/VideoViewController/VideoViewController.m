//
//  VideoViewController.m
//  kis
//
//  Created by beauty on 1/28/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "VideoViewController.h"
#import "VideoCollectionViewCell.h"
#import "Config.h"


//#import <MediaPlayer/MediaPlayer.h>
//#import <AVFoundation/AVFoundation.h>
//#import <AVKit/AVKit.h>

#define VideoThumbnailUrl @"https://i1.ytimg.com/vi/"
#define VideoThumbnailName @"/mqdefault.jpg"
#define VideoUrl @"http://www.youtube.com/watch?v="

@interface VideoViewController ()
{
    CGSize m_screenSize;
}

@property (weak, nonatomic) IBOutlet UIButton *closeButton;


@end


@implementation VideoViewController
@synthesize videoURLArray;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    m_screenSize = [UIScreen mainScreen].bounds.size;
    
    videoURLArray = [[NSMutableArray alloc] init];
    
    [self getVideosData];
    
    // collection view
    [self.collectionView registerClass:[VideoCollectionViewCell class] forCellWithReuseIdentifier:@"VideoCellIdentifier"];
    self.collectionView.backgroundColor = [UIColor whiteColor];

}

-(void)getVideosData
{
    NSMutableDictionary *dic1 = [[NSMutableDictionary alloc] init];
    [dic1 setObject:@"ojbb6nGvIi8" forKey:@"videoId"];
    [dic1 setObject:@"How To make an App - Ep 1...." forKey:@"videoTitle"];
    [videoURLArray addObject:dic1];
    
    NSMutableDictionary *dic2 = [[NSMutableDictionary alloc] init];
    [dic2 setObject:@"oeb4VtuCc8c" forKey:@"videoId"];
    [dic2 setObject:@"video title 2" forKey:@"videoTitle"];
    [videoURLArray addObject:dic2];
    
    NSMutableDictionary *dic3 = [[NSMutableDictionary alloc] init];
    [dic3 setObject:@"CYZYcEi8Ll4" forKey:@"videoId"];
    [dic3 setObject:@"video title 3" forKey:@"videoTitle"];
    [videoURLArray addObject:dic3];
    
    NSMutableDictionary *dic4 = [[NSMutableDictionary alloc] init];
    [dic4 setObject:@"nVu0naGTS_l" forKey:@"videoId"];
    [dic4 setObject:@"video title 4" forKey:@"videoTitle"];
    [videoURLArray addObject:dic4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self initializeViews];
    
}


-(void) initializeViews
{
    
    float titleFontSize = m_screenSize.height * 42 / 1536.0f;
    
    [self.lblTitle setFont:[UIFont fontWithName:@"ProximaNova-Light" size:titleFontSize]];
    
}

#pragma mark - collectionview datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return videoURLArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"VideoCellIdentifier";
    
    /* Uncomment this block to use subclass-based cells */
    VideoCollectionViewCell *cell = (VideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    NSInteger row = [indexPath row];
    NSMutableDictionary *dic = (NSMutableDictionary*)videoURLArray[row];
    
    cell.lblTitle.text = [dic objectForKey:@"videoTitle"];
    float fontSize = m_screenSize.height * 22 / 1536.0f;
    cell.lblTitle.font = [UIFont fontWithName:@"ProximaNova-Light" size:fontSize];
    
    NSString *videoThumbnamilUrlString = [NSString stringWithFormat:@"%@%@%@", VideoThumbnailUrl, [dic objectForKey:@"videoId"], VideoThumbnailName];
    
    NSURL *videoThumbnailUrl = [NSURL URLWithString:videoThumbnamilUrlString];
    
    if (videoThumbnailUrl)
    {
        NSURLRequest *request = [NSURLRequest requestWithURL:videoThumbnailUrl];
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                cell.imgThumb.image = [UIImage imageWithData:data];
            });
        }];
        [dataTask resume];
    }
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    float height = m_screenSize.height * 360 / 1536.0f;
    float width = height * 450 / 360.0f;
    return CGSizeMake(width, height);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 20, 0);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dic = (NSMutableDictionary*)videoURLArray[indexPath.row];
    
    NSString *videoId = [dic objectForKey:@"videoId"];
    
    [self.playerView setHidden:NO];
    [self.playerView setDelegate:self];
    [self.playerView loadWithVideoId:videoId];
    [self.view bringSubviewToFront:self.playerView];
    [self.playerView bringSubviewToFront:self.closeButton];
}

- (IBAction)onClose:(id)sender
{
    [self.playerView stopVideo];
    [self.playerView setHidden:YES];
}
#pragma mark - YTPlayerView Delegate

- (void)playerView:(YTPlayerView *)playerView didChangeToState:(YTPlayerState)state {
    switch (state) {
        case kYTPlayerStatePlaying:
            NSLog(@"Started playback");
            [self.playerView bringSubviewToFront:self.closeButton];
            break;
        case kYTPlayerStatePaused:
            NSLog(@"Paused playback");
            break;
        case kYTPlayerStateEnded:
            [self.playerView setHidden:YES];            
            break;
    
        default:
            break;
    }
}

@end
