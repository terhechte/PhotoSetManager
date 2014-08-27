//
//  PhotoController.h
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Quartz/Quartz.h>

@interface PhotoController : NSWindowController
@property (weak) IBOutlet NSArrayController *photoDirectoryArrayController;
@property (weak) IBOutlet NSArrayController *photoSetArrayController;
@property (weak) IBOutlet IKImageBrowserView *imageBrowserView;
@property (weak) IBOutlet NSArrayController *photosArrayController;
@property (weak) IBOutlet NSScrollView *imagesScrollView;
@property (weak) IBOutlet NSDrawer *detailDrawer;
@property (unsafe_unretained) IBOutlet NSTextView *detailTextView;

@property (nonatomic, retain) NSIndexSet *selectedSetIndexes;
@property (nonatomic, retain) NSIndexSet *selectedImageIndexes;

- (IBAction)calculateSetsAction:(id)sender;
- (IBAction)addDirectoryAction:(id)sender;
@end
