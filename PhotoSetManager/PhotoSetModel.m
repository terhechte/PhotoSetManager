//
//  PhotoSetModel.m
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import "PhotoSetModel.h"
#import <Quartz/Quartz.h>

@implementation PhotoSetItem
+ (PhotoSetItem*) itemWithURL:(NSURL*)url {
    return [[PhotoSetItem alloc] initWithURL:url];
}
- (id) initWithURL:(NSURL*)url {
    self = [super init];
    if (self) {
        _imageURL = url;
    }
    return self;
}

- (void) process {
    _image = [[NSImage alloc] initByReferencingURL:_imageURL];
    _source = CGImageSourceCreateWithURL((CFURLRef)_imageURL, NULL);
    CFDictionaryRef metadataRef = CGImageSourceCopyPropertiesAtIndex(_source,0,NULL);
    if(metadataRef) {
        NSDictionary *immutableMetadata = (__bridge NSDictionary *)metadataRef;
        _metadata = [immutableMetadata copy];
        CFRelease(metadataRef);
    }
    _attributes = [[NSFileManager defaultManager]
                   attributesOfItemAtPath:_imageURL.path
                   error:nil];
    
    // assign attributes
    self->_cameraMaker = [_metadata valueForKeyPath:@"{TIFF}.Make"];
    self->_cameraModel = [_metadata valueForKeyPath:@"{TIFF}.Model"];
}

- (NSImage*) image {
    return _image;
}

- (NSDictionary*) metadata {
    return _metadata;
}

- (NSString *)exifDateTime {
    NSDictionary *exif = [_metadata valueForKey:(NSString *)kCGImagePropertyExifDictionary];
    return [exif valueForKey:(NSString *)kCGImagePropertyExifDateTimeOriginal];
}

- (NSArray *)keywords {
    return [[self iptc] valueForKey:(NSString *)kCGImagePropertyIPTCKeywords];
}

- (NSString *)userComment {
    return [[self exif] valueForKey:(NSString *)kCGImagePropertyExifUserComment];
}

- (NSDictionary *)exif {
    return [_metadata valueForKey:(NSString *)kCGImagePropertyExifDictionary];
}

- (NSDictionary *)iptc {
    return [_metadata valueForKey:(NSString *)kCGImagePropertyIPTCDictionary];
}

- (NSDictionary *)gps {
    return [_metadata valueForKey:(NSString *)kCGImagePropertyGPSDictionary];
}

- (NSNumber*) size {
    return [_attributes objectForKey:NSFileSize];
}

- (NSString *) imageUID {
    return _imageURL.absoluteString;
}

- (NSString *) imageTitle {
    return [_imageURL pathComponents].lastObject;
}

- (NSString *) imageRepresentationType {
    //return IKImageBrowserNSURLRepresentationType;
    return IKImageBrowserNSImageRepresentationType;
}

- (id) imageRepresentation {
    //return _imageURL;
    return _image;
}

- (NSURL*)url {
    return _imageURL;
}

@end

@implementation PhotoSetObject

- (NSArray*) images
{
    NSFileManager *localFileManager=[[NSFileManager alloc] init];
    
    NSMutableArray *imageItems = @[].mutableCopy;
    
    if (!self.includeSubdirectories) {
        NSArray *items = [localFileManager contentsOfDirectoryAtURL:self.directory includingPropertiesForKeys:@[NSURLAttributeModificationDateKey, NSURLIsDirectoryKey]
                                                            options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
        for (NSURL *theURL in items) {
            NSNumber *isDirectory;
            [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
        
            if (isDirectory.boolValue)continue;
            
            [imageItems addObject:[PhotoSetItem itemWithURL:theURL]];
        }
    } else {
        NSDirectoryEnumerator *dirEnumerator =
        [localFileManager enumeratorAtURL:self.directory
               includingPropertiesForKeys:@[NSURLAttributeModificationDateKey, NSURLIsDirectoryKey]
                                  options:NSDirectoryEnumerationSkipsHiddenFiles
                             errorHandler:nil];
        
        for (NSURL *theURL in dirEnumerator) {
            NSNumber *isDirectory;
            [theURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:NULL];
            
            if (isDirectory.boolValue)continue;
            
            [imageItems addObject:[PhotoSetItem itemWithURL:theURL]];
            
        }
    }
    
    return imageItems.copy;
}
@end

@interface PhotoSetModel()
{
    NSMutableArray *_directories;
}

@end

@implementation PhotoSetModel

- (void) addDirectory:(NSURL*)directory includeSubdirectories:(bool)includeSubs {
    if (!_directories)_directories = [@[] mutableCopy];
    PhotoSetObject *o = [[PhotoSetObject alloc] init];
    o.includeSubdirectories = includeSubs;
    o.directory = directory;
    [_directories addObject:o];
}

- (NSArray *)images {
    NSMutableArray *a = @[].mutableCopy;
    for (PhotoSetObject *o in _directories) {
        [a addObjectsFromArray:o.images];
    }
    
    return a.copy;
}

@end
