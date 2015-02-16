//
//  Singer.h
//  savetest
//
//  Created by hmhv on 2/11/15.
//  Copyright (c) 2015 hmhv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Song;

@interface Singer : NSManagedObject

@property (nonatomic, retain) NSString * p2;
@property (nonatomic, retain) NSString * p1;
@property (nonatomic, retain) NSString * p3;
@property (nonatomic, retain) NSDate * p4;
@property (nonatomic, retain) NSNumber * p5;
@property (nonatomic, retain) NSSet *songs;
@end

@interface Singer (CoreDataGeneratedAccessors)

- (void)addSongsObject:(Song *)value;
- (void)removeSongsObject:(Song *)value;
- (void)addSongs:(NSSet *)values;
- (void)removeSongs:(NSSet *)values;

@end
