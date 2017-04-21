//
//  ASDViewController.m
//  ShopfiyFall2017
//
//  Created by Ariel Scott-Dicker on 4/21/17.
//  Copyright © 2017 Ariel Scott-Dicker. All rights reserved.
//

#import "ASDViewController.h"
#import "ASDAPIClient.h"
#import "ASDStringFormatter.h"

@interface ASDViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *cottonKeyboardsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalRevenueLabel;
@property (weak, nonatomic) IBOutlet UIButton *tryAgainButton;

@end

@implementation ASDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self processOrder];
}

#pragma mark - Helper Methods

- (void)processOrder {
    [self.activityIndicator startAnimating];
    self.tryAgainButton.hidden = YES;
    
    [ASDAPIClient getOrdersWithSuccess:^(NSDictionary *orderInformation) {
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.activityIndicator stopAnimating];
            self.cottonKeyboardsLabel.text = [NSString stringWithFormat:@"Aerodynamic Cotton Keyboards: %@", orderInformation[@"aerodynamicCottonKeyboards"]];
            self.totalRevenueLabel.text = [NSString stringWithFormat:@"Total Revenue: %@ CAD", [ASDStringFormatter formatTotalRevenueStringFromNumber:orderInformation[@"totalRevenue"]]];
        });
    }
                               failure:^(NSError *error) {
                                   [self.activityIndicator stopAnimating];
                                   [self showErrorAlertView];
                                   NSLog(@"Error: %@", error);
                               }];
}

- (void)showErrorAlertView {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Something's up..."
                                                                             message:@"Check your network!"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         self.tryAgainButton.hidden = NO;
                                                     }];
    
    [alertController addAction:okAction];
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

- (IBAction)tryAgainButtonTapped:(id)sender {
    [self processOrder];
}

@end
