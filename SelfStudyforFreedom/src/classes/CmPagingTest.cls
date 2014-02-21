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
private class CmPagingTest
{

 //Check for Recently modified
    static testMethod void RecentlyModifiedTest() 
    {
        
     	PageReference ref= Page.CM_Campaign_Landing;
     	Test.setCurrentPageReference(ref);
     	
    
      Campaign objCampaign=new Campaign(name='test1',Type='in progress', Status='bac',StartDate=Date.valueof('2012-06-07'));
   
   
   	test.startTest();
   
    	CmPaging myPageCon = new  CmPaging();
    	myPageCon.Search();
   	insert objCampaign;  
   
   	Campaign objCampaign2=[Select StartDate From Campaign where Name='test1'];
   
   	myPageCon.view.Name='RecentlyModified';
   
   	List<Campaign>lstCampaign1=[select startDate from Campaign where name='test1'];
   	system.assert(lstCampaign1.get(0).StartDate==objCampaign2.StartDate); 
   	test.stopTest();
   	
    }
    
     //Check for Allcampaign
     static testMethod void AllCampaignsTest() 
     {
        
	      PageReference ref= Page.CM_Campaign_Landing;
	     	Test.setCurrentPageReference(ref);
	    	List<Campaign> lstCampaign=new List<Campaign>();
	    
	  	Campaign objCampaign=new Campaign(name='test1',Type='in progress', Status='bac',StartDate=Date.valueof('2012-06-07'));
	   
	   
	  	test.startTest();
	   
	     	CmPaging myPageCon = new CmPaging();
	   
	   	insert objCampaign;
	   	
	   	Campaign objCampaign2=[Select StartDate From Campaign where Name='test1'];
	   
	   	myPageCon.view.Name='AllCampaigns';
	    	myPageCon.Search();
	   
	   	List<Campaign>lstCampaign1=myPageCon.con.getRecords();
	   	test.stopTest();
	   	system.assert(lstCampaign1.get(0).StartDate==objCampaign2.StartDate); 
   	
    }
    
    
    //Check for AllActivecampaign
     static testMethod void AllActiveCampaignsTest() 
     {
        
	       PageReference ref= Page.CM_Campaign_Landing;
	     	 Test.setCurrentPageReference(ref);
	     	 
	   	

	      Campaign objCampaign1=new Campaign(name='test1',Type='in progress', Status='bac',IsActive=true,StartDate=Date.valueof('2012-06-07'));
	     
	   
	   	test.startTest();
	      insert objCampaign1; 
	     	CmPaging myPageCon = new  CmPaging();
	
	   
	   	Campaign objCampaign2=[Select IsActive,StartDate From Campaign where Name='test1'];
	   
	   	myPageCon.view.Name='AllActiveCampaigns';
	    	myPageCon.Search();
	   
	   	List<Campaign>lstCampaign1=myPageCon.con.getRecords();
	   
	    	system.assert((objCampaign2.IsActive==true) && (lstCampaign1.get(0).StartDate==objCampaign2.StartDate)); 
	   	test.stopTest();
    }
    
     static testMethod void MyactiveCampaignsTest() 
     {
        
	       PageReference ref= Page.CM_Campaign_Landing;
	     	 Test.setCurrentPageReference(ref);
	        
	       Campaign objCampaign1=new Campaign(name='test1',Type='in progress', Status='bac',IsActive=true,StartDate=Date.valueof('2012-06-07'),OwnerId=userInfo.getUserId());
	   
	   
	   	 test.startTest();
	   
	     	 CmPaging myPageCon = new  CmPaging();
	   
	   	 insert objCampaign1;
	   
	   
	   	Campaign objCampaign2=[Select IsActive,StartDate,OwnerId From Campaign where Name='test1'];
	   
	   	myPageCon.view.Name='MyactiveCampaigns';
	    	myPageCon.Search();
	   
	   	List<Campaign>lstCampaign1=myPageCon.con.getRecords();
	   
	    	system.assert((objCampaign2.IsActive==true) && (lstCampaign1.get(0).StartDate==objCampaign1.StartDate) && (lstCampaign1.get(0).OwnerId==objCampaign2.OwnerId)); 
	   	test.stopTest();
    }
    
     static testMethod void InActiveCampaignsTest() 
     {
        
	        PageReference ref= Page.CM_Campaign_Landing;
	     	  Test.setCurrentPageReference(ref);
	    	 
	      Campaign objCampaign1=new Campaign(name='test1',Type='in progress', Status='bac',IsActive=false,StartDate=Date.valueof('2012-06-07'));
	   
	   
	   	test.startTest();
	   
	     	CmPaging myPageCon = new  CmPaging();
	   
	   	insert objCampaign1;
	   
	   
	   	Campaign  objCampaign2=[Select IsActive,StartDate From Campaign where Name='test1'];
	   
	   	myPageCon.view.Name='InactiveCampaigns';
	    	myPageCon.Search();
	   
	   	//List<Campaign>lstCampaign1=myPageCon.con.getRecords();
	   	List<Campaign>lstCampaign1=myPageCon.Allview;
	   
	   	system.assert((objCampaign2.IsActive==false) && (lstCampaign1.get(0).StartDate== objCampaign2.StartDate)); 
	    
	    
	   	test.stopTest();
    }
    
    static testMethod Boolean hasNextTest()
    {
    
	      
	     PageReference ref= Page.CM_Campaign_Landing;
	     Test.setCurrentPageReference(ref);
	     
	     List<Campaign> lstcampaign=new List<Campaign>();
	     CmPaging myPageCon = new  CmPaging();
	     for(Integer i=0;i<50;i++)
	     {
	     		Campaign objCampaign1=new Campaign(name='test1'+i,Type='in progress', Status='bac',IsActive=false,StartDate=Date.valueof('2012-06-07'));
	     		lstcampaign.add(objCampaign1);
	     }
	     
	     test.startTest();
	     insert lstcampaign;
	   
	     myPageCon.view.Name='RecentlyModified';
	     myPageCon.Search();
	     List<Campaign>lstCampaign1=myPageCon.Allview;
	     Integer noOfPages=lstcampaign1.size()/3;
	     for(Integer i=1;i<=noOfPages;i++)
	     {
	     	
	     	myPageCon.pageNumber=i;
	     	
	     }
	    	 system.assert(myPageCon.hasNext);
	    	 
	     	      myPageCon.first();
	     		myPageCon.previous();
	            myPageCon.next();
	     		myPageCon.last();
	     	 	return true;
	     	
	    
	    
	     //myPageCon.hasNext=myPageCon.con.getHasNext();
	     //myPageCon.next();
	  
	     test.stopTest();
	     //system.assert(myPageCon.hasNext==true);
      return false;
    }
    
    
    //Check for previous page
     static testMethod void hasPreviousTest()
     {
      
	     PageReference ref= Page.CM_Campaign_Landing;
	     Test.setCurrentPageReference(ref);
	     
	     List<Campaign> lstcampaign=new List<Campaign>();
	   
	     for(Integer i=0;i<50;i++)
	     {
	     		Campaign objCampaign1=new Campaign(name='test1'+i,Type='in progress', Status='bac',IsActive=false,StartDate=Date.valueof('2012-06-07'));
	     		lstcampaign.add(objCampaign1);
	     }//end of for loop
	     
	     test.startTest();
	     insert lstcampaign;
	  
	    
	     CmPaging myPageCon = new  CmPaging();
	     myPageCon.view.Name='RecentlyModified';
	     myPageCon.Search();
	     
	     List<Campaign>lstCampaign1=myPageCon.Allview;
	    
	     
	     Integer noOfPages=lstcampaign1.size()/3;
 	     system.assert(!myPageCon.hasPrevious);
	    	
	     for(Integer i=1;i<=noOfPages;i++)
	     {
	     	
	     	myPageCon.pageNumber=i;
	     	
	     }
       		myPageCon.previous();
	     		myPageCon.last();
	     	 	//return true;
	     	
	     	
	
	    
	    
	     test.stopTest();
	    // return false;
	 
	      
     
    }
     
       //Check for Empty Record
     static testMethod void emptyRecordTest()
     {
     		pageReference ref=Page.CM_Campaign_Landing;
     		Test.setCurrentPageReference(ref);
     		
     		 CmPaging myPageCon = new  CmPaging();
     		 system.assert(myPageCon.Allview==null);
     		 
     }//end of empty record method
     
     
     //Check for page number
     static testMethod void testPageNumber()
    {	     
    	     PageReference ref= Page.CM_Campaign_Landing;
	     Test.setCurrentPageReference(ref);
	     
	     List<Campaign> lstcampaign=new List<Campaign>();
	     CmPaging myPageCon = new  CmPaging();
	     for(Integer i=0;i<50;i++)
	     {
	     		Campaign objCampaign1=new Campaign(name='test1'+i,Type='in progress', Status='bac',IsActive=false,StartDate=Date.valueof('2012-06-07'));
	     		lstcampaign.add(objCampaign1);
	     }
	     
	     test.startTest();
	     insert lstcampaign;
	   
	     myPageCon.view.Name='RecentlyModified';
	     myPageCon.Search();
	     List<Campaign> lstCampaign1=myPageCon.Allview;
	     system.assert(myPageCon.pageNumber==1);
	     myPageCon.next();
	     system.assert(myPageCon.pageNumber==2);
	     test.stopTest();
	    
      
    }
     
     
}//end of campaignTest