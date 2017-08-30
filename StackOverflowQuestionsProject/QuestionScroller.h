//
//  ViewController.h
//  StackOverflowQuestionsProject
//
//  Created by Yatheen Maharaj on 2017/08/23.
//  Copyright © 2017 Yatheen Maharaj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableViewStackOverflowQuestions;
@property (weak, nonatomic) IBOutlet UILabel *lblTableTitle;

@end

