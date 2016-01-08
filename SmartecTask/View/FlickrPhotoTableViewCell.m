//
//  FlickrPhotoTableViewCell.m
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import "FlickrPhotoTableViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface FlickrPhotoTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoTitle;

@end

@implementation FlickrPhotoTableViewCell


-(void)updateCellWithFlickr:(FlickrPhoto*)flickrPhoto
{
    NSString * imageName = flickrPhoto.photoSmallImageData;
    imageName = [imageName stringByReplacingOccurrencesOfString:@"http"
                                         withString:@"https"];
    
    NSURL * imageURL = [NSURL URLWithString:imageName]  ;
    _photoTitle.text = flickrPhoto.photoTitle ;

    //Letting AFNetworking handle from async downloads to caching management.
    _userImageView.image = nil;
    [_userImageView setImageWithURL:imageURL];
}

@end
