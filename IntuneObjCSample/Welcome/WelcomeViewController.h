//
//  WelcomeViewController.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WelcomeViewController : UIViewController
@property (nonatomic) IBOutlet UIImageView *userProfilePhoto;
@property (nonatomic) IBOutlet UILabel *userDisplayName;
@property (nonatomic) IBOutlet UILabel *userEmail;
@end

NS_ASSUME_NONNULL_END
