//
//  MorePhotosTableViewController.m
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import "MorePhotosTableViewController.h"
#import "FetchPhotos.h"
#import "FlickrPhotoTableViewCell.h"

@interface MorePhotosTableViewController () <FetchPhotosDelegate>
{
    FetchPhotos * fetchPhotos ;
}

@property (nonatomic,strong)UIActivityIndicatorView * loadIndicator ;

@end

@implementation MorePhotosTableViewController

#pragma mark - ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLoadIndicator];
    [self initFetchPhotos];
    
    [self addBackgroundColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helping Methods
-(void)addBackgroundColor
{
    #if defined(TARGET_LITE)
        
        [self.tableView setBackgroundColor:[UIColor grayColor]];//Colored version
    #else
        [self.tableView setBackgroundColor:[UIColor whiteColor]];//UN Colored version
    #endif
}

#pragma mark - Init Methods
-(void)initLoadIndicator
{
    _loadIndicator=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    [_loadIndicator setHidesWhenStopped:YES];
    
    [self.tableView addSubview:_loadIndicator];
    
    [_loadIndicator setCenter:self.tableView.center];
    [_loadIndicator startAnimating];
}
-(void)initFetchPhotos
{
    fetchPhotos = [[FetchPhotos alloc]init];
    [fetchPhotos getFlickrPhotosWithSearchKey:@"-" userId:_userId];
    [fetchPhotos setDelegate:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [fetchPhotos numberOfFetchedPhotos];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"MorePhotoCell" ;
    
    FlickrPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell updateCellWithFlickr:[fetchPhotos flickrPhotoAtIndex:indexPath.row]];
    
    return cell;
}
#pragma mark - TableView Delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80 ;
}


#pragma mark - Fetch Photos Delegate
-(void)fetchPhotosDidFinish:(FetchPhotos *)fetchPhotos
{
    [_loadIndicator stopAnimating];
    [self.tableView reloadData];
}

-(void)fetchPhotosFailedWithError:(NSError *)error
{
    [_loadIndicator stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", nil) message:[error localizedDescription] delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
    [alert show];
}

@end
