//
//  CalendarViewController.m
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import "CalendarViewController.h"
#import "CalendarTableViewController.h"
#import "SpinnerViewController.h"
#import "GraphManager.h"
#import "GraphToIana.h"
#import <MSGraphClientModels/MSGraphClientModels.h>

@interface CalendarViewController ()

@property SpinnerViewController* spinner;
@property CalendarTableViewController* tableView;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.spinner = [SpinnerViewController alloc];
    [self.spinner startWithContainer:self];
    
    // calculate the start and end of the current week
    NSString* timeZoneId = [GraphToIana
                            getIanaIdentifierFromGraphIdentifier:[GraphManager.instance graphTimeZone]];
    
    NSDate* now = [NSDate date];
    NSCalendar* calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone* timezone = [NSTimeZone timeZoneWithName:timeZoneId];
    [calendar setTimeZone:timezone];
    
    NSDateComponents* startOfWeekComponents = [calendar
                                               components:NSCalendarUnitCalendar |
                                               NSCalendarUnitYearForWeekOfYear |
                                               NSCalendarUnitWeekOfYear
                                               fromDate:now];
    NSDate* startOfWeek = [startOfWeekComponents date];
    NSDate* endOfWeek = [calendar dateByAddingUnit:NSCalendarUnitDay
                                             value:7
                                            toDate:startOfWeek
                                           options:0];
    
    // Convert start and end to ISO 8601 Strings
    NSISO8601DateFormatter* isoFormatter = [[NSISO8601DateFormatter alloc] init];
    NSString* viewStart = [isoFormatter stringFromDate:startOfWeek];
    NSString* viewEnd = [isoFormatter stringFromDate:endOfWeek];
    
    [GraphManager.instance
    getCalendarViewStartingAt:viewStart
     endingAt:viewEnd
     withCompletionBlock:^(NSArray<MSGraphEvent*>* _Nullable events, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.spinner stop];
            
            if (error) {
                // show error
                UIAlertController* alert = [UIAlertController
                                            alertControllerWithTitle:@"Error getting events"
                                            message:error.debugDescription
                                            preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* okButton = [UIAlertAction
                                           actionWithTitle:@"OK"
                                           style:UIAlertActionStyleDefault
                                           handler:nil];
                
                [alert addAction:okButton];
                [self presentViewController:alert animated:true completion:nil];
                return;
            }
            
            [self.tableView setEvents:events];
        });
    }];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // save a reference to the contained table view so
    // we can pass the results of the graph call to it
    if ([segue.destinationViewController isKindOfClass:[CalendarTableViewController class]]) {
        self.tableView = segue.destinationViewController;
    }
}

- (IBAction)showNewEventForm {
    [self performSegueWithIdentifier:@"showEventForm" sender:nil];
}

@end
