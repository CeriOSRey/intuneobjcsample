//
//  CalendarTableViewController.m
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import "CalendarTableViewController.h"
#import "CalendarTableViewCell.h"
#import <MSGraphClientModels/MSGraphClientModels.h>

@interface CalendarTableViewController ()

@end

@implementation CalendarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.events ? self.events.count : 0;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell"];
    
    // get the event that corresponds to the row
    MSGraphEvent* event = self.events[indexPath.row];
    
    // configure the cell
    cell.subject = event.subject;
    cell.organizer = event.organizer.emailAddress.name;
    cell.duration = [NSString stringWithFormat:@"%@ to %@",
                     [self formatGraphDateTime:event.start],
                     [self formatGraphDateTime:event.end]];
    
    return cell;
}

- (NSString*) formatGraphDateTime:(MSGraphDateTimeTimeZone*) dateTime {
    // create a formatter to parse Graph's date format
    NSDateFormatter* isoFormatter = [[NSDateFormatter alloc] init];
    isoFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSSSSS";
    
    // specify the time zone
    isoFormatter.timeZone = [[NSTimeZone alloc] initWithName:dateTime.timeZone];
    NSDate* date = [isoFormatter dateFromString:dateTime.dateTime];
    
    // output like 3/27/2022, 6:00 PM
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    
    NSString* dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void) setEvents:(NSArray<MSGraphEvent *> *)events {
    _events = events;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    
}

@end
