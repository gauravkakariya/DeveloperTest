public with sharing class DuplicateChecker
{

		//Constructor
		public DuplicateChecker()
		{
			
			
		}
		
		//Method To check value After Insert
		public void onBeforeInsert(List<Account> lstAccount)
		{
			set<string> setFullname=new set<string>();
			set<string> setPhone=new set<string>();
			set<string> setEmail=new set<string>();
			
			
			for(Account temp:lstAccount)
			{
				setFullname.add(temp.Full_Name__c);
				setPhone.add(temp.Phone);
				setEmail.add(temp.Email__c);
			}
			
			Map<String, Id> fnAndEmail=new Map<String, Id>();
			Map<String, Id> fnAndphone=new Map<String, Id>();
			Map<String, Id> emailAndphone=new Map<String, Id>();
			
			
			for(Account actObj:[select a.Phone, a.Id, a.Full_Name__c, a.Email__c From Account a where ParentId=null and ((a.Phone IN:setPhone and a.Full_Name__c IN :setFullname) or (a.Email__c IN:setEmail and a.Full_Name__c IN :setFullname) or (a.Email__c IN:setEmail and a.Phone IN :setPhone) )])
			{
				if(actObj.Full_Name__c!=null && actObj.Email__c!=null)
				{
					fnAndEmail.put(actObj.Full_Name__c+actObj.Email__c, actObj.Id);
				}
				if(actObj.Full_Name__c!=null && actObj.Phone!=null) 
				{
				fnAndphone.put(actObj.Full_Name__c+actObj.Phone,actObj.Id);
				
				}
				if(actObj.Email__c!=null && actObj.Phone!=null) 
				{
				emailAndphone.put(actObj.phone,actObj.Id);
				
				}
				
			}
			
			
			
			for(Account objAccount: lstAccount)
			{
				if(fnAndEmail.containsKey(objAccount.Full_Name__c+objAccount.Email__c))
				{
					objAccount.ParentId=fnAndEmail.get(objAccount.Full_Name__c+objAccount.Email__c);
					
				}
				
				else if( fnAndphone.containsKey(objAccount.Full_Name__c+objAccount.Phone))
				{
					objAccount.ParentId= fnAndphone.get(objAccount.Full_Name__c+objAccount.Email__c);
					
				}
				
				if(emailAndphone.containsKey(objAccount.Full_Name__c+objAccount.Phone))
				{
					objAccount.ParentId=emailAndphone.get(objAccount.Phone+objAccount.Email__c);
					
				}
			}
			
			
			
			/*
			//Map<Id, Account> temp=[select * from Account where fullname In:testname and ]
		
			for(Account objAccountDetails: [Select a.Phone, a.Id, a.Full_Name__c, a.Email__c From Account a ])// where (a.First_Name__c=: objAccount.First_Name__c and a.Last_Name__c=: objAccount.Last_Name__c) ])
			{	
			
			
				for(Account objAccount:lstAccount)
					{
				
			
			
				
					
					//check Condition when Email and Phone are Same
					if(objAccountDetails.Email__c== objAccount.Email__c||objAccountDetails.Phone== objAccount.Phone )
					{
						system.debug('Hello'+lstAccount);
						objAccount.ParentId=objAccountDetails.Id;
					
						
						
					}
					
					
			}							
				
			
			}*/
			
		}//end of beforeInsert


		
}//end of DuplicateChecker Class