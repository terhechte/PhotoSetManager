//
//  PhotoViewerWindow.h
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>
#import "PhotoSetModel.h"

@interface PhotoViewerWindow : NSWindowController
@property (weak) IBOutlet IKImageView *imageView;
@property (assign) NSSize parentWindowSize;
- (id) initWithPhoto:(PhotoSetItem*)photo parentSize:(NSSize)parentSize;
@end
