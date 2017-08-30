//
//  Question.h
//  StackOverflowQuestionsProject
//
//  Created by Yatheen Maharaj on 2017/08/23.
//  Copyright © 2017 Yatheen Maharaj. All rights reserved.
//

#ifndef Question_h
#define Question_h


#endif /* Question_h */

@interface Question : NSObject

     @property (nonatomic, copy) NSString *questionTitle;
     @property (nonatomic) int questionAnswers;
     @property (nonatomic) BOOL isAnswered;
     @property (nonatomic, copy) NSString *answerCount;
     @property (nonatomic) long creationDate;
     @property (nonatomic, copy) NSArray *tags;

@end
