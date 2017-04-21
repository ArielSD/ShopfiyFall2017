//
//  ASDAPIClient.m
//  ShopfiyFall2017
//
//  Created by Ariel Scott-Dicker on 4/21/17.
//  Copyright © 2017 Ariel Scott-Dicker. All rights reserved.
//

#import "ASDAPIClient.h"
#import <AFNetworking.h>

@implementation ASDAPIClient

#pragma mark - Network Calls

+ (void)getOrdersWithSuccess:(void (^)(NSDictionary *))success
                     failure:(void (^)(NSError *))failure {
    
    NSString *url = @"https://shopicruit.myshopify.com/admin/orders.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6";
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager GET:url
             parameters:nil
               progress:nil
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    NSNumber *aerodynamicCottonKeyboards = [self calculateTotalNumberOfAerodynamicCottonKeyboardsFromOrders:responseObject];
                    NSNumber *totalRevenue = [self calculateTotalRevenueFromOrders:responseObject];
                    
                    NSDictionary *orderInformation = @{@"aerodynamicCottonKeyboards" : aerodynamicCottonKeyboards,
                                                       @"totalRevenue" : totalRevenue};
                    
                    success(orderInformation);
                }
                failure:^(NSURLSessionDataTask *task, NSError *error) {
                    failure(error);
                }];
}

#pragma mark - Helper Methods

+ (NSNumber *)calculateTotalNumberOfAerodynamicCottonKeyboardsFromOrders:(NSDictionary *)orders {
    NSUInteger aerodynamicCottonKeyboards = 0;
    
    NSArray *ordersArray = orders[@"orders"];
    
    for (NSDictionary *order in ordersArray) {
        NSArray *lineItems = order[@"line_items"];
        
        for (NSDictionary *item in lineItems) {
            if ([item[@"title"] isEqualToString:@"Aerodynamic Cotton Keyboard"]) {
                aerodynamicCottonKeyboards += 1;
            }
        }
    }
    
    return @(aerodynamicCottonKeyboards);
}

+ (NSNumber *)calculateTotalRevenueFromOrders:(NSDictionary *)orders {
    float totalRevenue = 0;
    
    NSArray *ordersArray = orders[@"orders"];
    
    for (NSDictionary *order in ordersArray) {
        NSString *orderTotalPriceString = order[@"total_price"];
        float orderTotalPrice = [orderTotalPriceString floatValue];
        totalRevenue += orderTotalPrice;
    }
    
    return @(totalRevenue);
}

@end
