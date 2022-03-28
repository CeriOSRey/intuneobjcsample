//
//  NewEventViewController.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewEventViewController : UIViewController

@property (nonatomic) IBOutlet UITextField* subject;
@property (nonatomic) IBOutlet UITextField* attendees;
@property (nonatomic) IBOutlet UIDatePicker* start;
@property (nonatomic) IBOutlet UIDatePicker* end;
@property (nonatomic) IBOutlet UITextView* body;

@end

NS_ASSUME_NONNULL_END
