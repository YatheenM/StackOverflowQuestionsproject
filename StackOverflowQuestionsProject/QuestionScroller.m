//
//  ViewController.m
//  StackOverflowQuestions
//
//  Created by Yatheen Maharaj on 2017/08/21.
//  Copyright © 2017 Yatheen Maharaj. All rights reserved.
//

#import "QuestionScroller.h"
#import "AFNetworking.h"
#import "StackOverflowPost.h"

static NSString * const BaseURLString = @"https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow";
Question *question = nil;
UITableView *tv = NULL;

@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    //tv = _tableViewStackOverflowQuestions;
     
     question = [[Question alloc]init];
     
     //dispatch_group_t group = dispatch_group_create();
     
     
     NSURL *url = [NSURL URLWithString:BaseURLString];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     
     //dispatch_group_enter(group);
     
     // 2
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     //operation.completionQueue = queue;
     operation.responseSerializer = [AFJSONResponseSerializer serializer];
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     // 3
     
     NSDictionary *dictionary = (NSDictionary *) responseObject;
     //NSArray *itemsArray = [dictionary objectForKey:@"items"];
     //NSString *str1 = [itemsArray objectAtIndex:2];
     
     //NSLog(@"%@ wjcklnklsnalkncn", str1);
     
     int count = 0;
     
     for(NSDictionary *dic in [dictionary objectForKey:@"items"])
     {
     count++;
     
     if(count == 1)
     {
     [question setQuestionTitle:[dic valueForKey:@"title"]];
     int answerCount = [[dic objectForKey:@"answer_count"] intValue];
     [question setQuestionAnswers: &answerCount];
     NSLog(@"%@ HUH", [question answerCount]);
     [question setLastActivityDate:[dic valueForKey:@"last_activity_date"]];
     NSLog(@"%@ Hello from the other side...!", [question questionTitle]);
     NSString *isSet = [dic valueForKey:@"is_answered"];
     if ([isSet  isEqual: @"true"]) {
     [question setIsAnswered:YES];
     }
     else{
     [question setIsAnswered:NO];
     }
     
     }
     }
     
     NSLog(@"JSON Retrieved");
     
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     // 4
     NSLog(@"An error has occured");
     }];
     
     // 5
     [operation start];
     
     
     NSLog(@"DONE");
     [self.tableViewStackOverflowQuestions reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    /*//tv = _tableViewStackOverflowQuestions;
    
   question = [[Question alloc]init];
    
    //dispatch_group_t group = dispatch_group_create();
    
    
    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //dispatch_group_enter(group);
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //operation.completionQueue = queue;
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        
        NSDictionary *dictionary = (NSDictionary *) responseObject;
        //NSArray *itemsArray = [dictionary objectForKey:@"items"];
        //NSString *str1 = [itemsArray objectAtIndex:2];
        
        //NSLog(@"%@ wjcklnklsnalkncn", str1);
        
        int count = 0;
        
        for(NSDictionary *dic in [dictionary objectForKey:@"items"])
        {
            count++;
            
            if(count == 1)
            {
               [question setQuestionTitle:[dic valueForKey:@"title"]];
               int answerCount = [[dic objectForKey:@"answer_count"] intValue];
               [question setQuestionAnswers: &answerCount];
               NSLog(@"%@ HUH", [question answerCount]);
               [question setLastActivityDate:[dic valueForKey:@"last_activity_date"]];
               NSLog(@"%@ Hello from the other side...!", [question questionTitle]);
               NSString *isSet = [dic valueForKey:@"is_answered"];
               if ([isSet  isEqual: @"true"]) {
               [question setIsAnswered:YES];
               }
                else{
                [question setIsAnswered:NO];
                }
                
            }
        }
        
         NSLog(@"JSON Retrieved");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        NSLog(@"An error has occured");
    }];
    
    // 5
    [operation start];


    NSLog(@"DONE");
    [self.tableViewStackOverflowQuestions reloadData];*/
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;//[self.testArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /*//tv = _tableViewStackOverflowQuestions;
     
     question = [[Question alloc]init];
     
     //dispatch_group_t group = dispatch_group_create();
     
     
     NSURL *url = [NSURL URLWithString:BaseURLString];
     NSURLRequest *request = [NSURLRequest requestWithURL:url];
     
     //dispatch_group_enter(group);
     
     // 2
     AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
     //operation.completionQueue = queue;
     operation.responseSerializer = [AFJSONResponseSerializer serializer];
     
     [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
     
     // 3
     
     NSDictionary *dictionary = (NSDictionary *) responseObject;
     //NSArray *itemsArray = [dictionary objectForKey:@"items"];
     //NSString *str1 = [itemsArray objectAtIndex:2];
     
     //NSLog(@"%@ wjcklnklsnalkncn", str1);
     
     int count = 0;
     
     for(NSDictionary *dic in [dictionary objectForKey:@"items"])
     {
     count++;
     
     if(count == 1)
     {
     [question setQuestionTitle:[dic valueForKey:@"title"]];
     int answerCount = [[dic objectForKey:@"answer_count"] intValue];
     [question setQuestionAnswers: &answerCount];
     NSLog(@"%@ HUH", [question answerCount]);
     [question setLastActivityDate:[dic valueForKey:@"last_activity_date"]];
     NSLog(@"%@ Hello from the other side...!", [question questionTitle]);
     NSString *isSet = [dic valueForKey:@"is_answered"];
     if ([isSet  isEqual: @"true"]) {
     [question setIsAnswered:YES];
     }
     else{
     [question setIsAnswered:NO];
     }
     
     }
     }
     
     NSLog(@"JSON Retrieved");
     
     
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
     
     // 4
     NSLog(@"An error has occured");
     }];
     
     // 5
     [operation start];
     
     
     NSLog(@"DONE");
     [self.tableViewStackOverflowQuestions reloadData];
    //[self.tableViewStackOverflowQuestions reloadData];*/
    
    static NSString *stackOverflowQuestion = @"CustomCell";
    
    CustomCell *cell= (CustomCell *)[tableView dequeueReusableCellWithIdentifier:stackOverflowQuestion];
    
    
    if (cell == nil){
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stackOverflowQuestion];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblQuestionTitle.text = [question questionTitle];
    if([question isAnswered]){
        cell.viewIsAnswered.backgroundColor = [UIColor greenColor];
    }
    else{
        cell.viewIsAnswered.backgroundColor = [UIColor lightGrayColor];
    }
    
    cell.lblViewCount.text = [NSString stringWithFormat:@"%i", [question questionAnswers]];
    cell.lblLastActivity.text = @"3 hours ago";//[question lastActivityDate];`
    //
    cell.viewIsAnswered.layer.cornerRadius = cell.viewIsAnswered.bounds.size.width*0.5;
    cell.viewIsAnswered.layer.masksToBounds = YES;
    
    return cell;
    
}

@end
