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

static NSString * const BaseURLString = @"https://api.stackexchange.com/2.2/questions?pagesize=50&order=desc&sort=activity&tagged=ios&site=stackoverflow";
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
            NSArray *arrTags = [dic mutableArrayValueForKey:@"tags"];
            [question setTags:arrTags];
            [questions addObject:question];
        }
    
        [self.tableViewStackOverflowQuestions reloadData];
    }
     
    failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"An error has occured");
    }];
    
    [operation start];
    
    for(int i = 0; i <= 2; i++){
        NSLog(@"%@", question.tags[i]);
    }
    
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
    if (cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Question *q = questions[indexPath.row];
    
    
    cell.viewIsAnswered.layer.cornerRadius = cell.viewIsAnswered.bounds.size.width*0.5;
    cell.viewIsAnswered.layer.masksToBounds = YES;
    
    cell.lblQuestionTitle.text = [q questionTitle];
    
    if([q isAnswered] == true){
        cell.viewIsAnswered.backgroundColor  = [UIColor colorWithRed:47.0f/255.0f
                                                               green:255.0f/255.0f
                                                                blue:141.0f/255.0f
                                                               alpha:1.0f];
    }
    else if ([q isAnswered] == false){
        cell.viewIsAnswered.backgroundColor = [UIColor colorWithRed:217.0f/255.0f
                                                              green:217.0f/255.0f
                                                               blue:217.0f/255.0f
                                                              alpha:1.0f];
    }
    
    cell.lblViewCount.text = [NSString stringWithFormat:@"%i", [q questionAnswers]];
    
    long currentTime = (long)(NSTimeInterval)([[NSDate date] timeIntervalSince1970]);
    long creationDateInHours  = (currentTime - [q creationDate])/(1000*3600);
    
    cell.lblLastActivity.text = [NSString stringWithFormat:@"%ld hours ago", creationDateInHours];
    
    NSUInteger i;
    int xCoord=0;
    int yCoord=0;
    int buttonWidth=100;
    int buttonHeight=30;
    int buffer = 10;
    
    for (i = 0; i < [q.tags count]; i++)
    {
        UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        aButton.frame     = CGRectMake(xCoord,yCoord,buttonWidth,buttonHeight );
        [aButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [aButton setBackgroundColor:[UIColor colorWithRed:217.0f/255.0f
                                                    green:217.0f/255.0f
                                                     blue:217.0f/255.0f
                                                    alpha:1.0f]];
        [aButton setEnabled:false];
        aButton.layer.borderWidth = 2.0f;
        aButton.layer.borderColor = [UIColor whiteColor].CGColor;
        aButton.titleLabel.numberOfLines = 1;
        aButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        aButton.titleLabel.lineBreakMode = NSLineBreakByClipping;
        [[aButton layer] setCornerRadius:8.0f];
        [cell.scrlViewTags addSubview:aButton];
        [aButton setTitle:q.tags[i] forState: UIControlStateNormal];
        xCoord += buttonWidth + buffer;
    }
    
    cell.scrlViewTags.pagingEnabled = true;
    [cell.scrlViewTags setContentSize:CGSizeMake(xCoord, 0)];
    return cell;
}

@end
