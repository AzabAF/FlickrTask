//
//  FlickrPhoto.m
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

-(instancetype)initWithTitle:(NSString *)title smallImageData:(NSString *)smallImageData largeImageUrl:(NSString *)photoURLsLargeImage userId:(NSString *)userId
{
    if (self = [super init]) {
        _photoTitle = title.length > 0 ? title : @"Untitled" ;
        _photoSmallImageData = smallImageData;
        _photoURLsLargeImage = photoURLsLargeImage;
        _userId = userId ;
    }
    
    return self ;
}

@end
