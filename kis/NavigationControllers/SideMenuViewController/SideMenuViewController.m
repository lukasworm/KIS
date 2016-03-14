//
//  SideMenuViewController.m
//  kis
//
//  Created by Mauro Olivo on 19/12/15.
//  Copyright © 2015 Mauro Olivo. All rights reserved.
//

#import "SideMenuViewController.h"
#import "Config.h"

@interface SideMenuViewController ()
{
    CGSize _screenSize;
}

@property (weak, nonatomic) IBOutlet UIView *menuView;


@end

@implementation SideMenuViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _screenSize = [UIScreen mainScreen].bounds.size;
    
    [self buildMenu];
    [self buildProductsMenu];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [self addSideView];
    [self addMenu];
    [self setFooterMenu];
    [self setHeaderMenu];
    
}

-(void)loadController:(NSString *)c {
    NSMutableArray * mutableArray = [[self.navigationController viewControllers] mutableCopy];
    SideMenuViewController * controller = [[NSClassFromString(c) alloc] initWithNibName:c bundle:nil];
    
    [mutableArray replaceObjectAtIndex:[mutableArray count] -1  withObject:controller];
    [self.navigationController setViewControllers:mutableArray  animated:NO];
}

-(void)addSideView{
    
    sideMenuView = [[[NSBundle mainBundle] loadNibNamed:@"SideMenu" owner:self options:nil] objectAtIndex:0];
    float width = _screenSize.width * 462 / 2048.0f;
    float height = _screenSize.height;
    sideMenuView.frame = CGRectMake(0, 0, width, height);
    
    [self.view addSubview:sideMenuView];
    
}

- (void)triggerMenu:(UIButton *)sender {
    
    //NSLog(@"%ld", (long)sender.tag);
    
    switch (sender.tag) {
            
        case 11:
            [[Session singletonSession] currentCatalogSet:@"ap"];
            [self loadController:@"CompanyViewController"];
            break;
            
        case 12:
            [[Session singletonSession] currentCatalogSet:@"kis"];
            [self loadController:@"CompanyViewController"];
            break;
            
        case 13:
            [[Session singletonSession] currentCatalogSet:@"dblade"];
            [self loadController:@"CompanyViewController"];
            break;
            
        case 20:
            [self loadController:@"CompanyViewController"];
            break;
            
        case 40:
            [self loadController:@"VideoViewController"];
            break;
            
        case 50:
            [self loadController:@"OnstoreViewController"];
            break;
            
        case 60:
            [self loadController:@"EventsViewController"];
            break;
            
        case 70:
            [self loadController:@"PromoViewController"];
            break;
            
        case 90:
            [self loadController:@"UserAreaViewController"];
            break;
            
        default:
            break;
    }
    
    if(sender.tag >= 300 && sender.tag <= 399) {
        [[Session singletonSession] currentCommLineTagSet:(int)sender.tag];
        [self loadController:@"ProductsViewController"];
    } else { [[Session singletonSession] currentCommLineTagSet:0]; }
}

-(void)addMenu {

    
    float yOffset = 0.0;
    for(NSDictionary *voice in self.menu) {
        
        NSString *className = NSStringFromClass([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count] -1] class]);
        
        //NSLog(@"%f", yOffset);
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = [[voice objectForKey:@"tag"] intValue];
        [button setTitleColor:button.tintColor = [COLORS valueForKey:[[[[Session singletonSession] currentCatalogGet] uppercaseString] stringByAppendingString:@"_TINT_COLOR"]] forState:UIControlStateNormal];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];
        [button.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:27.0f]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self
                   action:@selector(triggerMenu:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[voice objectForKey:@"name"] forState:UIControlStateNormal];
        
        button.frame = CGRectMake(15.0, yOffset, 210.0, 52.0);
        
        UIImage *image = [[UIImage imageNamed:[[voice objectForKey:@"image"] stringByAppendingString:@"_off@2x.png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        
        //NSLog(@"%@", className);
        if([className isEqualToString:[voice objectForKey:@"controller"]] ||
           ([className isEqualToString:@"FamilyViewController"] && [[voice objectForKey:@"controller"] isEqualToString:@"ProductsViewController"])
           ) {
            image = [[UIImage imageNamed:[[voice objectForKey:@"image"] stringByAppendingString:@"_on@2x.png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        }
        
        [button setImage:image forState:UIControlStateNormal];
        button.tintColor = [COLORS valueForKey:[[[[Session singletonSession] currentCatalogGet] uppercaseString] stringByAppendingString:@"_TINT_COLOR"]];
        

        
        if([[voice objectForKey:@"controller"] isEqualToString:@"ProductsViewController"] && [[Session singletonSession] currentCommLineTagGet] >= 300 && [[Session singletonSession] currentCommLineTagGet] < 399) {
            [self addProductsMenu];
            yOffset +=  self.subMenuProducts.count * 26;
        } 

        [self.menuView addSubview:button];
        yOffset += 52;
        
    }
}

-(void)setHeaderMenu {

    NSDictionary *ap   = [[NSDictionary alloc] initWithObjectsAndKeys:@"ProductsViewController", @"controller",
                                   @"ap", @"catalog",
                                   @"ap", @"image",
                                   @"11", @"tag", nil];
    
    NSDictionary *kis  = [[NSDictionary alloc] initWithObjectsAndKeys:@"ProductsViewController", @"controller",
                                   @"kis", @"catalog",
                                   @"kis", @"image",
                                   @"12", @"tag", nil];
    
    NSDictionary *dblade = [[NSDictionary alloc] initWithObjectsAndKeys:@"ProductsViewController", @"controller",
                                   @"dblade", @"catalog",
                                   @"dblade", @"image",
                                   @"13", @"tag", nil];
    NSArray *headerMenu = [[NSArray alloc] initWithObjects:ap,kis,dblade, nil];

    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    float width = 130 * screenSize.width / 2048.0f;
    float xOffset = 16 * screenSize.width / 2048.0f;
    float padding = 15 * screenSize.width / 2048.0f;
    float yOffset = (180 * screenSize.height / 1536.0f - width);
    
    for(NSDictionary *voice in headerMenu) {
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = [[voice objectForKey:@"tag"] intValue];
        

        [button setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];

        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self
                   action:@selector(triggerMenu:)
         forControlEvents:UIControlEventTouchUpInside];
        
        button.frame = CGRectMake(xOffset, yOffset, width, width);
        
        
        UIImage *image = [UIImage imageNamed:[[voice objectForKey:@"image"] stringByAppendingString:@"_off.png"]] ;
        
        if( [[[Session singletonSession] currentCatalogGet] isEqualToString:[voice valueForKey:@"catalog"] ] )
        {
            image = [UIImage imageNamed:[[voice objectForKey:@"image"] stringByAppendingString:@"_on.png"]];
        }
        
        [button setImage:image forState:UIControlStateNormal];

        [self.view addSubview:button];
        xOffset += width + padding;
        
    }
    
    
}

-(void)setFooterMenu {
    sideMenuFooterView.backgroundColor = [COLORS valueForKey:[[[[Session singletonSession] currentCatalogGet] uppercaseString] stringByAppendingString:@"_TINT_COLOR"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = 90;
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(3, 10, 0, 0)];
    [button.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:27.0f]];
    
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button addTarget:self
               action:@selector(triggerMenu:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:NSLocalizedString(@"User Area", nil) forState:UIControlStateNormal];
    
    NSString *className = NSStringFromClass([[[self.navigationController viewControllers] objectAtIndex:[[self.navigationController viewControllers] count] -1] class]);
    
    UIImage *image = [[UIImage imageNamed:@"menu_fake_off@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    if([className isEqualToString:@"AreaUtenteController"]) {
        image = [[UIImage imageNamed:@"menu_fake_on@2x"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    float width = 462 * screenSize.width / 2048.0f;
    float height = 224 * screenSize.height / 1536.0f;
    button.frame = CGRectMake(15.0f, 0.0, width - 30, height);
    
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = USER_AREA_TINT;
    
    [sideMenuFooterView addSubview:button];
    
}

-(void)buildMenu {
    
    NSDictionary *menuCompany   = [[NSDictionary alloc] initWithObjectsAndKeys:@"CompanyViewController", @"controller",
                                   NSLocalizedString(@"Company", nil), @"name",
                                   @"menu_company", @"image",
                                   @"20", @"tag", nil];
    
    NSDictionary *menuProducts  = [[NSDictionary alloc] initWithObjectsAndKeys:@"ProductsViewController", @"controller",
                                   NSLocalizedString(@"Products", nil), @"name",
                                   @"menu_products", @"image",
                                   @"301", @"tag", nil];
    
    NSDictionary *menuVideo = [[NSDictionary alloc] initWithObjectsAndKeys:@"VideoViewController", @"controller",
                                   NSLocalizedString(@"Video", nil), @"name",
                                   @"menu_video", @"image",
                                   @"40", @"tag", nil];
    
    NSDictionary *menuOnstore = [[NSDictionary alloc] initWithObjectsAndKeys:@"OnstoreViewController", @"controller",
                                     NSLocalizedString(@"On Store", nil), @"name",
                                     @"menu_onstore", @"image",
                                     @"50", @"tag", nil];
    
    NSDictionary *menuEvents = [[NSDictionary alloc] initWithObjectsAndKeys:@"EventsViewController", @"controller",
                                   NSLocalizedString(@"Events", nil), @"name",
                                   @"menu_events", @"image",
                                   @"60", @"tag", nil];
    
    NSDictionary *menuPromo = [[NSDictionary alloc] initWithObjectsAndKeys:@"PromoViewController", @"controller",
                                   NSLocalizedString(@"Promo", nil), @"name",
                                   @"menu_promo", @"image",
                                   @"70", @"tag", nil];
    
    self.menu = [[NSArray alloc] initWithObjects:menuCompany, menuProducts, menuVideo, menuOnstore, menuEvents, menuPromo, nil];
}


-(void)addProductsMenu {
    
    
    float yOffset = 52.0 * 2;
    
    for(NSDictionary *voice in self.subMenuProducts) {

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = [[voice objectForKey:@"tag"] intValue];
        [button setTitleColor:button.tintColor = [COLORS valueForKey:[[[[Session singletonSession] currentCatalogGet] uppercaseString] stringByAppendingString:@"_TINT_COLOR"]] forState:UIControlStateNormal];
        [button setTitleColor:button.tintColor = [COLORS valueForKey:[[[Session singletonSession] currentCatalogGet] stringByAppendingString:@"_TINT_COLOR_HIGH"]] forState:UIControlStateHighlighted];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        [button.titleLabel setFont:[UIFont fontWithName:@"ProximaNova-Light" size:16.0f]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self
                   action:@selector(triggerMenu:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:[voice objectForKey:@"name"] forState:UIControlStateNormal];
        
        [button setImage:[UIImage imageNamed:@"arrow-none@2x.png"] forState:UIControlStateNormal];
        

        if( [[Session singletonSession] currentCommLineTagGet] == [[voice objectForKey:@"tag"] intValue]) {
            
            UIImage *image = [[UIImage imageNamed:@"arrow-right@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
            
            
            [button setImage:image forState:UIControlStateNormal];
            button.tintColor = [COLORS valueForKey:[[[[Session singletonSession] currentCatalogGet] uppercaseString] stringByAppendingString:@"_TINT_COLOR"]];
            
 //           [button setImage:[UIImage imageNamed:@"arrow-right@2x.png"] forState:UIControlStateNormal];
        }
        
        button.frame = CGRectMake(25.0, yOffset, 200.0, 24.0);

        [self.menuView addSubview:button];
        yOffset += 26;
        
    }
}

-(void) buildProductsMenu {
    
    NSArray *productsMenu = [[Session singletonSession] productsMenuGet];
    
   // NSLog(@"PIPPO %@", productsMenu);
    int tag = 301;
    
    self.subMenuProducts = [[NSMutableArray alloc] init];
    for (NSDictionary *menu in productsMenu) {
        
        NSDictionary *o = [[NSDictionary alloc] initWithObjectsAndKeys:@"ProductsViewController", @"controller",
         NSLocalizedString( [menu valueForKey:@"title"] , nil), @"name",
            [NSString stringWithFormat:@"%d",tag], @"tag",
             [menu valueForKey:@"id"], @"commLineId",
                           nil];
        
        [self.subMenuProducts addObject:o];
        tag++;
    }

   // NSLog(@"%@", self.subMenuProducts);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (BOOL) prefersStatusBarHidden
{
    return YES;
}

@end
