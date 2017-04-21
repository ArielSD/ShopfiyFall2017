//
//  ASDAPIClient.h
//  ShopfiyFall2017
//
//  Created by Ariel Scott-Dicker on 4/21/17.
//  Copyright © 2017 Ariel Scott-Dicker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASDAPIClient : NSObject

+ (void)getOrdersWithSuccess:(void (^) (NSDictionary *orderInformation))success
                     failure:(void (^) (NSError *error))failure;

@end
