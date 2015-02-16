//
//  ViewController.m
//  savetest
//
//  Created by hmhv on 2/11/15.
//  Copyright (c) 2015 hmhv. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Singer.h"
#import "Song.h"
#import <mach/mach_time.h>  // for mach_absolute_time() and friends

CGFloat BNRTimeBlock (void (^block)(void)) {
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return -1.0;
    
    uint64_t start = mach_absolute_time ();
    block ();
    uint64_t end = mach_absolute_time ();
    uint64_t elapsed = end - start;
    
    uint64_t nanos = elapsed * info.numer / info.denom;
    return (CGFloat)nanos / NSEC_PER_SEC;
    
} // BNRTimeBlock

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *objectCountTextField;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)mainDirectSave:(id)sender
{
    NSManagedObjectContext *moc = [self mainDirectContext];
    
    NSInteger objectCount = [self.objectCountTextField.text integerValue];
    
    [moc performBlock:^{
        
        NSLog(@"MAIN DIRECT : Start Create Object");
        
        [self createObject:objectCount inManagedObjectContext:moc];
        
        NSLog(@"MAIN DIRECT : End Create Object");

        mach_timebase_info_data_t info;
        if (mach_timebase_info(&info) == KERN_SUCCESS)
        {
            NSLog(@"MAIN DIRECT : Start Save");

            uint64_t start = mach_absolute_time ();
            
            [moc save:nil];
            
            uint64_t end = mach_absolute_time ();
            uint64_t elapsed = end - start;
        
            NSLog(@"MAIN DIRECT : End Save");
            
            uint64_t nanos = elapsed * info.numer / info.denom;

            NSLog(@"MAIN DIRECT : %f", (CGFloat)nanos / NSEC_PER_SEC);
        }
    }];
}

- (IBAction)backDirectSave:(id)sender
{
    NSManagedObjectContext *moc = [self backDirectContext];
    
    NSInteger objectCount = [self.objectCountTextField.text integerValue];
    
    [moc performBlock:^{
        
        NSLog(@"BACK DIRECT : Start Create Object");
        
        [self createObject:objectCount inManagedObjectContext:moc];
        
        NSLog(@"BACK DIRECT : End Create Object");
        
        mach_timebase_info_data_t info;
        if (mach_timebase_info(&info) == KERN_SUCCESS)
        {
            NSLog(@"BACK DIRECT : Start Save");
            
            uint64_t start = mach_absolute_time ();
            
            [moc save:nil];
            
            uint64_t end = mach_absolute_time ();
            uint64_t elapsed = end - start;
            
            NSLog(@"BACK DIRECT : End Save");
            
            uint64_t nanos = elapsed * info.numer / info.denom;
            
            NSLog(@"BACK DIRECT : %f", (CGFloat)nanos / NSEC_PER_SEC);
        }
    }];
}

- (IBAction)DualSave:(id)sender
{
    NSManagedObjectContext *moc = [self dualContext];
    
    NSInteger objectCount = [self.objectCountTextField.text integerValue];
    
    [moc performBlock:^{
        
        NSLog(@"Dual : Start Create Object");
        
        [self createObject:objectCount inManagedObjectContext:moc];
        
        NSLog(@"Dual : End Create Object");
        
        mach_timebase_info_data_t info;
        if (mach_timebase_info(&info) == KERN_SUCCESS)
        {
            NSLog(@"Dual : Start Save");
            
            uint64_t start1 = mach_absolute_time ();
            
            [moc save:nil];

            uint64_t end1 = mach_absolute_time ();
            
            [moc.parentContext performBlock:^{
                
                uint64_t start2 = mach_absolute_time ();

                [moc.parentContext save:nil];
                
                uint64_t end2 = mach_absolute_time ();
                uint64_t elapsed1 = end1 - start1;
                uint64_t elapsed2 = end2 - start2;
                
                NSLog(@"Dual : End Save");
                
                uint64_t nanos1 = elapsed1 * info.numer / info.denom;
                uint64_t nanos2 = elapsed2 * info.numer / info.denom;
                
                NSLog(@"Dual : %f : %f", (CGFloat)nanos1 / NSEC_PER_SEC, (CGFloat)nanos2 / NSEC_PER_SEC);
            }];
        }
    }];
}


- (void)createObject:(NSInteger)count inManagedObjectContext:(NSManagedObjectContext *)context
{
    for (int i = 0; i < count; i++)
    {
        Singer *singer = [NSEntityDescription insertNewObjectForEntityForName:@"Singer" inManagedObjectContext:context];
        
        singer.p1 = @"p1";
        singer.p2 = @"p2";
        singer.p3 = @"p3";
        singer.p4 = [NSDate date];
        singer.p5 = @(i);
        
        int songCount = (i % 3) + 1;
        
        for (int j = 0; j < songCount; j++)
        {
            Song *song = [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:context];
            
            song.p1 = @"p1";
            song.p2 = [NSDate date];
            song.p3 = @(j);
            
            [singer addSongsObject:song];
        }
    }
}

- (IBAction)hideKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"savetest" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

- (NSManagedObjectContext *)mainDirectContext
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"savetest_main_direct.sqlite"];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    return managedObjectContext;
}

- (NSManagedObjectContext *)backDirectContext
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"savetest_back_direct.sqlite"];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [managedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    return managedObjectContext;
}

- (NSManagedObjectContext *)dualContext
{
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"savetest_dual.sqlite"];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:nil];
    NSManagedObjectContext *baseManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [baseManagedObjectContext setPersistentStoreCoordinator:persistentStoreCoordinator];
    NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    managedObjectContext.parentContext = baseManagedObjectContext;
    return managedObjectContext;
}

@end
