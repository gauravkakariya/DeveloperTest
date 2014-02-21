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
private class DuplicateCheckerTest
 {
 	
 	/* 	
 			1) Write Test Code for Before Insert on Acccount Object
 				1.1)Chech Condition for if Full name and Email are Equal
 				1.2)Chech Condition for if Full name and Phone are Equal
 				1.3)Chech Condition for if Email and Phone are Equal
 				1.4)Chech Condition for if Email and Phone and FullName are Equal
 				
 			 
 		
 	*/
	
    static testMethod void testBeforeInsert()
     {
        // TO DO: implement unit test
        
        List<Account> lstAccount=new List<Account>();
        
       
          
         Account objAccount4=new Account(Name='Test', Phone='123456',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         
        /* Account objAccount=new Account(Name='aditya', Phone='123456',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         Account objAccount3=new Account(Name='1', Phone='123456',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge'); 
        
         insert objAccount4;
         insert objAccount;
         insert objAccount3;
         //lstAccount.add(objAccount4);
         //lstAccount.add(objAccount);
          */
          
        test.startTest();  
        insert objAccount4;
     
     	
        for(Integer i=1;i<=200;i++)
        {
        	
        	Account objAccount2=new Account(Name='Test'+i, Phone='123456',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');
        	lstAccount.add(objAccount2);
        	system.debug('Duplicate'+lstAccount);
        }
       
        
        
        insert lstAccount;
        Account objAcc=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test'];
        Account objAcc1=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test1'];
        system.assert(objAcc1.ParentId==objAcc.Id);
        test.stopTest();
    
        
     }
        
        
 
 	//Check for Unique Record
       static testMethod void testUniqueRecord()
  	  {
   		List<Account> lstAccount=new List<Account>();
        
       
          
         Account objAccount4=new Account(Name='Test', Phone='123456',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         
   		test.startTest();  
        insert objAccount4;
     
     	
        for(Integer i=1;i<=200;i++)
        {
        	
        	Account objAccount2=new Account(Name='Test'+i, Phone='123456'+i,Email__c='ajayghuge@gmail.com'+i,First_Name__c='Ajay'+i,Last_Name__c='Ghuge'+i);
        	lstAccount.add(objAccount2);
        	system.debug('$$$$$$$$'+lstAccount);
        }
       
        
        
        insert lstAccount;
        Account objAcc=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test4'];
        Account objAcc1=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test5'];
        system.assert(objAcc1.ParentId==null);
        test.stopTest();
   	
   	
      }//end of testUniqueRecord
      
      
        
       
       //Chech Condition for if Full name and Email are Equal
        
        static testMethod void testFullnameandEmailRecord()
  	  {
   		List<Account> lstAccount=new List<Account>();
        
       
          
         Account objAccount4=new Account(Name='Test', Phone='1234',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         
   		test.startTest();  
        insert objAccount4;
     
     	
        for(Integer i=1;i<=200;i++)
        {
        	
        	Account objAccount2=new Account(Name='Test'+i, Phone='123456'+i,Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');
        	lstAccount.add(objAccount2);
        	system.debug('Email and Fullname'+lstAccount);
        }
       
        
        
        insert lstAccount;
        Account objAcc=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test'];
        Account objAcc1=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test1'];
        system.assert(objAcc1.ParentId==objAcc.Id);
        test.stopTest();
   	
   	
      }//testFullnameandEmailRecord
         
        
        
       //Chech Condition for if Full name and Phone are Equal
        
        static testMethod void testFullnameandPhoneRecord()
  	  {
   		List<Account> lstAccount=new List<Account>();
        
       
          
         Account objAccount4=new Account(Name='Test', Phone='1234',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         
   		test.startTest();  
        insert objAccount4;
     
     	
        for(Integer i=1;i<=200;i++)
        {
        	
        	Account objAccount2=new Account(Name='Test'+i, Phone='1234',Email__c='ajayghuge@gmail.com'+i,First_Name__c='Ajay',Last_Name__c='Ghuge');
        	lstAccount.add(objAccount2);
        	system.debug('Email and Fullname'+lstAccount);
        }
       
        
        
        insert lstAccount;
        Account objAcc=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test'];
        Account objAcc1=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test1'];
        system.assert(objAcc1.ParentId==objAcc.Id);
        test.stopTest();
   	
   	
      }//testFullnameandPhoneRecord  
       
        
        
      //Chech Condition for if Email and Phone are Equal
        
        static testMethod void testEmailandPhoneRecord()
  	  {
   		List<Account> lstAccount=new List<Account>();
        
       
          
         Account objAccount4=new Account(Name='Test', Phone='1234',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay',Last_Name__c='Ghuge');  
         
   		test.startTest();  
        insert objAccount4;
     
     	
        for(Integer i=1;i<=200;i++)
        {
        	
        	Account objAccount2=new Account(Name='Test'+i, Phone='1234',Email__c='ajayghuge@gmail.com',First_Name__c='Ajay'+i,Last_Name__c='Ghuge'+i);
        	lstAccount.add(objAccount2);
        	system.debug('Email and Fullname'+lstAccount);
        }
       
        
        
        insert lstAccount;
        Account objAcc=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test'];
        Account objAcc1=[SELECT A.ID,A.ParentId FROM ACCOUNT A WHERE Name='Test1'];
        system.assert(objAcc1.ParentId==objAcc.Id);
        test.stopTest();
   	
   	
      }//testFullnameandPhoneRecord     
        
    
}