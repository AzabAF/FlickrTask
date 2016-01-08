//
//  FlickrPhotosTableViewController.m
//  Ahmed Azab
//
//  Created by Ahmed Azab on 08/01/2016.
//  Copyright (c) 2016 AhmedAzab. All rights reserved.
//

#import "FlickrPhotosTableViewController.h"
#import "FetchPhotos.h"
#import "FlickrPhotoTableViewCell.h"
#import "MorePhotosTableViewController.h"

@interface FlickrPhotosTableViewController () <FetchPhotosDelegate,UISearchBarDelegate, UISearchResultsUpdating>
{
    FetchPhotos * fetchPhotos ;
}

@property (nonatomic,strong)UIActivityIndicatorView * loadIndicator ;
@property (strong, nonatomic) UISearchController *searchController;

@end

@implementation FlickrPhotosTableViewController

#pragma mark - ViewLifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initLoadIndicator];
    [self initFetchPhotos];
    [self initSearchController];
    
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
    [fetchPhotos getFlickrPhotosWithSearchKey:@"-" userId:@""];
    [fetchPhotos setDelegate:self];
}
-(void)initSearchController
{
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.placeholder =  @"search";
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangePreferredContentSize:)
                                                 name:UIContentSizeCategoryDidChangeNotification object:nil];
}

#pragma mark - Observers
- (void)didChangePreferredContentSize:(NSNotification *)notification
{
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [fetchPhotos numberOfFetchedPhotos];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"FlickrPhotoCell" ;
    
    FlickrPhotoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    [cell updateCellWithFlickr:[fetchPhotos flickrPhotoAtIndex:indexPath.row]];
    
    return cell;
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

#pragma mark - UISearchbarMethods

- (void)filterContentForSearchText:(NSString*)searchText
{
    
    [fetchPhotos getFlickrPhotosWithSearchKey:searchText userId:@""];
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    [_loadIndicator startAnimating];
    [self filterContentForSearchText:searchController.searchBar.text];
    
}

#pragma mark - Navigation

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MorePhotosVC"]) {
        NSInteger selectedRow = [[self.tableView indexPathForSelectedRow]row];
        FlickrPhoto * selectedPhoto = [fetchPhotos flickrPhotoAtIndex:selectedRow];
        
        MorePhotosTableViewController * morePhotosVC = segue.destinationViewController ;
        
        [morePhotosVC setUserId:selectedPhoto.userId];
    }
}

@end
