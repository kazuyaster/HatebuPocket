//
//  ViewController.h
//  HatebuPocket
//
//  Created by Kazuyaster on 2013/10/27.
//  Copyright (c) 2013年 Kazuyaster. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HotEntryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic,strong) NSString *categoryKeyword;
@end
