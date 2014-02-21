/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class MywebserviceTest {

    
    private static final String Success = 'success';
    private static final String LeadCreate = 'Lead Not Created';
    private static final String StringUpdate = 'Lead Not Updated';
    
    public static string url {get;set;}
    public  MywebserviceTest()
    {
     url = ApexPages.currentPage().getHeaders().get('Host');
    }
    
    
    
    static testMethod void leaddoPostTest() 
    {
        
        RestRequest req = new RestRequest();     
        RestResponse res = new RestResponse();
        
        req.requestURI=url;     
        req.httpMethod = 'POST'; 
        

       
        req.addParameter('firstname','AAA');
        req.addParameter('lastname','BBB');
        req.addParameter('phone','1234');
        req.addParameter('email','BBB@gmail.com');
       

        
        RestContext.request=req;
        RestContext.response=res;
        
       
        test.startTest();
        Mywebservice.MywebserviceInner results= Mywebservice.doPost();
       
        System.assert(results.isSuccess);   
        //System.assertEquals('Success', results.status);
        System.assert(results.status.trim().toLowerCase().compareTo(Success) == 0);
        
         //For Wrong Insert TEST CASE
         
        req.addParameter('firstname','');
        req.addParameter('lastname','');
        req.addParameter('phone','dfghdf');
        req.addParameter('email','BBBgmail.com');
         
        RestContext.request=req;
        Mywebservice.MywebserviceInner results1= Mywebservice.doPost();
        
        test.stopTest();
        System.assertEquals(false, results1.isSuccess); 
        System.assert(results1.status.trim().compareTo(LeadCreate) == 0);  
        //System.assertEquals('Lead Not Created', results1.status);   
       
        
    }     
        
        
        
 
    
    
        static testMethod void leaddoGetTest() 
    {
       
        
	    RestRequest req = new RestRequest();     
	    RestResponse res = new RestResponse();
	    //req.requestURI = 'https://ap1.salesforce.com/services/apexrest/Lead';    
	    req.requestURI=url;   
	    req.httpMethod = 'POST';   
	  
	   
	    req.addParameter('firstname','AAA');
	    req.addParameter('lastname','BBB');
	        
	        
	     RestContext.request=req;
	     RestContext.response=res;
	     
	     
	     test.startTest();
	     
	     Mywebservice.MywebserviceInner results1= Mywebservice.doPost();
	     req.httpMethod = 'GET'; 
	     RestContext.request=req;
	     Mywebservice.MywebserviceInner results= Mywebservice.doGet();
	     
	    
	     System.assert(results.isSuccess);       
	    
	     System.assert(results.status.trim().toLowerCase().compareTo(Success) == 0);
        
         //For Wrong Getdata- TEST CASE
         req.addParameter('firstname','not available');
         RestContext.request=req;
         Mywebservice.MywebserviceInner results2= Mywebservice.doGet();
         test.stopTest();
         
         System.assertEquals(false,results2.isSuccess);   
         System.assertEquals('Lead Not get', results2.status);
         
         
        
    }
         
         
     static testMethod void leaddoDeleteTest() 
    {
        
        RestRequest req = new RestRequest();     
        RestResponse res = new RestResponse();
            
        req.requestURI=url;   
        req.httpMethod = 'POST'; 
       
        req.addParameter('firstname','AAA');
        req.addParameter('lastname','BBB');
         req.addParameter('phone','1234');
        req.addParameter('email','BBB@gmail.com');
       
        
        RestContext.request=req;
        RestContext.response=res;
        
       
        test.startTest();
        Mywebservice.MywebserviceInner results1= Mywebservice.doPost();
        req.httpMethod = 'DELETE'; 
        RestContext.request=req;
        Mywebservice.MywebserviceInner results= Mywebservice.doDelete();

        
        System.assert(results.isSuccess);   
        //System.assertEquals('Success', results.status);
        
        
         //For Wrong i/p -Delete TEST CASE
         
         RestContext.request=req;
         Mywebservice.MywebserviceInner results2= Mywebservice.doDelete();
         test.stopTest();
         System.assertEquals(false,results2.isSuccess);     
     
         System.assertEquals('Lead Not Deleted', results2.status);
        
        
        
    }     
    
    
     static testMethod void leaddoUpdateTest() 
    {
       
        RestRequest req = new RestRequest();     
        RestResponse res = new RestResponse();
       
        
        req.httpMethod = 'POST'; 
       
        req.addParameter('firstname','AAA');
        req.addParameter('lastname','BBB');
         req.addParameter('phone','1234');
        req.addParameter('email','BBB@gmail.com');
       
        
        RestContext.request=req;
        RestContext.response=res;
        
      
        test.startTest();
       
        Mywebservice.MywebserviceInner results1= Mywebservice.doPost();
        req.addParameter('phone','1234567');
        req.addParameter('email','ccc@gmail.com');
        req.httpMethod = 'PATCH'; 
        RestContext.request=req;
        Mywebservice.MywebserviceInner results= Mywebservice.doPatch();

       test.stopTest();
       
       System.assertEquals(true, results.isSuccess);   
       System.assertEquals('Success', results.status);
       
       //For Wrong UPDATE TEST CASE
       
         req.addParameter('firstname','sfdc');
         req.addParameter('lastname','');
        
         RestContext.request=req;
         Mywebservice.MywebserviceInner results2= Mywebservice.doPatch();
         
         System.assertEquals(false,results2.isSuccess);      
         //System.assertEquals('Lead Not Updated', results2.status);
         System.assert(results2.status.trim().compareTo(StringUpdate) == 0);  
       
       
      }
     
     
        
        
        
    
}