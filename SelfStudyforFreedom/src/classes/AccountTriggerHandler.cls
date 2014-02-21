public with sharing class AccountTriggerHandler
 {
	public void onAfterUpdate(List<Account> lstAccount)
	{
		List<Task> lstTask= new List<Task>();
		Id recordTypeId= [select Id from RecordType where Name = 'General' and SobjectType = 'Task'].Id;
		for(Account objAccount : lstAccount)
		{
			if(objAccount.Task_Status__c == 'Enrollment Form')
			{
				//Create New Task
				Task objTask = new Task();
				objTask.Subject = 'Enrollment Form';
				objTask.Task_Status__c = 'Enrollment Form';
				objTask.RecordTypeId = recordTypeId;
				objTask.Task_Time__c = System.now();
				objTask.WhatId = objAccount.Id;
				lstTask.add(objTask);
			}
		}
		
		//Insert New Task
		if(!lstTask.isEmpty())
			insert 	lstTask;
			
		//new CreateTaskWithRecordType().createTask(lstAccount);
	} 
	
	
}