//
//  Song.h
//  savetest
//
//  Created by hmhv on 2/11/15.
//  Copyright (c) 2015 hmhv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Singer;

@interface Song : NSManagedObject

@property (nonatomic, retain) NSString * p1;
@property (nonatomic, retain) NSDate * p2;
@property (nonatomic, retain) NSNumber * p3;
@property (nonatomic, retain) Singer *singer;

@end
