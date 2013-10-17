//
//  UIDevice+Additions.m
//  Scores
//
//  Created by Anca Calugar on 10/17/13.
//  Copyright (c) 2013 AJ. All rights reserved.
//

#import "UIDevice+Additions.h"

@implementation UIDevice (Additions)

+ (BOOL)isOS70OrGreater {
	return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f;
}

@end
