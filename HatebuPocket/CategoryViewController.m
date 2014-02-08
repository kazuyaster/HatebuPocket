//
//  CategoryViewController.m
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/11/24.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import "CategoryViewController.h"
#import "HotEntryViewController.h"

@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSArray *categoryList;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation CategoryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.categoryList = @[
                              @{@"social": @"世の中"},
                              @{@"economics": @"政治と経済"},
                              @{@"life": @"暮らし"},
                              @{@"knowledge": @"学び"},
                              @{@"it": @"テクノロジー"},
                              @{@"entertainment": @"エンタメ"},
                              @{@"game": @"アニメとゲーム"},
                              @{@"fun": @"おもしろ"}
                          ];
    self.categoryTableView.dataSource = self;
    self.categoryTableView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _categoryList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"CategoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tmpDict = _categoryList[indexPath.row];
    cell.textLabel.text = tmpDict[tmpDict.allKeys.lastObject];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"itemsListToDetail" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"itemsListToDetail"]) {
        NSDictionary *selectedDict = _categoryList[_categoryTableView.indexPathForSelectedRow.row];
        [(HotEntryViewController*)segue.destinationViewController setCategoryKeyword:selectedDict.allKeys.lastObject];
        [(HotEntryViewController*)segue.destinationViewController setTitle:selectedDict[selectedDict.allKeys.lastObject]];
    }

}



@end


















