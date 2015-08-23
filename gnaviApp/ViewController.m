//
//  ViewController.m
//  gnaviApp
//
//  Created by Marina Ito on 2015/08/19.
//  Copyright (c) 2015年 Marina Ito. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    NSDictionary *_jsonObject;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.searchBar.delegate = self;
    self.firstTableView.delegate = self;
    self.firstTableView.dataSource = self;
    
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"Search button clicked");
    NSLog(@"search text = %@",_searchBar.text);
    
       // 非同期処理 (dispatch)
    //dispatch_queue_t global_q = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0); // 裏側で処理を動かすキューを作成
    //dispatch_queue_t mail_q = dispatch_get_main_queue(); // globalなキューが終了した際に呼ばれるキューを作成

    //dispatch_async(global_q, ^{
        // 重たい処理をさせる
        // apiを叩く処理 → 時間のかかる重たい処理
    
        // URLエンコード処理
    
        NSString *encodeStr= [_searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"Encode str = %@",encodeStr);
        
        //gnavi apiを叩く
        NSString *urlString = [NSString stringWithFormat:@"http://api.gnavi.co.jp/RestSearchAPI/20150630/?keyid=20013ab04725cd4c7cdfc508ebe83c24&format=json&name=%@&hit_per_page=10", encodeStr];
    
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"APIのurl = %@",urlString);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
        //APIたたく
        NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSError *error = nil;
    
        _jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
       
    
    
    
    //NSLog(@"%@",jsonObject);
    
    // 辞書データのキーを取得する
    NSLog(@"キー = %@",_jsonObject[@"rest"][0][@"name"]);

    //restの中の配列を表示
    for (int i = 0; i < [_jsonObject[@"rest"] count]; i++){
        
        NSLog(@"店の情報 %i ; %@",i,_jsonObject[@"rest"][i][@"name"]);
        
    }
    
//    dispatch_async(mail_q, ^{
//         });
//    });



}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //行の数を決める
    
    return  [_jsonObject[@"rest"] count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    //cellForRowAtIndexPathセルの中身を決める
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString *title = _jsonObject[@"rest"][indexPath.row][@"name"];
    
    
   
    cell.textLabel.text = title;
        
   

    //indexPath.section;
    return cell;
    
}


    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
