PhotoSetManager
=====

## Group loads of pictures based on metadata

![Screenshot](/resources/icon.png)

This is an early version of an app that I oftentimes wished I had but never found the right solution for. It should let you group huge amounts of images based on various image metadata like the camera that was used, where it was taken or when it was taken. Currently, only support for grouping by camera works.

The need for this usually arises when you're doing something with many friends, and everybody takes pictures, and then you get these pictures all on one USB stick or in one folder and differentiating between creators, and events, becomes a pain. iPhoto provides a good solution to this, but sometimes I don't want to import all these pictures into iPhoto first, only to identify groups.

This code was written really fast and sloppily, but it still works well.

## Current 0.1.0 features

- Group images by camera used to take them
- Add multiple directories to group into one
- Checkbox for each directory to read recursive (i.e. with all subdirectories)
- Will not modify your images or directories, basically read-only
- Doubleclick images to open them in a detail view
- "Details" button shows all metadata for a selected image

## Obligatory Screenshot

![Screenshot](/binary/screenshot.jpg)

## There's a binary here:

[Download Argh 0.1.0](/binary/PhotoSetManager-0.1.0.zip)

## Todo
- Add support for sorting by more metadata fields
- Cache the metadata extraction results in a SQLite database or CoreData
- Move the metadata extraction into a NSOperation so that it doesn't block the interface
- Add unit tests once the project progresses past version 0.1

## Author
- Benedikt Terhechte
- [@terhechte](http://twitter.com/terhechte)
- [terhech.de](http://www.terhech.de)
- [appventure.me](http://appventure.me)
