//
//  ProductsViewController.m
//  kis
//
//  Created by Mauro Olivo on 04/01/16.
//  Copyright © 2016 Mauro Olivo. All rights reserved.
//

#import "ProductsViewController.h"
#import "Config.h"
#import "FamilyCell.h"

@interface ProductsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *commLineLabel;

@end

@implementation ProductsViewController

/*
- (IBAction)goToCompany:(id)sender {
    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];

    SideMenuViewController * controller = [[NSClassFromString(@"FamilyViewController") alloc] initWithNibName:@"FamilyViewController" bundle:nil];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
    
    [self.familiesCollectionView registerClass:[FamilyCell class] forCellWithReuseIdentifier:@"familyCell"];
    self.familiesCollectionView.backgroundColor = [UIColor whiteColor];
    
    NSArray *families = [[Session singletonSession] getFamiliesFromCommLineId:self.commLineId];
    
    self.families = families;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - collectionview datasource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.families.count;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // Setup cell identifier
    static NSString *cellIdentifier = @"familyCell";
    
    /* Uncomment this block to use subclass-based cells */
    FamilyCell *cell = (FamilyCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *e = [self.families objectAtIndex:(long)indexPath.row];
    
    if( [[e valueForKey:@"img"] isKindOfClass:[NSString class]] ) {
        //NSLog(@"%@", [e valueForKey:@"img"]);
        cell.labelOutlet.text = [e valueForKey:@"title"];
        
        cell.labelOutlet.font = [UIFont fontWithName:@"ProximaNova-Light" size:15.0f];
        cell.labelOutlet.textColor = DARK_GRAY;
        
        
        NSString *imgPath = [NSString stringWithFormat:@"%@/%@%@",[[Session singletonSession] dataDirGet], CATALOG_FOLDER_NAME, [e valueForKey:@"img"]];
        
        NSLog(@"---%@", imgPath);
        if([[NSFileManager defaultManager] fileExistsAtPath:imgPath]){
            cell.imageOutlet.image = nil;
            cell.imageOutlet.image = [UIImage imageWithContentsOfFile:imgPath];
            
        } else {
            cell.imageOutlet.image = nil;
        }
    } else { cell.labelOutlet.text = @"void"; }

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
    //NSLog(@"%@", indexPath);
    
    NSDictionary *family = [self.families objectAtIndex:indexPath.row];
    
    [[Session singletonSession] currentFamilyDictionarySet:family];
    
    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];
    
    SideMenuViewController * controller = [[NSClassFromString(@"FamilyViewController") alloc] initWithNibName:@"FamilyViewController" bundle:nil];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}


@end
