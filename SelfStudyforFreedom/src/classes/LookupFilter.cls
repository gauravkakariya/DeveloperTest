public with sharing class LookupFilter {
	
	public string mailSub{get;set;}
	public string mailBody{get;set;}
	public string selectedcon{get;set;}
	public string conEmail{get;set;}
	private id userId,contactId;
	public boolean isOtheracc;
	public boolean isConsumeracc;
	public User logedInUser{get;set;}
	public Contact objContactforPage{get;set;}
	public Contact objtempcon;
	public Account objAccountChk{get;set;}
	
	//Constructor of LookupFilter Class
	public LookupFilter()
	{
		objAccountChk=new Account();
		this.init();
		isOtheracc=false;
		isConsumeracc=false;
		
	}
	
	//Logic that should be executed at the time of Page Loading
	public void init()
	{
		userId = UserInfo.getUserId();
		
		logedInUser= [Select Email,
					   Id,
					   Name,
					   ContactId,
					   AccountId
					  From User
					  Where id =: userId];
	}
		
		
	 /* The Method will fetch Email of the contact selected from the Contact look up field from the 
	  * Compose Mail Page
	  */
	public void getEmail()
    {
  		
  		system.debug('%%%%%%%%%%%%%%%%%%'+objAccountChk.Contact_Email__c);
  		 
     	Contact objAccountChk=[select Email
		     			   		   From Contact 
		     					   where Id =:objAccountChk.Contact_Email__c];
     	conEmail=objAccountChk.Email;			  
  	}
	
	public void validateEmail()
	{
		system.debug('^^^^^^^^^^^^^^^^^'+conEmail);
		List<Contact> lstContemp=[select Id,
							Account.RecordType.Name
							from Contact
							where Email=:conEmail 
							limit 1];
		
		if(lstContemp.size()==0){
		  ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
					 'Email not exists in the contact'));
				
		  }
		else 
		{ 
			if((lstContemp.size()>0) && 
			   ((lstContemp[0].Account.RecordType.Name =='Business Account'))){
			    
			   	 isOtheracc=true;
			
				}
			else
			{
				 if((lstContemp.size()>0) && 
			   		(lstContemp[0].Account.RecordType.Name=='Consumer Account')){
				 	isConsumeracc=true;
				 	
				 	}
			}
		}	
	}
	
	
     /* The Method will save the information to the Message object and calls the method 
	  * to send message to the mentioned address
	  */
	public pageReference saveMessage()
	{
		validateEmail();
		//if(isConsumeracc){
			system.debug('~~~~~~Message to Send to Consumer account~~~~~~~~~~~~~');
		
		Contact objTemp=[select Id,Email from Contact where Email=:conEmail limit 1];
	 	Account objNewMsg=new Account();
		//objNewMsg.From_Contact__c=objtempcon.Id;
		//objNewMsg.From_Contact__c=logedInUser.ContactId;
		//objNewMsg.From__c=logedInUser.Email;
		//objNewMsg.Type__c='Unread';
		//objNewMsg.To__c=conEmail;
		//objNewMsg.To_Contact__c=objTemp.Id;
		//objNewMsg.Date__c=Date.today();
		objNewMsg.Name='Test Mail Message';
		//objNewMsg.Message__c=mailbody;
		//objNewMsg.Subject__c=mailSub;
		insert objNewMsg;
	    sendEmail(objTemp);
		/*
		else
		{
		if(isOtheracc==true)
		{
			system.debug('~~~~~~Message to Send to other account~~~~~~~~~~~~~');
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,
					 'Still not implemented this functionality'));
				
			/*
			Contact objTemp=[select Id from Contact where Email=:conEmail];
	 		Message__c objNewMsg=new Message__c();
			
			objNewMsg.From_Contact__c=logedInUser.ContactId;
			objNewMsg.From__c=logedInUser.Email;
			objNewMsg.Type__c='Unread';
			objNewMsg.To__c=conEmail;
			objNewMsg.To_Contact__c=objTemp.Id;
			objNewMsg.Date__c=Date.today();
			objNewMsg.Name='Test Mail Message for other account';
			objNewMsg.Message__c=mailbody;
			objNewMsg.Subject__c=mailSub;
			insert objNewMsg;
			
		}
		}*/
		
		pageReference ref = new PageReference('/apex/MailBox');
		ref.setRedirect(true);
		return ref;
       
		
	}
	
	
	
	/* The Method will cancel the compose mail operation and redirect user to MailBox page
	 * 
	 */
	public pageReference doCancel()
	{
		pageReference ref = new PageReference('/apex/MailBox');
		ref.setRedirect(true);
		return ref;
	
	}
	
	
	/* The Method will send the Email from Logged in User 
	 * 
	 */
   public void sendEmail(Contact objMsg)
   {
  		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        String[] toAddresses = new string[]{objMsg.Email};
     	email.setSubject('A new email has arrived in your inbox in BHive'); 
        //email.setSubject('');
        email.setToAddresses(toAddresses);
        email.setPlainTextBody(mailBody);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {email});
 }	 

}