//Program for webservice-Insert,update,delete

@RestResource(urlMapping='/Lead/*')
global with sharing class Mywebservice
 {
 	public static MywebserviceInner  myweb=new  MywebserviceInner();
 	//private static final String Success = 'success';
	
     //DoPost Method for Insert data
    @HttpPost
    global static MywebserviceInner doPost()
     {
        Lead objLead = new Lead();
        RestRequest request = RestContext.request;
        RestResponse response = RestContext.response;
        String firstname= request.params.get('firstname');
        String lastname= request.params.get('lastname');
        String phone= request.params.get('phone');
        String email= request.params.get('email');
        objLead.FirstName=firstname;
        objLead.LastName=lastname;
        objLead.Phone=phone;
        objLead.Email=email;
        objLead.Company='MyCompany';
        objLead.Status='Open-Not Contacted';
        
        try
        {
        	   
       	insert objLead;

    		myweb.isSuccess=True;
    		myweb.leadId=objLead.Id;
    		myweb.status='Success';
        }
    	
    	 catch(Exception e)
    	{
        	myweb.isSuccess=False;
    		myweb.leadId='';
    		myweb.status='Lead Not Created';
    		
    	}
        
        
        	return myweb;
    }//end of doPost Method
    
//Delete record by doDelete method
    @HttpDelete
    global static MywebserviceInner doDelete()
     {
		RestRequest request = RestContext.request;
		RestResponse response = RestContext.response;
		String firstname= request.params.get('firstname');
		String lastname= request.params.get('lastname');
		String phone= request.params.get('phone');
		String email= request.params.get('email');
		Lead objLead;
        
       try
       {
        	objLead = [SELECT Id,FirstName from Lead where FirstName=:firstname and LastName=:lastname and Phone=:phone and Email=:email  limit 1];
      
        	delete objLead;

    	
    		myweb.isSuccess=True;
    		myweb.leadId=objLead.FirstName;
    		myweb.status='Success';
      }
    	
    	catch(Exception e)
    	
    	{
		myweb.isSuccess=False;
		myweb.leadId='';
		myweb.status='Lead Not Deleted';
    		
    	}
        
        return myweb;
    }//end of doDelele Method

    
    //doPatch Method
    @HttpPatch
    global static MywebserviceInner doPatch() 
     {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String firstname= req.params.get('firstname');
        String lastname= req.params.get('lastname');
        String phone= req.params.get('phone');
        String email= req.params.get('email');
        Lead objLead;
      
     
       try
       {
        objLead = [SELECT Id,Phone,Email from Lead where FirstName=:firstname and LastName=:lastname limit 1];
        objLead.Phone=phone;
        objLead.Email=email;
        update objLead;
        	myweb.isSuccess=True;
    		myweb.leadId=objLead.Id;
    		myweb.status='Success';
       }
       
       catch(Exception e)
       {
            myweb.isSuccess=False;
    		myweb.leadId='';
    		myweb.status='Lead Not Updated';
       }
        
             
        return myweb;
    }//end of doPatch Method
        
  
    
    //doget Method
     @HttpGet
	global static MywebserviceInner doGet()
	{
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String firstname= req.params.get('firstname');
	   	String lastname= req.params.get('lastname');
	    

     		Lead objLead=new Lead();
     		
     try
     {
 
      	objLead=[SELECT Id,Phone,Email from Lead where FirstName=:firstname and LastName=:lastname limit 1];
       
      	myweb.isSuccess=True;
    		myweb.leadId=objLead.Id;
    		myweb.status='Success'; 
      
     } //end of doget Method
      

    	
    	catch(Exception e)
    	{
       	myweb.isSuccess=False;
    		myweb.leadId='';
    		myweb.status='Lead Not get';
    		
    	}
    	
    	
	  return  myweb;
	}
	
    
    //Inner Class
    global  class MywebserviceInner
    {
    	global boolean isSuccess{get; set;}
    	global String leadId{get; set;}
    	global String status{get; set;}
    	

    	
    }//end of MyewbserviceInner
    
   
    
    
  
  
    
}//end of mywebservice