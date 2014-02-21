public with sharing class TaskTriggerHandler 
{
    public SendEmail objSendEmail;
    public Account objAccount;
    public String userId;
    public static Boolean assingnedMultipleUser = false;
    
    public void onBeforeUpdate(List<Task> lstOldTask, List<Task> lstTask)
    {
        //Initialsiation
        Set<Id> setAccountId = new Set<Id>();
        
        List<Task> lstNewTask= new List<Task>();
        
        Map<Id, Id> mapTaskIdToAccountId = new Map<Id, Id>();
        Map<Id, Task> mapTaskIdToTask = new Map<Id, Task>();
        
        for(Task objTask : lstOldTask)
        {
        	mapTaskIdToTask.put(objTask.Id, objTask);
        }
        
        //Collect All Account Id
        for(Task objTask : lstTask)
        {
            setAccountId.add(objTask.WhatId);
            mapTaskIdToAccountId.put(objTask.Id, objTask.WhatId);
        }
        
        //Collect All account record whose task to be update
        List<Account> lstAccount = [Select Id,IsWelcome_Call__c,(Select Id, RecordTypeId, Subject, Status, AccountId, Task_Status__c, Task_Time__c From Tasks) From Account Where Id IN : setAccountId];
        Id recordTypeId= [select Id from RecordType where Name = 'Freedom' and SobjectType = 'Task'].Id;
      	Map<Id,Account> mapTaskIdToAccount = new Map<Id,Account>();
      	
        for(Account objAccount : lstAccount)
        {
        	 for(Task objTask : objAccount.Tasks)
        	{
        		mapTaskIdToAccount.put(objTask.Id,objAccount);
        	}
        }
        
        for(Task objTask : lstTask)
        {
            //Check Task Status if it is "Enrollment Form"  and Status ="Completed"
            if(objTask.Task_Status__c == 'Enrollment Form' && objTask.ActivityDate != Null)
            {
            	
            	if( objTask.Status != 'Completed' && objTask.ActivityDate < Date.today())
            	{
            		//send Mail that Task is not completed within due date
            		
            	}
            	
            	if(objTask.Status == 'Completed')
                {	
                	//Create New Task
	                Task objNewTask = new Task();
	                objNewTask.Subject = 'Welcome Call';
	                objNewTask.Task_Status__c = 'Welcome Call';
	                objNewTask.WhatId = mapTaskIdToAccountId.get(objTask.Id);
	                lstNewTask.add(objNewTask);
                }
            }
             
            //Check Task Status if it is "Welcome Call" and Status ="Completed"
            if(objTask.Task_Status__c == 'Welcome Call' && objTask.Status == 'Completed')
            {
                if(objTask.Task_Time__c == Null)
                    objTask.Task_Time__c.addError('Please Enter Date Time');
                // if(mapTaskIdToAccount.get(objTask.Id).IsWelcome_Call__c == true)
                 //	objTask.addError('Welcome Call Already Completed');   
                 	
                //Create New Task
                Task objNewTask = new Task();
                objNewTask.Subject = 'Welcome Sms';
                objNewTask.Task_Status__c = 'Welcome Sms';
                objNewTask.Task_Time__c = System.now();
                objNewTask.RecordTypeId = recordTypeId;
                objNewTask.WhatId = mapTaskIdToAccountId.get(objTask.Id);
                lstNewTask.add(objNewTask);
            }
            
        }
        
        //Insert New Task
        if(!lstNewTask.isEmpty())
            insert lstNewTask;
    }
    
    public void onAfterUpdate(List<Task> lstTask)
    {
        //Initialsiation
        List<Account> lstAccount= new List<Account>();
        List<Account> lstUpdateAccount= new List<Account>();
        Map<Id, Account> mapAccountIdToAccount = new Map<Id, Account>();
        Set<Id> setAccountId = new Set<Id>();
        
        objSendEmail = new SendEmail();
        objAccount = new Account();
        
        //Collect All Account Id
        for(Task objTask : lstTask)
            setAccountId.add(objTask.WhatId);
        
        //Collect Account from Task 
        lstAccount = [Select Id,Task_Status__c,IsWelcome_Call__c From Account Where Id IN : setAccountId];
        
        for(Account objAccount: lstAccount)
            mapAccountIdToAccount.put(objAccount.Id, objAccount);
        
        for(Task objTask : lstTask)
        {
            objAccount = mapAccountIdToAccount.get(objTask.WhatId);
            
            //Check Task Status if it it "Welcome Call and Status ="Completed"
            if(objAccount != Null && objTask.Task_Status__c == 'Welcome Call' && objTask.Status == 'Completed')
            {
                if(objTask.WhatId == objAccount.Id &&  !objAccount.IsWelcome_Call__c)
                    objTask.addError('Please Check the Welcome Call Checkbox to "True" on Account');
                else
                {
                    objAccount.Task_Status__c = 'Welcome Call';
                    objAccount.IsWelcome_Call__c = false;
                    userId = objTask.OwnerId;
                    lstUpdateAccount.add(objAccount);
                }
            }
            
            
        }//Task for
       /* 
        List<Messaging.SingleEmailMessage> email = new List<Messaging.SingleEmailMessage>();
        
        Document doc = [select id, name, body, contenttype, developername, type  from Document where id = '01590000000gk3B'];
                            
        Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
        attach.setContentType(doc.contentType);
        attach.setFileName(doc.developerName+'.'+ doc.type);
        attach.setInline(false);
        attach.Body = doc.Body;
        
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       	User u = [Select Id, Email FROM User WHERE Id ='00590000000s5UR'];
       	// mail.toAddresses = new String[]{u.Email};
        // mail.setTargetObjectId([SELECT Id,Email FROM Contact WHERE Id='0039000000E2eOk'].Id);
        mail.setTargetObjectId(UserInfo.getUserId());
        mail.setTemplateID('00X90000001ATwp');
        mail.setSaveAsActivity(false);
        mail.setWhatId('0019000000Dkvo3');
        mail.setSenderDisplayName ('Freedom Team');
        mail.setFileAttachments(new Messaging.EmailFileAttachment[] { attach });
        // email.add(mail);
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mail});
       */
        new SendEmail().sendEmailToPartner();
        
    } 
    
    
    public void onbeforeInsert(List<Task> lstTask)
    {
        //Initialsiation
        if (assingnedMultipleUser)
        	return;
        set<Id> setAccountId = new set<Id>();
        List<Task> lstNewTask1= new List<Task>();
        Set<Task> lstNewTask= new Set<Task>();
        Map<Task, Id> mapTaskIdToAccountId = new Map<Task, Id>();
        Map<Task, Id> mapTaskIdToOwnerId = new Map<Task, Id>();
        Map<Id, User> mapIdToUser = new Map<Id, User>();
        
        //Collect All Account Id
        for(Task objTask : lstTask)
        {
            mapTaskIdToAccountId.put(objTask, objTask.WhatId);
            mapTaskIdToOwnerId.put(objTask, objTask.OwnerId);
        }
        
        List<User> lstUser = new List<User>();
        //Map<Id, User> mapIdToUser  = new MapMap<Id, User>([Select Id, Name From User Where IsActive = true]);
        lstUser = [Select Id, Name From User Where IsActive = true];
        
        
        for(Task objTask : lstTask) 
        {
            for(User objUser : lstUser)
            {
            	if (objTask.OwnerId != objUser.Id) {
	            	Task objNewTask = new Task();
		            objNewTask.Subject = 'Test Muliple User';
		            objNewTask.Task_Status__c = 'Welcome Sms';
		            objNewTask.Task_Time__c = System.now();
		            objNewTask.WhatId = mapTaskIdToAccountId.get(objTask);
		            objNewTask.OwnerId = objUser.Id;
		            lstNewTask1.add(objNewTask);
	            } 
            	  
            }
        }
        
        //Insert New Task
        // lstNewTask1.addAll(lstNewTask);
        assingnedMultipleUser = true;
        insert lstNewTask1;
        assingnedMultipleUser = false;
    }
}