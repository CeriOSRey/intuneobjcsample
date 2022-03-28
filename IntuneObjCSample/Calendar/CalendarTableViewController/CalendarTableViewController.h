//
//  CalendarTableViewController.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <UIKit/UIKit.h>
#import <MSGraphClientModels/MSGraphClientModels.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarTableViewController : UITableViewController
@property (nonatomic) NSArray<MSGraphEvent*>* events;
@end

NS_ASSUME_NONNULL_END
