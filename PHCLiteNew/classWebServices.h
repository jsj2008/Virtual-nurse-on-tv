//
//  Created by Sunil Bhosale on 08/7/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol webServiceDelegateProtocol
-(void)resultAfterParsing:(NSMutableArray *)arrayResult;
-(void)connectionDidFailWithError;


@end

@class classMedicine;
@class classMedicineTime;
@interface classWebServices : NSObject <NSXMLParserDelegate>
{
    
    
 id <webServiceDelegateProtocol> delegate;
    
//---- variables for webservice rquest-----
	NSMutableData       *webData;
	NSMutableString     *soapResults;
	NSXMLParser         *xmlParser;
	NSURLConnection     *conn;	
	NSMutableString     *strData;
	NSString            *soapMsg;
	NSURL               *url;
	NSMutableURLRequest *req;
    
//---- array to hold parsed data
    NSMutableArray * arrayData;
    classMedicine * objMedicine;
    classMedicineTime * objTime;
    
    
}


@property(nonatomic,retain)NSMutableData       *webData;
@property(nonatomic,retain)NSURLConnection     *conn;	
@property(nonatomic,retain)NSURL               *url;
@property(nonatomic,retain)NSMutableURLRequest *req;
@property(nonatomic,retain)NSString            *soapMsg;
@property(nonatomic,retain)NSMutableString     *soapResults;
@property(nonatomic,retain)NSMutableString     *strData;
@property(nonatomic,retain)NSXMLParser         *xmlParser;
@property (nonatomic,assign) id <webServiceDelegateProtocol> delegate;

@property (nonatomic,retain)  NSMutableArray * arrayData; 
@property(nonatomic,retain)    classMedicine * objMedicine;
@property(nonatomic,retain) classMedicineTime * objTime;

-(void)callWebServiceWithBoday:(NSString *)strBody url:(NSString *)strUrl soapAction:(NSString *)strSoapAction;
-(void)callWebService:(NSString *)xmlRequest url:(NSString *)strUrl soapAction:(NSString *)strSoapAction;

@end


