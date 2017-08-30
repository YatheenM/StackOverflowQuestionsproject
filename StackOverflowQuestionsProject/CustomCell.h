//
//  CustomCell.h
//  StackOverflowQuestionsProject
//
//  Created by Yatheen Maharaj on 2017/08/23.
//  Copyright © 2017 Yatheen Maharaj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *viewIsAnswered;
@property (weak, nonatomic) IBOutlet UILabel *lblViewCount;
@property (weak, nonatomic) IBOutlet UILabel *lblQuestionTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblLastActivity;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionViewTags;
@property (weak, nonatomic) IBOutlet UIButton *btnDisplayIsAnswered;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewDisplayTags;

@end
