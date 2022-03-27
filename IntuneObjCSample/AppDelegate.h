//
//  AppDelegate.h
//  IntuneObjCSample
//
//  Created by Rey Cerio on 2022-03-27.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

