//
//  Session.m
//  kis
//
//  Created by Mauro Olivo on 22/12/15.
//  Copyright © 2015 Mauro Olivo. All rights reserved.
//

#import "Session.h"
#import "Config.h"

@implementation Session {

    NSArray *productsMenu;
    NSDictionary *products;
}

+(Session *)singletonSession {
    
    static dispatch_once_t predicate = 0;
    static Session *_singletonSession = nil;
    dispatch_once(&predicate,  ^{
        _singletonSession = [self new];
    });
    
    return _singletonSession;
}

-(void)currentCatalogSet:(NSString *)currentCatalog {
    
    self.currentCatalog = currentCatalog;
    products = nil;
    productsMenu = nil;
}

-(NSString *)currentCatalogGet {
    
    if(self.currentCatalog == nil) {
        self.currentCatalog = @"kis";
    }
    return self.currentCatalog;
}

-(void)currentCommLineTagSet:(int)currentCommLineTag {
    
    self.currentCommLineTag = currentCommLineTag;
}

-(int)currentCommLineTagGet {
    
    return  self.currentCommLineTag;
}

-(void)currentFamilyDictionarySet:(NSDictionary *)currentFamilyDictionary{
    
    self.currentFamilyDictionary = currentFamilyDictionary;
}

-(NSDictionary *)currentFamilyDictionaryGet {
    
    return self.currentFamilyDictionary;
}

-(NSArray *)productsMenuGet {

    
    
    if(!productsMenu) {
        

        NSString *nameCom = [NSString stringWithFormat:@"%@_com_%@.json", [[Session singletonSession] currentCatalogGet], [[Session singletonSession] localeGet]];
        
        NSError *error = nil;
        
        NSString *comPath = [NSString stringWithFormat:@"%@/%@/lang/%@/%@",self.dataDirGet,CATALOG_FOLDER_NAME,[[Session singletonSession] localeGet],nameCom];

        if([[NSFileManager defaultManager] fileExistsAtPath:comPath]){

            NSData *dataFromFile = [NSData dataWithContentsOfFile:comPath];
            NSDictionary *menu = [NSJSONSerialization JSONObjectWithData:dataFromFile
                                                                 options:kNilOptions
                                                                   error:&error];
            if (error == nil) {
                productsMenu = [menu valueForKey:@"commercial_lines"];
                return productsMenu;
            } else {
                NSLog(@"Error loding products menu json.");
                return nil;
            }
            
        } else {
            // ur code here**
            NSLog(@"UNABLE TO FIND comPath: %@", comPath);
            return nil;
        }
        
        
    } else { return productsMenu; }
}

-(NSDictionary *)productsGet {
    

    
    if(!products) {
        
        NSString *pathProd = @"kis_prod_it.json";
        
        NSError *error = nil;
        
        NSString *prodPath = [NSString stringWithFormat:@"%@/Catalog/lang/it/%@",self.dataDirGet,pathProd];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:prodPath]){
            // ur code here
            
            NSData *dataFromFile = [NSData dataWithContentsOfFile:prodPath];
            NSDictionary *p = [NSJSONSerialization JSONObjectWithData:dataFromFile
                                                              options:kNilOptions
                                                                error:&error];
            if (error == nil) {
                products = [p valueForKey:@"products"];
                return products;
            } else {
                NSLog(@"Error loding products menu json.");
                return nil;
            }
            
            
        } else {
            // ur code here**
            NSLog(@"UNABLE TO FIND kis_com_it.json DATA%@", prodPath);
            return nil;
        }
        
    } else { return products; }
}

/*
-(NSString *)getCommLineStringFromId:(int)_id {

    for (NSDictionary *cl in [self productsMenuGet]) {
        if([[cl valueForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%d",_id]]){
            return [cl valueForKey:@"title"];
        }
    }
    return @"";
}
*/

-(NSArray *)getFamiliesFromCommLineId:(int)_id {
    
    for (NSDictionary *cl in [self productsMenuGet]) {
        if([[cl valueForKey:@"id"] isEqualToString:[NSString stringWithFormat:@"%d",_id]]){
            return [cl valueForKey:@"families"];
        }
    }
    return nil;
}

-(NSString *)localeGet {

    if(!self.locale) {
        NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
        self.locale = [language substringToIndex:2];
    }
    return self.locale;
}

-(NSString *)dataDirGet {
    
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString * dataDir = [[fm URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil] path];
    
    return dataDir;
}



@end
