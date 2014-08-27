//
//  PhotoSetGrouper.h
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoSetGroup : NSObject
@property (retain) NSString *title;
@property (retain) NSArray *items;
@property (assign) NSUInteger itemCount;

@property (retain) NSImage *coverImage;
@end

@interface PhotoSetGrouper : NSObject
- (NSArray*) identifyGroupsForImages:(NSArray*) images;
@end
