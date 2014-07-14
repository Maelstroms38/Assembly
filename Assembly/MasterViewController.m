//
//  MasterViewController.m
//  Assembly
//
//  Created by Michael Stromer on 6/26/14.
//  Copyright (c) 2014 Michael Stromer. All rights reserved.
//

#import "Group.h"
#import "MeetupManager.h"
#import "MeetupCommunicator.h"
#import "MasterViewController.h"
#import "DetailCell.h"

@interface MasterViewController () <MeetupManagerDelegate> {
    NSArray *_groups;
    MeetupManager *_manager;
}
@property (weak, nonatomic) CLLocationManager *locationManager;
@end

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	_manager = [[MeetupManager alloc] init];
    _manager.communicator = [[MeetupCommunicator alloc] init];
    _manager.communicator.delegate = _manager;
    _manager.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(startFetchingGroups:)
                                                 name:@"kCLAuthorizationStatusAuthorized"
                                               object:nil];
}
#pragma mark - Accessors

- (CLLocationManager *)locationManager
{
    if (_locationManager) {
        return _locationManager;
    }
    
    id appDelegate = [[UIApplication sharedApplication] delegate];
    if ([appDelegate respondsToSelector:@selector(locationManager)]) {
        _locationManager = [appDelegate performSelector:@selector(locationManager)];
    }
    return _locationManager;
}

#pragma mark - Notification Observer
- (void)startFetchingGroups:(NSNotification *)notification
{
    [_manager fetchGroupsAtCoordinate:self.locationManager.location.coordinate];
}

#pragma mark - MeetupManagerDelegate
- (void)didReceiveGroups:(NSArray *)groups
{
    _groups = groups;
    [self.tableView reloadData];
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}


#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    Group *group = _groups[indexPath.row];
    [cell.nameLabel setText:group.name];
    [cell.whoLabel setText:group.who];
    [cell.locationLabel setText:[NSString stringWithFormat:@"%@, %@", group.city, group.country]];
    [cell.descriptionLabel setText:group.description];
    
    return cell;
}

@end
