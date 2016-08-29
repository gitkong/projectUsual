//
//  APIStringMacros.h
//  Created by 孔凡列 on 16/7/11.
//  Copyright © 2016年 czebd. All rights reserved.
//

#ifndef APIStringMacros_h
#define APIStringMacros_h

//接口名称相关

#ifdef DEBUG
//Debug状态下的测试API
#define API_BASE_URL_STRING     @""

#else
//Release状态下的线上API
#define API_BASE_URL_STRING     @""

#endif


//接口



#endif /* APIStringMacros_h */
