//
//  CalendarTableViewCell.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarTableViewCell : UITableViewCell
@property (nonatomic) NSString* subject;
@property (nonatomic) NSString* organizer;
@property (nonatomic) NSString* duration;

@end

NS_ASSUME_NONNULL_END
