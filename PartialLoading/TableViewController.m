//
//  TableViewController.m
//  PartialLoading
//
//  Created by Abizer Nasir on 21/11/2013.
//  Copyright (c) 2013 TicketingHub. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@property (strong, nonatomic) NSArray *dataArray;
@property (assign, nonatomic) NSUInteger numberOfRowsToDisplay;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberOfRowsToDisplay = 20;

    // Load up 4000 items to start with This is just for demonstration purposes.
    NSMutableArray *initialArray = [NSMutableArray arrayWithCapacity:4000];
    for (NSUInteger idx = 0; idx < 4000; idx++) {
        [initialArray addObject:@(idx)];
    }

    self.dataArray = [initialArray copy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Recieved memory warning");
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.numberOfRowsToDisplay;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] stringValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger maximumNumberOfItemsToDisplay = [self.dataArray count];
    NSUInteger row = indexPath.row;

    if (!(row + 1 == self.numberOfRowsToDisplay) || row + 1 == maximumNumberOfItemsToDisplay) {
        // Nothing to do here.
        return;
    }

    NSLog(@"End of current chuck - loading next chunk");
    NSUInteger newLengthOfData = self.numberOfRowsToDisplay + 20;
    if (newLengthOfData >= maximumNumberOfItemsToDisplay) {
        newLengthOfData = maximumNumberOfItemsToDisplay;
    }
    self.numberOfRowsToDisplay = newLengthOfData;
    [tableView reloadData];
}

@end
