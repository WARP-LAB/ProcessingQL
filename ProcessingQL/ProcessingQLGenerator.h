/*
 ProcessingQLGenerator.h
 
 Processing Quick Look plugin
 Copyright (C) kroko
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#import <Foundation/Foundation.h>
#import <QuickLook/QuickLook.h>
#import <AppKit/AppKit.h> // For NSAttributedString Additions

// Defining thumbnail width-> max icns size introduced in Leo (512x512)
#define thumbnailWidth (512)
#define thumbnailHeight (512)


@interface ProcessingQLGenerator : NSObject {
	NSString *sketchContentsStr; // place where shetch data (string) is stored
	NSURL *sketchUrl; // keep the track to the url pointer
}

- (id) initWithContentsOfURL:(NSURL *)url;
- (void) dealloc;

/*	===============================================================
	PREVIEW
	=============================================================== */
- (NSDictionary *) previewProperties;
- (NSData *) previewData;

/*	===============================================================
	THUMBNAIL
	=============================================================== */

- (NSSize) thumbnailSize;

// Draw directly into context
 - (void) drawThumbnailInContext:(NSGraphicsContext *)context;


// Return as CGImageRef
- (CGImageRef) thumbnailCgImage;

/*
// Return as TIFF
- (NSDictionary *) thumbnailProperties;
- (NSData *) thumbnailData;
*/

/*	===============================================================
	COLORISE
	=============================================================== */
- (NSAttributedString *) colorise;



@end