//
//  Macros.h
//  RACSample
//
//  Created by 王晨晓 on 16/5/17.
//  Copyright © 2016年 chinsyo. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define ST_DOCUMENT_DIRECTORY ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject])

#define ST_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define ST_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define ST_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

#define DB_PATH [NSString stringWithFormat:@"%@/%@.db", ST_DOCUMENT_DIRECTORY, ST_APP_NAME]

#endif /* Macros_h */
