//
//  WelcomeViewController.m
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import "WelcomeViewController.h"
#import "AuthenticationManager.h"
#import "SpinnerViewController.h"
#import "GraphManager.h"
#import <MSGraphClientModels/MSGraphClientModels.h>

@interface WelcomeViewController ()
@property SpinnerViewController* spinner;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.spinner = [SpinnerViewController alloc];
    [self.spinner startWithContainer:self];
    
    self.userProfilePhoto.image = [UIImage imageNamed:@"DefaultUserPhoto"];
    [GraphManager.instance
     getMeWithCompletionBlock:^(MSGraphUser * _Nullable user, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stop];
            
            if (error) {
                //show error
                UIAlertController* alert = [UIAlertController
                                            alertControllerWithTitle:@"Error getting user profile" message:error.debugDescription preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:nil];
                
                [alert addAction:okButton];
                [self presentViewController:alert animated:true completion:nil];
                return;
            }
            
            // set display name
            self.userDisplayName.text = user.displayName ? : @"Some Person";
            [self.userDisplayName sizeToFit];
            
            // AAD users have email in the mail attribute
            // Personal accounts have email in the userPrincipalName attribute
            self.userEmail.text = user.mail ? : user.userPrincipalName;
            [self.userEmail sizeToFit];
            
            // save user timezone
            [GraphManager.instance setGraphTimeZone:(user.mailboxSettings.timeZone ? : @"UTC")];
        });
    }];
}

- (IBAction)signOut {
    [AuthenticationManager.instance signOut];
    [self performSegueWithIdentifier: @"userSignedOut" sender: nil];
}

@end
