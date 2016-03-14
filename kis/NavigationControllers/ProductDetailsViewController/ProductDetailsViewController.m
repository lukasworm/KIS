//
//  ProductDetailsViewController.m
//  kis
//
//  Created by Mauro Olivo on 11/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "Session.h"
#import "Config.h"
#import "ProductDetailsCell.h"
#import "MaterialViewController.h"

#define kCollectionCellWidth 150
#define kOtherMeasuerCollectionCount 35
#define kColoursCollectionCount 10

typedef enum Type
{
    None,
    MATERIAL,
    LOGISTICS,
    PROMO
}SelectedType;


@interface ProductDetailsViewController ()
{
    BOOL mSelectedType;
    BOOL mIsTitleBarHidden;
}
@property (weak, nonatomic) IBOutlet UILabel *commLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;


@end

@implementation ProductDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
        
    NSDictionary *family = [[Session singletonSession] currentFamilyDictionaryGet];
    
    //self.familyLabel.textColor =  [COLORS valueForKey:[[[Session singletonSession] currentCatalogGet] stringByAppendingString:@"_TINT_COLOR"]];
    [self.familyLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    self.familyLabel.text = [family valueForKey:@"title"];
    
    self.commLineLabel.textColor = [UIColor whiteColor];
    [self.commLineLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:27.0f]];
    self.commLineLabel.text = [self.product valueForKey:@"title"];
    
    [self.commLineLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:18.0f]];
    
    [self initializeViews];
    
    /* QUI SI SPACCA, colors è un Dictionary, non un array!
     NSArray *colors = [self.product valueForKey:@"colors"];
     NSLog(@"%@", [colors objectAtIndex:0]);
    */
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self onOtherMeasuresOrColours:self.btnOtherMeasures];
}


-(void)setContentHeightWithCollectionView:(UICollectionView*)collectionView
{
    CGRect collectionRect = collectionView.frame;
    float collectionViewWidth = collectionRect.size.width;
    float collectionWiewHeight = 0;
    
    if ([collectionView isEqual:self.mOtherMeasuresCollectionView])
    {
        int col = collectionViewWidth / kCollectionCellWidth;
        int row = kOtherMeasuerCollectionCount / col;
        if (kCollectionCellWidth > (row * col)) {
            row += 1;
        }
        collectionWiewHeight = row * (kCollectionCellWidth + 20);
    }
    else if ([collectionView isEqual:self.mColoursCollectionView])
    {
        int col = collectionViewWidth / kCollectionCellWidth;
        int row = kColoursCollectionCount / col;
        if (kCollectionCellWidth > (row * col)) {
            row += 1;
        }
        collectionWiewHeight = row * (kCollectionCellWidth + 20);
    }
    
    self.scrollContentHeight.constant = collectionRect.origin.y + collectionWiewHeight;
    
}

-(float)setContentHeightWithNumberOfItems:(NSInteger)number
{
    CGRect rect = self.mDetailView.frame;
    float width = rect.size.width;
    
    NSInteger col = width / kCollectionCellWidth;
    NSInteger row = number / col;
    if (kCollectionCellWidth > (row * col)) {
        row += 1;
    }
    float collectionWiewHeight = row * (kCollectionCellWidth + 20);
    
    self.scrollContentHeight.constant = rect.origin.y + collectionWiewHeight;
    return collectionWiewHeight;
}



-(void)initializeViews
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    mSelectedType = None;
    mIsTitleBarHidden = YES;
    self.mTopBarTopConstraint.constant = -80;
    
    self.scrollContentWidth.constant = screenSize.width * 1586 / 2048.0f;
    
    UINib *nib = [UINib nibWithNibName:@"ProductDetailsCell" bundle:[NSBundle mainBundle]];
    [self.mOtherMeasuresCollectionView registerNib:nib forCellWithReuseIdentifier:@"ProductDetailsCell"];
    self.mOtherMeasuresCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.mColoursCollectionView registerNib:nib forCellWithReuseIdentifier:@"ProductDetailsCell"];
    self.mColoursCollectionView.backgroundColor = [UIColor whiteColor];
    
    [self.imgThumb1.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.imgThumb1.layer setBorderWidth:1];
    
    [self.imgThumb2.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.imgThumb2.layer setBorderWidth:1];
    
    [self.imgThumb3.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.imgThumb3.layer setBorderWidth:1];
    
    [self.imgThumb4.layer setBorderColor:[UIColor grayColor].CGColor];
    [self.imgThumb4.layer setBorderWidth:1];
    
    // set custom fonts....
    
    [self.btnOtherMeasures.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:20.0f]];
    [self.btnColours.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:20.0f]];
    
}


#pragma mark - UICollectionView DataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger numberOfItmes = 0;
    if ([collectionView isEqual:self.mOtherMeasuresCollectionView])
        numberOfItmes = kOtherMeasuerCollectionCount;
    else if ([collectionView isEqual:self.mColoursCollectionView])
        numberOfItmes = kColoursCollectionCount;
    
    return numberOfItmes;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"ProductDetailsCell";
    
    ProductDetailsCell *cell = (ProductDetailsCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSInteger row = [indexPath row];
    
    if ([collectionView isEqual:self.mOtherMeasuresCollectionView])
    {
        // if Other Measures....
        int index = row % 8 + 1;
        NSString *strImgName = [NSString stringWithFormat:@"template%d.png", index];
        cell.imageOutlet.image = [UIImage imageNamed:strImgName];
        cell.titleLabel.text = @"title";
        cell.subTitleLabel.text = @"subTitle...";
    }
    else if ([collectionView isEqual:self.mColoursCollectionView])
    {
        // if Colours....
        
        
    }
    
    
    // Return the cell
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(kCollectionCellWidth, kCollectionCellWidth);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 20, 0);
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
    NSLog(@"%@", indexPath);
    
}

#pragma mark - scrollview delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint pos = [scrollView contentOffset];
    
    if (pos.y > 70 && mIsTitleBarHidden)
    {
        NSLog(@"show AA");
        mIsTitleBarHidden = NO;
        
        [UIView animateWithDuration:1.0f animations:^{
            self.mTopView.frame = CGRectOffset(self.mTopView.frame, 0, 80);
            self.mTopBarTopConstraint.constant = 0;
        }];
        
    }
    else if (!mIsTitleBarHidden && pos.y < 70)
    {
        NSLog(@"Hide title bar");
        mIsTitleBarHidden = YES;
        
        [UIView animateWithDuration:1.0f animations:^{
            self.mTopView.frame = CGRectOffset(self.mTopView.frame, 0, -80);
            self.mTopBarTopConstraint.constant = -80;
        }];
        
    }
    
    
}


#pragma mark - show Detail Window...

-(void) showDetailWindow: (SelectedType)type
{
    [self setButtonIconWithType:type];
    [self.mDetailView setHidden:NO];
    [self.mColoursCollectionView setHidden:YES];
    [self.mOtherMeasuresCollectionView setHidden:YES];
    
    switch (type) {
        case MATERIAL:
            {
                [self.mDetailSubView removeFromSuperview];
                
                MaterialViewController *materialViewController = [[MaterialViewController alloc] initWithNibName:@"MaterialViewController" bundle:nil];
                NSInteger numberOfMaterials = 10;
                materialViewController.mNumberOfItems = numberOfMaterials;
                float collectionHeight = [self setContentHeightWithNumberOfItems:numberOfMaterials];

                CGRect rect = self.mDetailView.frame;
                rect.origin = CGPointMake(0, 0);
                rect.size.height = collectionHeight;
                materialViewController.view.frame = rect;
                [self addChildViewController:materialViewController];
                [self.mDetailView addSubview:materialViewController.view];
                self.mDetailSubView = materialViewController.view;

            }
            break;
        case LOGISTICS:
            {
                [self.mDetailSubView removeFromSuperview];
                
                MaterialViewController *materialViewController = [[MaterialViewController alloc] initWithNibName:@"MaterialViewController" bundle:nil];
                NSInteger numberOfMaterials = 5;
                materialViewController.mNumberOfItems = numberOfMaterials;
                float collectionHeight = [self setContentHeightWithNumberOfItems:numberOfMaterials];
                
                CGRect rect = self.mDetailView.frame;
                rect.origin = CGPointMake(0, 0);
                rect.size.height = collectionHeight;
                materialViewController.view.frame = rect;
                
                [self addChildViewController:materialViewController];
                [self.mDetailView addSubview:materialViewController.view];
                self.mDetailSubView = materialViewController.view;
                
            }
            break;
        case PROMO:
            {
                [self.mDetailSubView removeFromSuperview];
                
                MaterialViewController *materialViewController = [[MaterialViewController alloc] initWithNibName:@"MaterialViewController" bundle:nil];
                NSInteger numberOfMaterials = 2;
                materialViewController.mNumberOfItems = numberOfMaterials;
                float collectionHeight = [self setContentHeightWithNumberOfItems:numberOfMaterials];
                
                CGRect rect = self.mDetailView.frame;
                rect.origin = CGPointMake(0, 0);
                rect.size.height = collectionHeight;
                materialViewController.view.frame = rect;
                [self addChildViewController:materialViewController];
                [self.mDetailView addSubview:materialViewController.view];
                self.mDetailSubView = materialViewController.view;
                
            }
            break;
        default:
            break;
    }
    
}

- (void)setButtonIconWithType:(SelectedType)type
{
    mSelectedType = type;
    switch (type) {
        case None:
            {
                [self.mBtnMaterial setImage:[UIImage imageNamed:@"ico_materiale.png"] forState:UIControlStateNormal];
                [self.mBtnLogistics setImage:[UIImage imageNamed:@"ico_logistica.png"] forState:UIControlStateNormal];
                [self.mBtnPromo setImage:[UIImage imageNamed:@"ico_promo.png"] forState:UIControlStateNormal];
                
            }
            break;
        case MATERIAL:
            {
                [self.mBtnMaterial setImage:[UIImage imageNamed:@"ico_materiale_on.png"] forState:UIControlStateNormal];
                [self.mBtnLogistics setImage:[UIImage imageNamed:@"ico_logistica.png"] forState:UIControlStateNormal];
                [self.mBtnPromo setImage:[UIImage imageNamed:@"ico_promo.png"] forState:UIControlStateNormal];
            
            }
            break;
        case LOGISTICS:
            {
                [self.mBtnMaterial setImage:[UIImage imageNamed:@"ico_materiale.png"] forState:UIControlStateNormal];
                [self.mBtnLogistics setImage:[UIImage imageNamed:@"ico_logistica.png"] forState:UIControlStateNormal];
                [self.mBtnPromo setImage:[UIImage imageNamed:@"ico_promo.png"] forState:UIControlStateNormal];
            
            }
            break;
        case PROMO:
            {
                [self.mBtnMaterial setImage:[UIImage imageNamed:@"ico_materiale.png"] forState:UIControlStateNormal];
                [self.mBtnLogistics setImage:[UIImage imageNamed:@"ico_logistica.png"] forState:UIControlStateNormal];
                [self.mBtnPromo setImage:[UIImage imageNamed:@"ico_promo.png"] forState:UIControlStateNormal];
            
            }
            break;
        default:
            break;
    }
}


#pragma mark - buttons events

- (IBAction)onButton:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    switch (button.tag)
    {
        case 7: // material button
            [self showDetailWindow:MATERIAL];
            break;
        case 8: // logistics button
            [self showDetailWindow:LOGISTICS];
            break;
        case 9: // promo button
            [self showDetailWindow:PROMO];
            break;
            
        default:
            {
                NSString *strMsg = [NSString stringWithFormat:@"button%d is selected", (int)button.tag];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strMsg message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
            break;
    }
    
    
    
}

- (IBAction)onCloseButton:(id)sender
{
    /*
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Colse button is selected." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
     */
    
    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];
    
    SideMenuViewController * controller = [[NSClassFromString(@"FamilyViewController") alloc] initWithNibName:@"FamilyViewController" bundle:nil];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
}

- (IBAction)onPlusButton:(id)sender
{
    OverlayViewController *overlayViewController = [[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil];
    overlayViewController.mArrImgNames = @[@"path_to_img.png", @"thumb1.png", @"thumb2.png", @"thumb3.png"];
    
    CGRect frame = self.mOverlayView.frame;
    frame.origin = CGPointMake(0, 0);
    overlayViewController.view.frame = frame;
    overlayViewController.delegate = self;
    [self.mOverlayView addSubview:overlayViewController.view];
    [self addChildViewController:overlayViewController];
    [self.mOverlayView setHidden:NO];
    
    [self.view bringSubviewToFront:self.mOverlayView];
    
}

- (IBAction)onThumbs:(id)sender
{
    [self onPlusButton:sender];
}

- (IBAction)onOtherMeasuresOrColours:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if ([btn isEqual:self.btnOtherMeasures])
    {
        NSLog(@"Other Measure button is selected.");
        
        [self.btnOtherMeasures setTitleColor:[UIColor colorWithRed:0 green:78/255.0 blue:152/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.otherMeasureUnderline setHidden:NO];
        [self.btnColours setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.coloursUnderline setHidden:YES];
        
        [self.btnOtherMeasures setEnabled:NO];
        [self.btnColours setEnabled:YES];
        
        [self.mOtherMeasuresCollectionView setHidden:NO];
        [self.mColoursCollectionView setHidden:YES];
        
        [self setContentHeightWithCollectionView:self.mOtherMeasuresCollectionView];
        
    }
    else if ([btn isEqual:self.btnColours])
    {
        NSLog(@"Colours button is selected.");
        
        [self.btnOtherMeasures setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.otherMeasureUnderline setHidden:YES];
        [self.btnColours setTitleColor:[UIColor colorWithRed:0 green:78/255.0 blue:152/255.0f alpha:1.0] forState:UIControlStateNormal];
        [self.coloursUnderline setHidden:NO];
        
        [self.btnColours setEnabled:NO];
        [self.btnOtherMeasures setEnabled:YES];
        
        [self.mOtherMeasuresCollectionView setHidden:YES];
        [self.mColoursCollectionView setHidden:NO];
        
        [self setContentHeightWithCollectionView:self.mColoursCollectionView];
        
    }
    
}



#pragma mark - Overlay delegate
- (void)didCloseOverlay
{
    [self.mOverlayView setHidden:YES];
}


@end
