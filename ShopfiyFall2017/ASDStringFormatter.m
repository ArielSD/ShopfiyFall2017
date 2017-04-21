//
//  ASDStringFormatter.m
//  ShopfiyFall2017
//
//  Created by Ariel Scott-Dicker on 4/21/17.
//  Copyright © 2017 Ariel Scott-Dicker. All rights reserved.
//

#import "ASDStringFormatter.h"

@implementation ASDStringFormatter

+ (NSString *)formatTotalRevenueStringFromNumber:(NSNumber *)number {
    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = 2;
    numberFormatter.roundingMode = NSNumberFormatterRoundHalfDown;
    
    return [numberFormatter stringFromNumber:number];
}

@end
