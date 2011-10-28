/*
 GeneratePreviewForURL.m
 
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

#import "ProcessingQLGenerator.h" // Our generator

OSStatus GeneratePreviewForURL(void *thisInterface, QLPreviewRequestRef preview, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options)
{
	if (!QLPreviewRequestIsCancelled(preview)) {
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		ProcessingQLGenerator * generator = [[[ProcessingQLGenerator alloc] initWithContentsOfURL:(NSURL *)url] autorelease];
		if(generator) {
			QLPreviewRequestSetDataRepresentation(preview, (CFDataRef)[generator previewData], kUTTypeRTF, (CFDictionaryRef)[generator previewProperties]);
		}
		else {
			// Else we coud do a one more try here- simply showing data found in url as a plain text
			NSData * plainString;
			if((plainString = [NSData dataWithContentsOfURL:(NSURL *)url]))
			{
				QLPreviewRequestSetDataRepresentation(preview, (CFDataRef)plainString, kUTTypePlainText, NULL);	
			}
		}
		[pool release];
	}
	return noErr;
}

void CancelPreviewGeneration(void* thisInterface, QLPreviewRequestRef preview)
{
    // implement only if supported
}
