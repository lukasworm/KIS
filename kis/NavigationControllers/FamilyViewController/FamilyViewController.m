//
//  FamilyViewController.m
//  kis
//
//  Created by Mauro Olivo on 11/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "FamilyViewController.h"
#import "Session.h"
#import "Config.h"
#import "ProductCell.h"

@interface FamilyViewController ()

@property (weak, nonatomic) IBOutlet UILabel *commLineLabel;
@property (weak, nonatomic) IBOutlet UILabel *familyLabel;

- (IBAction)backButton:(id)sender;


@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *family = [[Session singletonSession] currentFamilyDictionaryGet];
    
    self.familyLabel.textColor =  [COLORS valueForKey:[[[Session singletonSession] currentCatalogGet] stringByAppendingString:@"_TINT_COLOR"]];
    [self.familyLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:16.0f]];
    
    self.familyLabel.text = [family valueForKey:@"title"];
    
    
    self.commLineLabel.textColor =  [COLORS valueForKey:[[[Session singletonSession] currentCatalogGet] stringByAppendingString:@"_TINT_COLOR"]];
    [self.commLineLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:27.0f]];
    
    for (NSDictionary *menu in self.subMenuProducts) {
        
        if([[menu valueForKey:@"tag"] isEqualToString:[NSString stringWithFormat:@"%d", [[Session singletonSession] currentCommLineTagGet]]]){
            self.commLineLabel.text = [menu valueForKey:@"name"];
            NSString *u = [menu valueForKey:@"commLineId"];
            self.commLineId = [u intValue];
            break;
        }
    }
    
    //NSLog(@"%@", family);
    
    self.products = [[NSMutableArray alloc] init];
    NSDictionary *products = [[Session singletonSession] productsGet];
    
    for (NSString *p in [family valueForKey:@"products"]) {
        NSLog(@"%@", p);
        
        if( [products objectForKey:p] ) {
            // verifico che ci sia la chiave
            //NSLog(@"%@", [products valueForKey:p]);
            [self.products addObject:[products valueForKey:p]];
        }
    }
    
    //NSLog(@"%lu", (unsigned long)self.products.count);
    
    [self.productsCollectionView registerClass:[ProductCell class] forCellWithReuseIdentifier:@"productCell"];
    self.productsCollectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSLog(@"PR: %lu", (unsigned long)self.products.count);
    return self.products.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"productCell";
    
    /* Uncomment this block to use subclass-based cells */
    ProductCell *cell = (ProductCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // [cell.titleLabel setText:cellData];
    /* end of subclass-based cells block */
    
    NSDictionary *e = [self.products objectAtIndex:(long)indexPath.row];
    
    cell.labelOutlet.text = [e valueForKey:@"title"];
    
    cell.labelOutlet.font = [UIFont fontWithName:@"ProximaNova-Light" size:15.0f];
    cell.labelOutlet.textColor = DARK_GRAY;
    
    //cell.imageOutlet.image = [UIImage imageNamed:@"sample.jpg"];
    
    // Return the cell
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float collectionViewWidth = screenSize.width * 1475 / 2048.0f;
    
    float cellWidth = cellWidth = (collectionViewWidth - 60) / 4.0f;
    
    return CGSizeMake(cellWidth, cellWidth);
}

// 3
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 25, 0);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];
    
    SideMenuViewController *controller = [[NSClassFromString(@"ProductDetailsViewController") alloc] initWithNibName:@"ProductDetailsViewController" bundle:nil];
    
    controller.product = [self.products objectAtIndex:(long)indexPath.row];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
    
   
}


- (IBAction)backButton:(id)sender {
    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];
    
    SideMenuViewController * controller = [[NSClassFromString(@"ProductsViewController") alloc] initWithNibName:@"ProductsViewController" bundle:nil];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
}
@end
