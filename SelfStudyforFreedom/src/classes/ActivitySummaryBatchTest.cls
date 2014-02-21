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
private class ActivitySummaryBatchTest {

    static testMethod void myUnitTest() 
    {
        // TO DO: implement unit test
       
       Contact objContact=new Contact();
       objContact.LastName='espl';
       insert objContact;
       
       List<Campaign> lstCampaign=new List<Campaign>();
       
        for(Integer i=0;i<200;i++)
       {
          Campaign objCamp=new Campaign(Name='Test'+i);
          lstCampaign.add(objCamp);
       }
       
       insert lstCampaign;
       
       /*
       CampaignMember objCampaignMember=new CampaignMember();
       objCampaignMember.Lastupdated_Date__c=Date.valueOf('1/1/2012');
       insert objCampaignMember;
       
       
       */
       
      
       
       Contact objContact1= [select Id from Contact where LastName='espl'];
       
       List<CampaignMember> lstCamapignMember= new List<CampaignMember>();
       for(Campaign objCmp:[select Id,Name from Campaign where Id IN: lstCampaign]) 
       {
             CampaignMember objCampMember=new CampaignMember(CampaignId=objCmp.Id,ContactId=objContact1.Id);
             lstCamapignMember.add(objCampMember);
       
       }
       
       insert lstCamapignMember;
       
       test.startTest();
       ActivitySummaryBatch actBatch=new ActivitySummaryBatch();
       database.executebatch(actBatch);
       test.stopTest();
       
       List<Contact> lstCounter=[select Lifetime_Action_Count__c from Contact where LastName='espl'];
       
      System.AssertEquals(lstCounter.get(0).Lifetime_Action_Count__c,200);
       
      // System.AssertEquals(lstCounter.get(0).Lifetime_Action_Count__c,200);
       
       
     
       
    }
}