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
NSMutableArray *questions;
UILabel *label = nil;

@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lblTableTitle.text = @"Questions tagged \"iOS\"";
    
    questions = [[NSMutableArray alloc]init];
    
    question = [[Question alloc]init];
    
    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSDictionary *dictionary = (NSDictionary *) responseObject;
        
        for(NSDictionary *dic in [dictionary objectForKey:@"items"])
        {
            
            question = [[Question alloc]init];
            [question setQuestionTitle:[dic valueForKey:@"title"]];
            int answerCount = [[dic objectForKey:@"answer_count"] intValue];
            [question setQuestionAnswers: answerCount];
            long lastActivity = [[dic valueForKey:@"creation_date"] longValue];
            [question setCreationDate: lastActivity];
            BOOL isSet = [[dic valueForKey:@"is_answered"] boolValue];
            [question setIsAnswered:isSet];
            
            NSLog(@"%i", isSet);
            
            [questions addObject:question];
        }
    
        [self.tableViewStackOverflowQuestions reloadData];
    }
     
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"An error has occured");
    }];
    
    [operation start];
    
    NSLog(@"JSON Retrieved");
    NSLog(@"DONE");
    
    //[self.tableViewStackOverflowQuestions reloadData];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [questions count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *stackOverflowQuestion = @"CustomCell";
    
    CustomCell *cell= (CustomCell *)[tableView dequeueReusableCellWithIdentifier:stackOverflowQuestion];

    Question *q = questions[indexPath.row];
    
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.viewIsAnswered.layer.cornerRadius = cell.viewIsAnswered.bounds.size.width*0.5;
    cell.viewIsAnswered.layer.masksToBounds = YES;
    
    cell.lblQuestionTitle.text = [q questionTitle];
    
    if([question isAnswered] == true){
        //cell.lblQuestionTitle.backgroundColor = [UIColor greenColor];
        cell.viewIsAnswered.backgroundColor  = [UIColor greenColor];
    }
    else if ([question isAnswered] == false){
        //cell.lblQuestionTitle.backgroundColor = [UIColor lightGrayColor];
        cell.viewIsAnswered.backgroundColor = [UIColor lightGrayColor];
    }
    
    cell.lblViewCount.text = [NSString stringWithFormat:@"%i", [q questionAnswers]];
    
  
    long creationDateInHours  = ([q creationDate])/(1000*3600);
    
    
    cell.lblLastActivity.text = [NSString stringWithFormat:@"%ld hours ago", creationDateInHours];


    return cell;
}

@end
