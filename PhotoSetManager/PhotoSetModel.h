//
//  PhotoSetModel.h
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PhotoSetObject : NSObject
@property (retain) NSURL *directory;
@property (assign) bool includeSubdirectories;
- (NSArray*) images;
@end

@interface PhotoSetItem : NSObject {
    NSURL *_imageURL;
    NSImage *_image;
    CGImageSourceRef _source;
    NSDictionary *_metadata;
    NSDictionary *_attributes;
}
@property (readonly) NSArray *keywords;
@property (readonly) NSString *userComment;
@property (readonly) NSString *exifDateTime;
@property (readonly) NSDictionary *exif;
@property (readonly) NSDictionary *iptc;
@property (readonly) NSDictionary *gps;
@property (readonly) NSNumber *size;
@property (readonly) NSDictionary *metadata;

// computed from the metadata
@property (readonly) NSString *cameraMaker;
@property (readonly) NSString *cameraModel;

- (NSImage*)image;
- (NSURL*)url;

+ (PhotoSetItem*) itemWithURL:(NSURL*)url;
- (id) initWithURL:(NSURL*)url;
- (void) process;
@end

@interface PhotoSetModel : NSObject

- (void) addDirectory:(NSURL*)directory includeSubdirectories:(bool)includeSubs;

- (NSArray *)images;
@end
