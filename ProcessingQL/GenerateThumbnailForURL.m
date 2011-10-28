/*
 GenerateThumbnailForURL.m
 
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

#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#import <Foundation/Foundation.h> // For basic Cocoa

#import "ProcessingQLGenerator.h"

// Set up icon decor
const CFStringRef kQLThumbnailOptionIconModeKey = CFSTR("kCFBooleanTrue");

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
	if (!QLThumbnailRequestIsCancelled(thumbnail)) {
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		ProcessingQLGenerator * generator = [[[ProcessingQLGenerator alloc] initWithContentsOfURL:(NSURL *)url] autorelease];

		
		// Use QLThumbnailRequestCreateContext
		/*
		if(generator) {
			NSSize thumbnailSize = [generator thumbnailSize];
			CGContextRef cgContext = QLThumbnailRequestCreateContext(thumbnail, *(CGSize *)&thumbnailSize, TRUE, NULL);
			if(cgContext) {
				NSGraphicsContext* nsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)cgContext flipped:NO];
				if(nsContext) {
					[generator drawThumbnailInContext:nsContext];
				}
				QLThumbnailRequestFlushContext(thumbnail, cgContext);
				if(cgContext) CFRelease(cgContext);
			}
		}		
		*/
		
		
		// Use QLThumbnailRequestSetImage without calling QLThumbnailRequestGetMaximumSize
		if(generator) {
			CGImageRef cgImage = [generator thumbnailCgImage];
			if(cgImage && !QLThumbnailRequestIsCancelled(thumbnail)) {
				QLThumbnailRequestSetImage(thumbnail,cgImage,nil);
				CGImageRelease(cgImage);
			}
		}
		
		
		/*
		 // Use QLThumbnailRequestSetImageWithData
		 if(generator) {
		 QLThumbnailRequestSetImageWithData(thumbnail,(CFDataRef)[generator thumbnailData],CFDictionaryRef[generator thumbnailProperties]);			
		 }
		 */
		
		[pool release];
	}
	return noErr;

}

void CancelThumbnailGeneration(void* thisInterface, QLThumbnailRequestRef thumbnail)
{
    // implement only if supported
}

