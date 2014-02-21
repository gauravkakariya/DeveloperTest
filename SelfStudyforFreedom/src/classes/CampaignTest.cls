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
private class CampaignTest {
	
	/*
        	 --- Test Code for Campaign Management--
        	 
        	 1) Check Condition for Recently Modified
        	 2) Check Condition for All Campaign
        	 3) Check Condition for All active Campaign
        	 4) Check Condition for Inactive Campaign        		
        	 5) Check Condition for Recently Modified
        
        */
        

    static testMethod void recentlyModifiedCampaign() 
    {
        // TO DO: implement unit test
        
        PageReference pageref=Page.CM_Campaign_Landing;
        Test.setCurrentPageReference(pageref);
      
        
        
       List<Campaign> lstCampaign=new List<Campaign>();
        
       Campaign objCamp=new Campaign();
       objCamp.Type='webinar';
       objCamp.StartDate=Date.valueOf('2012-08-06');
    //   objCamp.LastModifiedDate;
       objCamp.Status='Completed'; 
       objCamp.Name='NameTest1';
       lstCampaign.add(objCamp);
       
       Campaign objCampaign2=new Campaign(Name='NameTest2',Type='webinar',Status='Completed',StartDate=Date.valueOf('2012-07-06'));
       Campaign objCampaign3=new Campaign(Name='NameTest3',Type='webinar',Status='Completed',StartDate=Date.valueOf('2012-06-06'));
       
     
       lstCampaign.add(objCampaign2);
       lstCampaign.add(objCampaign3);
       
      test.startTest();
      
      insert lstCampaign;
      CampaignManagement cm=new CampaignManagement();
      cm.getView();
      
        Campaign objcampnew=[select Status,Type,Name,StartDate,LastModifiedDate from Campaign where Name='NameTest1'];
      
     	cm.setView('Recently Modified');
    	List<Campaign> lstCamp=cm.campaigns;
        system.assert(lstCamp.get(0).StartDate==objcampnew.StartDate);
        //system.assert(lstCamp.get(0).LastModifiedDate==objcampnew.LastModifiedDate);
        
        
        /*
     	cm.setView('All Campaigns');
     	List<Campaign> lstCamp1=cm.campaigns;
  	
  		cm.setView('All Active Campaigns');
  		List<Campaign> lstCamp2=cm.campaigns;
  		
  		
  		cm.setView('My Active Campaigns');
  		List<Campaign> lstCamp3=cm.campaigns;
  		
  	
  		cm.setView('Inactive Campaigns');
  		List<Campaign> lstCamp4=cm.campaigns;
  		*/
        test.stopTest();
        
        
        
        
        
    }
    
    
    ////CHECK FOR All Campaign
    static testMethod void AllCampaign() 
    {
    	  
       List<Campaign> lstCampaign=new List<Campaign>();
        
       Campaign objCamp=new Campaign();
       objCamp.Type='webinar';
       objCamp.StartDate=Date.valueOf('2012-08-06');
       objCamp.Status='Completed'; 
       objCamp.Name='NameTest1';
       lstCampaign.add(objCamp);
       
       Campaign objCampaign2=new Campaign(Name='NameTest2',Type='webinar',Status='Completed',StartDate=Date.valueOf('2012-07-06'));
       Campaign objCampaign3=new Campaign(Name='NameTest3',Type='webinar',Status='Completed',StartDate=Date.valueOf('2012-06-06'));
       
     
       lstCampaign.add(objCampaign2);
       lstCampaign.add(objCampaign3);
       
      test.startTest();
      
      insert lstCampaign;
      CampaignManagement cm=new CampaignManagement();
      cm.getView();	
      
      Campaign objcampnew=[select Status,Type,Name,StartDate from Campaign where Name='NameTest1'];
      
      cm.setView('All Campaigns');
      List<Campaign> lstCamp1=cm.campaigns;
      system.assert(lstCamp1.get(0).StartDate==objcampnew.StartDate);
  	
      
      
    	
    }//end of allCampaign method
   
   
   
   //CHECK FOR All active Campaign where IsActive=true and StartDate=desc
   	 static testMethod void allActiveCampaign() 
    {
    	  
       List<Campaign> lstCampaign=new List<Campaign>();
        
       Campaign objCamp=new Campaign();
       objCamp.Type='webinar';
       objCamp.StartDate=Date.valueOf('2012-08-06');
       objCamp.Status='Completed'; 
       objCamp.IsActive=True;
       objCamp.Name='NameTest1';
       lstCampaign.add(objCamp);
       
       Campaign objCampaign2=new Campaign(Name='NameTest2',Type='webinar',IsActive=True,Status='Completed',StartDate=Date.valueOf('2012-07-06'));
       Campaign objCampaign3=new Campaign(Name='NameTest3',Type='webinar',IsActive=True,Status='Completed',StartDate=Date.valueOf('2012-06-06'));
       
     
       lstCampaign.add(objCampaign2);
       lstCampaign.add(objCampaign3);
       
      test.startTest();
      
      insert lstCampaign;
      CampaignManagement cm=new CampaignManagement();
      cm.getView();	
      
      
      Campaign objcampnew=[select Status,Type,Name,StartDate,IsActive from Campaign where Name='NameTest1' and IsActive=True];
      
      cm.setView('All Active Campaigns');
      List<Campaign> lstCamp1=cm.campaigns;
     system.assert(lstCamp1.get(0).IsActive==objcampnew.IsActive);
  	
  	
      
      
    	
    }//end of all active campaign
   
    
    
    
    //CHECK FOR my active Campaign where IsActive=true and StartDate=desc
   	 static testMethod void myActiveCampaign() 
    {
    	  
       List<Campaign> lstCampaign=new List<Campaign>();
        
       Campaign objCamp=new Campaign();
       objCamp.Type='webinar';
       objCamp.StartDate=Date.valueOf('2012-08-06');
       objCamp.Status='Completed'; 
       objCamp.IsActive=True;
       objCamp.OwnerId=UserInfo.getUserId();
       objCamp.Name='NameTest1';
       lstCampaign.add(objCamp);
       
       Campaign objCampaign2=new Campaign(Name='NameTest2',Type='webinar',IsActive=True,Status='Completed',OwnerId=UserInfo.getUserId(),StartDate=Date.valueOf('2012-07-06'));
       Campaign objCampaign3=new Campaign(Name='NameTest3',Type='webinar',IsActive=True,Status='Completed',OwnerId=UserInfo.getUserId(),StartDate=Date.valueOf('2012-06-06'));
       
     
       lstCampaign.add(objCampaign2);
       lstCampaign.add(objCampaign3);
       
      test.startTest();
      
      insert lstCampaign;
      CampaignManagement cm=new CampaignManagement();
      cm.getView();	
      
      
      Campaign objcampnew=[select Status,Type,Name,StartDate,IsActive,OwnerId from Campaign where Name='NameTest1' and IsActive=True and OwnerId=:UserInfo.getUserId()];
      
      
      cm.setView('My Active Campaigns');
      List<Campaign> lstCamp1=cm.campaigns;
      system.assert((lstCamp1.get(0).IsActive==objcampnew.IsActive) && (lstCamp1.get(0).OwnerId==objcampnew.OwnerId));
      
      
  		
  	
      
      
    	
    }//end of my active campaign
    
    
    
    
     //CHECK FOR Inactive Campaign where IsActive=false
   	 static testMethod void inActiveCampaign() 
    {
    	  
       List<Campaign> lstCampaign=new List<Campaign>();
        
       Campaign objCamp=new Campaign();
       objCamp.Type='webinar';
       objCamp.StartDate=Date.valueOf('2012-08-06');
       objCamp.Status='Completed'; 
       objCamp.IsActive=False;
       objCamp.Name='NameTest1';
       lstCampaign.add(objCamp);
       
       Campaign objCampaign2=new Campaign(Name='NameTest2',Type='webinar',IsActive=True,Status='Completed',StartDate=Date.valueOf('2012-07-06'));
       Campaign objCampaign3=new Campaign(Name='NameTest3',Type='webinar',IsActive=True,Status='Completed',StartDate=Date.valueOf('2012-06-06'));
       
     
       lstCampaign.add(objCampaign2);
       lstCampaign.add(objCampaign3);
       
      test.startTest();
      
      insert lstCampaign;
      CampaignManagement cm=new CampaignManagement();
      cm.getView();	
      
      
      Campaign objcampnew=[select Status,Type,Name,StartDate,IsActive from Campaign where Name='NameTest1' and IsActive=False];
      
      cm.setView('Inactive Campaigns');
      List<Campaign> lstCamp1=cm.campaigns;
      system.assert(lstCamp1.get(0).IsActive==objcampnew.IsActive);
  	
  	
      
      
    	
    }//end of inactive campaign
   
    
    
    
    
    
}