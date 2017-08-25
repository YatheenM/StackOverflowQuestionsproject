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
    
    /*NSString *questionTitle;
    NSString *questionAnswers;
    NSBool *isAnswered;
    NSString *answerCount;
    NSString *lastActivityDate;*/
    
     @property (atomic, copy) NSString *questionTitle;
     @property (atomic) int *questionAnswers;
     @property (atomic) BOOL isAnswered;
     @property (atomic, copy) NSString *answerCount;
     @property (atomic, copy) NSString *lastActivityDate;


@end
