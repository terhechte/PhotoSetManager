//
//  PhotoController.m
//  PhotoSetManager
//
//  Created by Benedikt Terhechte on 8/25/14.
//  Copyright (c) 2014 Benedikt Terhechte. All rights reserved.
//

#import "PhotoController.h"
#import "PhotoSetModel.h"
#import "PhotoSetGrouper.h"
#import "PhotoViewerWindow.h"

@interface PhotoController () {
    PhotoViewerWindow *_viewerWindow;
}
@property NSMutableArray *openImages;
@end

@implementation PhotoController

- (IBAction)calculateSetsAction:(id)sender {
    PhotoSetModel *model = [[PhotoSetModel alloc] init];
    for (PhotoSetObject *object in self.photoDirectoryArrayController.arrangedObjects) {
        [model addDirectory:object.directory includeSubdirectories:object.includeSubdirectories];
    }
    NSArray *images = [model images];
    
    PhotoSetGrouper *grouper = [[PhotoSetGrouper alloc] init];
    self.photoSetArrayController.content = [grouper identifyGroupsForImages:images];
    
    
    self.photoSetArrayController.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"itemCount" ascending:NO]];
}

- (void) setSelectedSetIndexes:(NSIndexSet *)selectedSetIndexes {
    self->_selectedSetIndexes = selectedSetIndexes;
    
    if (!selectedSetIndexes || selectedSetIndexes.count==0)return;
    
    PhotoSetGroup *group = [self.photoSetArrayController.arrangedObjects objectAtIndex:selectedSetIndexes.firstIndex];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.imagesScrollView.contentView scrollToPoint:NSZeroPoint];
    });
    self.photosArrayController.content = group.items;
}

- (void) setSelectedImageIndexes:(NSIndexSet *)selectedImageIndexes {
    self->_selectedImageIndexes = selectedImageIndexes;
    
    if  (!selectedImageIndexes || selectedImageIndexes.count == 0)return;
    
    PhotoSetItem *item = [self.photosArrayController.arrangedObjects objectAtIndex:selectedImageIndexes.firstIndex];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:item.metadata options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.detailTextView.string = jsonString;
}

- (IBAction)addDirectoryAction:(id)sender {
    
    NSOpenPanel* openDlg = [NSOpenPanel openPanel];
    
    // Enable the selection of files in the dialog.
    [openDlg setCanChooseFiles:NO];
    
    // Enable the selection of directories in the dialog.
    [openDlg setCanChooseDirectories:YES];
    
    // Display the dialog.  If the OK button was pressed,
    // process the files.
    [openDlg beginWithCompletionHandler:^(NSInteger result) {
        if (result == NSModalResponseOK) {
            NSURL *result = [openDlg URL];
            if (!result)return;
            
            PhotoSetObject *object = [[PhotoSetObject alloc] init];
            object.directory = result;
            
            [self.photoDirectoryArrayController addObject:object];
        }
    }];
}

- (void) imageBrowser:(IKImageBrowserView *) aBrowser cellWasDoubleClickedAtIndex:(NSUInteger) index {
    PhotoSetItem *item = [self.photosArrayController.arrangedObjects objectAtIndex:index];
    
    PhotoViewerWindow *aViewerWindow = [[PhotoViewerWindow alloc] initWithPhoto:item parentSize:self.window.frame.size];
    
    _viewerWindow = aViewerWindow;
    
    if (!self.openImages)self.openImages = @[].mutableCopy;
    
    [self.openImages addObject:aViewerWindow];
    
}

@end
