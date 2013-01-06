//
//  classWebServices.m
//  iStrips1_1
//
//  Created by Avi Kulkarni on 6/6/11.
//  Copyright 2011 PanHealth Inc. All rights reserved.
//

#import "classWebServices.h"
#import "classMedicine.h"
#import "classMedicineTime.h"
#import "classWebServices.h"

@implementation classWebServices

@synthesize webData,soapResults,xmlParser,conn, strData, soapMsg,url,req;

@synthesize delegate;
@synthesize arrayData;
@synthesize objMedicine;
@synthesize objTime;


-(void)callWebServiceWithBoday:(NSString *)strBody url:(NSString *)strUrl soapAction:(NSString *)strSoapAction

{
    // show activiti indicator
   // [delegate showInidcator:YES];
    
    //set methodName-this value will be used at the time of sending notification
    
    self.soapMsg=strBody; 
    
    
    self.url = [NSURL URLWithString:strUrl];
    
    
    //self.req = [NSMutableURLRequest requestWithURL:url] ;	
    self.req = [NSMutableURLRequest requestWithURL: self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad   timeoutInterval:30.0] ;
    
    
    
    
    //set the  Content-Type,	
    [self.req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set the soap action
    [self.req addValue:strSoapAction forHTTPHeaderField:@"SOAPAction"];
    
    //calculat the length of soap message
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMsg length]];
    
    //set the length of request
    [self.req addValue:msgLength forHTTPHeaderField:@"Content-Length"];	
    
    //---set the HTTP Request method---
    [self.req setHTTPMethod:@"POST"];	
    
    //---set the HTTP Request body---
    [self.req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    //you use the NSURLConnection class together with the request object just created
    //establish the connection with the web service, 
    NSURLConnection *tempConn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    self.conn=tempConn;
    [tempConn release];
    
    
    if (conn) 
    {		
        //webData object use to receive incoming data from the web service	
        self.webData=[NSMutableData data];
        
        
    }
    
    
    
    
}




#pragma mark Parsing Methods
//Recive response
-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response
{
	[self.webData setLength: 0];
	
   
}


-(void) connection:(NSURLConnection *) connection didFailWithError:(NSError *) error
{
  
    // stop activiti indicator
   // [delegate showInidcator:NO];
    
    //tell the class that implement this method that connection is filed
	[delegate connectionDidFailWithError];
    
    
    
	UIAlertView *alerterror=[[UIAlertView alloc]initWithTitle:@"Unable to connect to server" message:@"please try after some time."delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
	[alerterror show];	
	[alerterror release];
}



//Repeative call method and append data to webData
-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data 
{
    
	[webData appendData:data];
    
    sleep(1);
}

//when loading of connection will finish this medhot will be called
-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{	
	//uncoment this to print received responce
	
  //  NSLog(@"DONE. Received Bytes: %d", [self.webData length]);
    NSString *theXmlResponce = [[NSString alloc] initWithBytes: [self.webData mutableBytes] length:[self.webData length] encoding:NSUTF8StringEncoding];	    
    
    // print the xml responce
    NSLog(@"XML RESPONSE:--  %@",theXmlResponce);	
    [theXmlResponce release];    
	
    
    
    NSXMLParser * tempXmlParser= [[NSXMLParser alloc] initWithData: self.webData];	
    self.xmlParser =tempXmlParser;
	[tempXmlParser release];
	
	
    [self.xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
	
	//call parse method of xmlparser to parse received responce
    [self.xmlParser parse];	
}	


-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName  namespaceURI:(NSString *) namespaceURI  qualifiedName:(NSString *) qName	attributes:(NSDictionary *) attributeDict
{ 
	
    NSLog(@"\n\n\n element name is %@",elementName);
       
    
    
	if([elementName isEqualToString: @"html"]||[elementName isEqualToString:@"faultcode"])
	{
		// stop activiti indicator
     //   [delegate showInidcator:NO];
        
		[xmlParser abortParsing];
		UIAlertView *alerterror=[[UIAlertView alloc]initWithTitle:@"Unable to process request" message:@"please try after some time."delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];	
		[alerterror show];	
		[alerterror release];
        
		
	}
	
      
   else if([elementName isEqualToString:@"getMemberinfoResult"]||[elementName isEqualToString:@"getMedicineInformationResult"] || [elementName isEqualToString:@"PickPillResult"] ||[elementName isEqualToString: @"addMedicationResult"] || [elementName isEqualToString:@"DeleteMedicineResult"]|| [elementName isEqualToString:@"CreateNewMemberResult"])
    {
        // initialize array and strData to hold data
        NSMutableArray * tempArray=[[NSMutableArray alloc] init];
        self.arrayData=tempArray;
        [tempArray release];
        
        //allocate some memory
        NSMutableString * tempStr=[[NSMutableString alloc]init];                
        
        //assing that memor to strdata
        self.strData= tempStr;
        
        //release tempstr
        [tempStr release];
        
        
    }
        // to hold medicne data create medicneClass object
        if( [elementName isEqualToString:@"Med_master"])
        {
            
            //create new object of medicine class
            classMedicine * tempObjMedicine=[[classMedicine alloc]init];
            
            //now allocate memory for arraytiemes of tempobjMedicine
            NSMutableArray * tempArray=[[NSMutableArray alloc] init];
            tempObjMedicine.medicineTimes=tempArray;
            [tempArray release];
            
            
            self.objMedicine=tempObjMedicine;
            [tempObjMedicine release];
            
        }
             // we need to crearte 6 object of classMedicneTime these objects will hold 6 different times and quantity
            else if([elementName isEqualToString:@"CMD_QTY1"])
            {
                //create new object of classmedicinetime class this objec will hold time and quatity
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            else if([elementName isEqualToString:@"CMD_QTY2"])
            {
                //-----#---- dito
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            else if([elementName isEqualToString:@"CMD_QTY3"])
            {
                
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            else if([elementName isEqualToString:@"CMD_QTY4"])
            {
                
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            else if([elementName isEqualToString:@"CMD_QTY5"])
            {
                
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            else if([elementName isEqualToString:@"CMD_QTY6"])
            {
                
                classMedicineTime * tempObjTime=[[classMedicineTime alloc] init];
                self.objTime=tempObjTime;
                [tempObjTime release];
                
            }
            
        
    
    
	
}		

-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string
{	
	
	[self.strData appendString:string];
	
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
    // for task whows result is ture, fals etc
	
	if([elementName isEqualToString:@"getMemberinfoResult"] || [elementName isEqualToString:@"PickPillResult"] ||[elementName isEqualToString: @"addMedicationResult"] || [elementName isEqualToString:@"DeleteMedicineResult"])
    {
        
        [self.arrayData addObject:strData];
        
    }
	 NSLog(@"\n\n\n element name is %@",elementName);
    // -------------for user medicine details-------------
    
    if([elementName isEqualToString:@"CMD_SEQID"]) //sequence id of medicine
	{
		
		self.objMedicine.medicineSequenceId=[self.strData intValue];
		
		
	}
	
	else if([elementName isEqualToString:@"CMD_MEDICINENAME"])
	{
		
		self.objMedicine.medicineName=self.strData;
	}
	
	else if([elementName isEqualToString:@"CMD_COMMENTS"])
	{
		
		self.objMedicine.medicineComments=self.strData;
	}
	
	else if([elementName isEqualToString:@"CMD_DOSAGEFREQUENCY"])// this represent--how many times a day to eat the medicne
	{
		//not usfull rigth now
		self.objMedicine.medicineDosesFrequency=[self.strData floatValue];
	}
	else if([elementName isEqualToString:@"CMD_QTY1"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
        
    }
	else if([elementName isEqualToString:@"CMD_TIME1"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=1;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    
	
	else if([elementName isEqualToString:@"CMD_QTY2"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
    }
	else if([elementName isEqualToString:@"CMD_TIME2"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=2;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    else if([elementName isEqualToString:@"CMD_QTY3"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
    }
	else if([elementName isEqualToString:@"CMD_TIME3"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=3;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    else if([elementName isEqualToString:@"CMD_QTY4"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
    }
	else if([elementName isEqualToString:@"CMD_TIME4"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=4;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    else if([elementName isEqualToString:@"CMD_QTY5"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
    }
	else if([elementName isEqualToString:@"CMD_TIME5"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=5;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    else if([elementName isEqualToString:@"CMD_QTY6"])
	{
		
        self.objTime.pillQuantity=[self.strData floatValue];
        
    }
	else if([elementName isEqualToString:@"CMD_TIME6"])
	{
        if(![self.strData isEqualToString:@"(null)"])
        {
            self.objTime.times=self.strData;
        }
        
        self.objTime.doseNumber=6;
        [self.objMedicine.medicineTimes addObject:self.objTime];
        
	}
    
    else if([elementName isEqualToString:@"CMD_TOTAL_QTY"])
	{
		objMedicine.totalPillQuantity =[self.strData floatValue];
	}
    else if([elementName isEqualToString:@"CMD_REORDER_LEVEL"])
	{
		objMedicine.reorderLevel=[self.strData intValue];
	}
	else if([elementName isEqualToString:@"Med_master"])
	{
		
		// finaly add the medicine to localy created array & release its memory
		[self.arrayData addObject:self.objMedicine];
		//[objMedicine release];
	}
    
    // -------------for user registraton-------------
    if([elementName isEqualToString:@"anyType"])
	{
        
        [self.arrayData addObject:self.strData];
		
	}
	
    
    
    NSMutableString * tempStr=[[NSMutableString alloc] init];
    self.strData=tempStr;
    [tempStr release];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser
{		
	
    // stop diligates indicator
   //  [delegate showInidcator:NO];
    
    // call delegate mothod to send result back
    if ([arrayData count]!=0) {
        [delegate resultAfterParsing:arrayData];

    }
    //[delegate resultAfterParsing:arrayData];

    // auto release arraydata so that delete class willg get some time to process on arraydata
   // [arrayData autorelease];
        
   
}


-(void)dealloc
{
    
    self.webData=nil;
    self.soapResults=nil;
    self.xmlParser=nil;
    self.conn=nil;
    self.strData=nil;
    self. soapMsg=nil;
    self.url=nil;
    self.req=nil;
    [self.objMedicine release];
    [self.arrayData release];
    self.delegate = nil;

    
    
    [super dealloc];
}










-(void)callWebService:(NSString *)xmlRequest url:(NSString *)strUrl soapAction:(NSString *)strSoapAction
{
    //set methodName-this value will be used at the time of sending notification
    
    self.soapMsg=xmlRequest; 
    
    
    self.url = [NSURL URLWithString:strUrl];
    
    
    //self.req = [NSMutableURLRequest requestWithURL:url] ;	
    self.req = [NSMutableURLRequest requestWithURL: self.url cachePolicy:NSURLRequestReturnCacheDataElseLoad   timeoutInterval:30.0] ;
    
    //set the  Content-Type,	
    [self.req addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //set the soap action
    [self.req addValue:strSoapAction forHTTPHeaderField:@"SOAPAction"];
    
    //calculat the length of soap message
    NSString *msgLength = [NSString stringWithFormat:@"%d",[soapMsg length]];
    
    //set the length of request
    [self.req addValue:msgLength forHTTPHeaderField:@"Content-Length"];	
    
    //---set the HTTP Request method---
    [self.req setHTTPMethod:@"POST"];	
    
    //---set the HTTP Request body---
    [self.req setHTTPBody: [soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    //you use the NSURLConnection class together with the request object just created
    //establish the connection with the web service, 
    NSURLConnection *tempConn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
    self.conn=tempConn;
    [tempConn release];
    
    
    if (conn) 
    {		
        NSMutableData * tempData=[[NSMutableData data]retain];		
        self.webData=tempData;//webData object use to receive incoming data from the web service
        [tempData release];
        
    }
    
    
    
    
}


@end
