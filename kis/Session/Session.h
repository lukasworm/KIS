//
//  Session.h
//  kis
//
//  Created by Mauro Olivo on 22/12/15.
//  Copyright © 2015 Mauro Olivo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Session : NSObject

+(Session *)singletonSession;

-(void)currentCatalogSet:(NSString *)currentCatalog;
-(NSString *)currentCatalogGet;
-(NSArray *)productsMenuGet;

-(NSDictionary *)productsGet;

-(void)currentFamilyDictionarySet:(NSDictionary *)currentFamilyDictionarySet;
-(NSDictionary *)currentFamilyDictionaryGet;

-(void)currentCommLineTagSet:(int)currentCommLineTag;
-(int)currentCommLineTagGet;

//-(NSString *)getCommLineStringFromId:(int)_id;
-(NSArray *)getFamiliesFromCommLineId:(int)_id;

-(NSString *)localeGet;
-(NSString *)dataDirGet;

@property (nonatomic, strong) NSString *currentCatalog;
@property (nonatomic, strong) NSString *locale;
@property int currentCommLineTag;

@property (nonatomic, strong) NSDictionary *currentFamilyDictionary;


@end
