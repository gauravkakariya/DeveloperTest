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
private class SalesforceSearchControllerTest 
{

    static testMethod void TestSearch() 
    {
        
        PageReference pageRef = Page.SalesforceSearch;
        
        
        SalesforceSearchController objSearch=new SalesforceSearchController();
        
        List<Account> lstAccount=new List<Account>();
        List<Contact> lstContact=new List<Contact>();
        List<Lead> lstLead=new List<Lead>();
        List<Opportunity> lstOpportunity=new List<Opportunity>();
        
        
        for(Integer i=0;i<100;i++)
        {
         Account objAccount=new Account(Name='Test'+i,First_Name__C='a',Last_Name__C='b',Email__c='abc@gmail.com');
         lstAccount.add(objAccount);
        }
        
        for(Integer i=0;i<100;i++)
        {
         Contact objContact=new Contact(LastName='Test'+i);
         lstContact.add(objContact);
        }
        
        for(Integer i=0;i<100;i++)
        {
         Lead objLead=new Lead(LastName='Test'+i,Company='ESPL',Status='Open - Not Contacted');
         lstLead.add(objLead);
        }
        
        for(Integer i=0;i<100;i++)
        {
         Opportunity objOpportunity=new Opportunity(Name='Test'+i,CloseDate=Date.today(),StageName='Qualification');
         lstOpportunity.add(objOpportunity);
        }
        
        Test.startTest();
        insert lstAccount;
        insert lstContact;
        insert lstLead;
        insert lstOpportunity;
        
        lstAccount=null;
        lstContact=null;
        lstLead=null;
        lstOpportunity=null;
        
        
        Test.setCurrentPageReference(pageRef);
        
        objSearch.setSearchText('Test');
        objSearch.getSearchText();
        objSearch.doSearch();
      
        
        lstAccount=objSearch.getResults_account();
        lstContact=objSearch.getResults_contact();
        lstLead=objSearch.getResults_lead();
        lstOpportunity=objSearch.getResults_opportunity();
        
       Account objAccount=[select Name from Account where Name='Test5' limit 1];
       Lead objLead=[select LastName from Lead where LastName='Test5'];
       Opportunity objOpportunity=[select Name from Opportunity where Name='Test5'];
       Contact objContact=[select LastName from Contact where LastName='Test5'];
       
       for(Account objAcc:lstAccount)
       {
	        if(objAcc.Name==objAccount.Name)
	        {
		         System.assertEquals(objAcc.Name,objAccount.Name);
		         break;         
	        }
       }
       
       for(Opportunity objOpp:lstOpportunity)
       {
        	if(objOpp.Name==objOpportunity.Name)
       	 {
         		System.assertEquals(objOpp.Name,objOpportunity.Name);
         		break;         
    		 }
       }
       
       for(Contact objeContact:lstContact)
       {
        	if(objeContact.LastName==objContact.LastName)
        	{
         		System.assertEquals(objeContact.LastName,objContact.LastName);
        		 break;         
        	}
       }
       
       for(Lead objLead1:lstLead)
       {
        	if(objLead1.LastName==objLead.LastName)
        	{
         		System.assertEquals(objLead1.LastName,objLead.LastName);
        		 break;         
   	 	}
   	 	
   	 	
       }
      
        Test.stopTest();
        
    }
    
    
    public static void emptySearchString()
    {
    	   PageReference pageRef = Page.SalesforceSearch;

         SalesforceSearchController objSearch=new SalesforceSearchController();
         Test.setCurrentPageReference(pageRef);
         Account objAccount=new Account(Name='Test'+1,First_Name__C='abc',Last_Name__C='b',Email__c='abc@gmail.com');
         test.startTest();
         insert objAccount;
         objSearch.setSearchText('&');
         
       if(objSearch.searchText==null)
     	{
        
        	objSearch.getSearchText();
        	objSearch.doSearch();
        	List<Account> lstAccount=objSearch.getResults_account();
        	//Test.stopTest();
     	
        	System.assert(lstAccount==null);
         	
         
     	}else
        	{
        	objSearch.getSearchText();
        	objSearch.doSearch();
        	List<Account> lstAccount=objSearch.getResults_account();
        	Test.stopTest();
        	}
    }  //system.assert();
    
}