//
//  ViewController.m
//  StackOverflowQuestions
//
//  Created by Yatheen Maharaj on 2017/08/21.
//  Copyright © 2017 Yatheen Maharaj. All rights reserved.
//

#import "QuestionScroller.h"
//#import "AFNetworking.h"
//static NSString *const URL = "https://api.stackexchange.com/2.2/questions?order=desc&sort=activity&site=stackoverflow";

@interface ViewController ()

@end

@implementation ViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //self.navigationItem.title = @"Questions";
    //self.numberOfAnswers.layer.cornerRadius = (_numberOfAnswers.bounds.size.width/2);
    
    //self.testArray = @[@"A",@"B",@"C",@"D",@"E"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;//[self.testArray count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *stackOverflowQuestion = @"CustomCell";
    
    CustomCell *cell= (CustomCell *)[tableView dequeueReusableCellWithIdentifier:stackOverflowQuestion];
    
    
    if (cell == nil){
        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stackOverflowQuestion];
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.lblQuestionTitle.text = @"Test";
    cell.viewIsAnswered.layer.cornerRadius = cell.viewIsAnswered.bounds.size.width*0.5;
    cell.viewIsAnswered.layer.masksToBounds = YES;
    
    return cell;
    
}

@end
