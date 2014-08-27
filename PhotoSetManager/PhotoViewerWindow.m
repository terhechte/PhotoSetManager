//
//  PhotoViewerWindow.m
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import "PhotoViewerWindow.h"

@interface PhotoViewerWindow () {
    PhotoSetItem *_item;
}

@end

@implementation PhotoViewerWindow

- (id) initWithPhoto:(PhotoSetItem*)photo parentSize:(NSSize)parentSize
{
    self = [super initWithWindowNibName:@"PhotoViewerWindow"];
    if (self) {
        _item = photo;
        self.parentWindowSize = parentSize;
        [self window];
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    [self.imageView setImageWithURL:_item.url];
    [self showWindow:self];
    
    NSSize newSize;
    
    // resize
    NSSize imageSize = _item.image.size;
    if (imageSize.width > self.parentWindowSize.width ||
        imageSize.height > self.parentWindowSize.height) newSize = self.parentWindowSize;
    else
        newSize = imageSize;
    
    if (newSize.width < self.window.frame.size.width || newSize.height < self.window.frame.size.height)return;
    
    [self.window setFrame:NSMakeRect(self.window.frame.origin.x, self.window.frame.origin.y, newSize.width, newSize.height) display:YES];
    
}

@end
