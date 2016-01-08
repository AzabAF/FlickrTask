//
//  FlickrPhotoTableViewCell.h
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlickrPhoto.h"

@interface FlickrPhotoTableViewCell : UITableViewCell

-(void)updateCellWithFlickr:(FlickrPhoto*)flickrPhoto ;

@end
