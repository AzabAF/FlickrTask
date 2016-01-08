//
//  FetchPhotos.m
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import "FetchPhotos.h"

#define FlickrAPIKey @"17fc0b4086318baf8138cbb88107b543"

@implementation FetchPhotos
{
    NSMutableArray  *flickrPhotos;
    
}

#pragma mark - Call Flickr API
-(void)getFlickrPhotosWithSearchKey:(NSString *)searchKey userId:(NSString *)userId
{
    if ([searchKey  isEqualToString: @""]) {
        searchKey = @"-";
    }
    //search the flickr photos that are tagged with the searchKey
    NSString *urlString =
    [NSString stringWithFormat:
     @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=40&format=json&nojsoncallback=1",
     FlickrAPIKey,searchKey];
    
    if (![userId isEqualToString:@""]) {
        urlString = [NSString stringWithFormat:@"%@&user_id=%@",urlString,userId] ;
    }
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self parseResponseObject:responseObject];
        [self.delegate fetchPhotosDidFinish:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate fetchPhotosFailedWithError:error];
    }];
    
}

-(void)parseResponseObject:(id)responseObject
{
    flickrPhotos = [[NSMutableArray alloc] init];

    // Build an array from the dictionary for easy access to each entry
    NSArray *photos = [[responseObject objectForKey:@"photos"] objectForKey:@"photo"];
    for (NSDictionary *photo in photos)
    {
        
        NSString *title = [photo objectForKey:@"title"];
        NSString * userId = [photo objectForKey:@"owner"];
        
        NSString *photoURLString =
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        
        photoURLString =
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        FlickrPhoto * flickrPhoto = [[FlickrPhoto alloc]initWithTitle:title smallImageData:photoURLString largeImageUrl:photoURLString userId:userId];
        
        [flickrPhotos addObject:flickrPhoto];
     
    }
}

#pragma mark - Helping Methods
-(int)numberOfFetchedPhotos
{
    return (int)flickrPhotos.count ;
}
-(FlickrPhoto *)flickrPhotoAtIndex:(NSInteger)index
{
    return [flickrPhotos objectAtIndex:index];
}

@end
