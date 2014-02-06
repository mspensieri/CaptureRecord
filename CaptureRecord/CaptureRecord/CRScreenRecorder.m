//
//  CRScreenRecorder.m
//  CaptureRecord
//
//  Created by Miscellaneum LLC on 8/16/12.
//  Copyright (c) 2012 Miscellaneum LLC. All rights reserved.
//
//  Licensed under the Cocoa Controls commercial license agreement, v1, included
//  with the original package and can also be found at:
//  <http://CocoaControls.com/licenses/v1/license.pdf>.
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

#import "CRScreenRecorder.h"

#import <UIKit/UIKit.h>
#import "CRDefines.h"
#import "CRUtils.h"
#include <dlfcn.h>
#include <stdio.h>

@implementation CRScreenRecorder

- (id)init {
  if ((self = [super init])) {
    _size = [UIScreen mainScreen].bounds.size;
  }
  return self;
}

- (void)renderInContext:(CGContextRef)context videoSize:(CGSize)videoSize {
    
    for (UIWindow *window in [UIApplication sharedApplication].windows)
    {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen])
        {
            // Modified from apple developer code sample : https://developer.apple.com/library/ios/qa/qa1714/_index.html
            
            // -renderInContext: renders in the coordinate space of the layer,
            // so we must first apply the layer's geometry to the graphics context
            CGContextSaveGState(context);
            // Center the context around the window's anchor point
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            // Apply the window's transform about the anchor point
            CGContextConcatCTM(context, [window transform]);
            // Offset by the portion of the bounds left of and above the anchor point
            CGContextTranslateCTM(context,
                                  -[window bounds].size.width * [[window layer] anchorPoint].x,
                                  -[window bounds].size.height * [[window layer] anchorPoint].y);
            
            CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, videoSize.height));
            
            // Render the layer hierarchy to the current context
            [[window layer] renderInContext:context];
            
            // Restore the context
            CGContextRestoreGState(context);
        }
    }

}

- (CGSize)size {
  return CGSizeMake(_size.width, _size.height);
}

@end
