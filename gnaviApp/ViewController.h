//
//  ViewController.h
//  gnaviApp
//
//  Created by Marina Ito on 2015/08/19.
//  Copyright (c) 2015年 Marina Ito. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *firstTableView;

@end

