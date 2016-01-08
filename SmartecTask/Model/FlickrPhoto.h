//
//  FlickrPhoto.h
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrPhoto : NSObject

@property (nonatomic,strong) NSString * userId ;
@property (nonatomic,strong) NSString * photoTitle ;
@property (nonatomic,strong) NSString * photoSmallImageData ;
@property (nonatomic,strong) NSString * photoURLsLargeImage ;

-(instancetype)initWithTitle:(NSString *)title smallImageData:(NSString *)smallImageData largeImageUrl:(NSString *)photoURLsLargeImage userId:(NSString *)userId;

@end
