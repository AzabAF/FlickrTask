//
//  FetchPhotos.h
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "FlickrPhoto.h"

@protocol FetchPhotosDelegate;

@interface FetchPhotos : NSObject

// connect to Flickr API and parse the result
-(void)getFlickrPhotosWithSearchKey:(NSString *)searchKey userId:(NSString *)userId;

//Helping Methods For FlickrPhotos&MorePhotos TableVC
-(int)numberOfFetchedPhotos ;
-(FlickrPhoto *)flickrPhotoAtIndex:(NSInteger)index ;

@property id<FetchPhotosDelegate>delegate ;

@end


@protocol FetchPhotosDelegate

-(void)fetchPhotosDidFinish:(FetchPhotos *)fetchPhotos;
-(void)fetchPhotosFailedWithError:(NSError *)error;

@end