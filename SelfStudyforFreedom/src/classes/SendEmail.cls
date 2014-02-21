public class SendEmail 
{
	String entityId = '';
	public SendEmail()
	{
		entityId = [select id from Account limit 1].id;
		system.debug('-------------------------entityId'+entityId);
	}
	
	/*
	public void SendEmailToPartner(Id entityId, Id userId)
	{
		
		system.debug('***********entityId-------------'+entityId);
		system.debug('***********userId---------------'+userId);
		User user = [select email, firstName, lastName from User where id = :userId];
		Contact tempContact = new Contact(email = user.email, firstName = user.firstName, lastName = user.lastName);
 		insert tempContact;
 		
	   //New instance of a single email message
	   Messaging.SingleEmailMessage mail =new Messaging.SingleEmailMessage();
	   String [] toAddreess = new String[]{'gaurav.kakariya@eternussolutions.com'};
	   system.debug('***********toAddreess'+toAddreess);
	   
	   // Who you are sending the email to
	   mail.setToAddresses(toAddreess);
	   
	   // The email template ID used for the email
	   mail.setSaveAsActivity(false);
	   mail.setWhatId(tempContact.Id);  
	   mail.setTemplateId('00X90000001ATuj');
	   mail.setTargetObjectId(userId);
	   
	  
	   mail.setSenderDisplayName('Kaushik Ray');
	   
	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });

    } 
*/

	public void sendMailTaskStatus()
	{
		//Construct the list of emails we want to send 5 List lstMsgs = new List(); 
    	List<Messaging.SingleEmailMessage> lstMsgs = new List<Messaging.SingleEmailMessage>(); 
    	
    	//Fetch toadddress and Cc address from custom setting of related status
    	//Ex: Enrollnent Form status --> mail id : Toaddress : XYZ@GMAL.COM
    	//TaskSendEmail__c objTaskSendEmail = []
    	
    	
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       	mail.toAddresses = new String[]{'gaurav.kakariya@eternussolutions.com'};
       	mail.setHtmlBody('Hello Task is not Completed within due Date' );
       	mail.setSubject('Test Task Status');
       	lstMsgs.add(mail);
		
		Messaging.sendEmail(lstMsgs);	
	}
	
	public void sendEmailToPartner()
	{
		Contact c = [select id, Email from Contact where email != null and Id = '0039000000DyQEN' limit 1]; 
    	
    	//Construct the list of emails we want to send 5 List lstMsgs = new List(); 
    	List<Messaging.SingleEmailMessage> lstMsgs = new List<Messaging.SingleEmailMessage>(); 	
    	
    	Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage(); 
    	msg.setTemplateId( [select id from EmailTemplate where DeveloperName='SendEmail'].id );
    	msg.setWhatId( [select id from Account limit 1].id ); 
		msg.setTargetObjectId(c.id); 
		system.debug('***********msg.setTemplateId'+msg );
		msg.setToAddresses(new List<String>{'gaurav.kakariya@eternussolutions.com'}); 
		msg.setCcAddresses(new List<String>{'kaushik.ray@eternussolutions.com'});
		lstMsgs.add(msg);
		
    	// Send the emails in a transaction, then roll it back 
    	Savepoint sp = Database.setSavepoint(); 
    	Messaging.sendEmail(lstMsgs); 
    	Database.rollback(sp);
    	
    	// For each SingleEmailMessage that was just populated by the sendEmail() method, copy its  
    	// contents to a new SingleEmailMessage. Then send those new messages. 
    	List<Messaging.SingleEmailMessage> lstMsgsToSend = new List<Messaging.SingleEmailMessage>();
    	List<Email_Detail__c> lstEmailDetails = new List<Email_Detail__c>();
    	List<Attachment> lstAttachment = new List<Attachment>();
    	
    	for(Messaging.SingleEmailMessage email : lstMsgs) 
    	{	
    		system.debug('***********email'+email );
    		Email_Detail__c objNewEmailDetail = new Email_Detail__c();
    		objNewEmailDetail.HtmlBody__c = email.getHtmlBody();
    		objNewEmailDetail.Subject__c = email.getSubject();
    	
    		String toEmailAddress = '';
    		String ccEmailAddress = '';
    		String bccEmailAddress = '';
    		
    		//If TOEmail Address not null
    		if(email.getToAddresses() != NULL)
    		{
	    		for(String strToEmailAddress : email.getToAddresses())
	    		{	
	    			//toEmailAddress += '\''+ strToEmailAddress +'\''+ ',';
	    			toEmailAddress = strToEmailAddress +',';
	    		}
	    		
	    		toEmailAddress = toEmailAddress.substring(0, toEmailAddress.length() - 1);
	    		objNewEmailDetail.ToAddresses__c = toEmailAddress + ',';
    		}
    		
    		//If CcEmail Address not null
    		if(email.getCcAddresses() != NULL)
    		{
	    		for(String strCcEmailAddress : email.getCcAddresses())
	    		{
	    			//ccEmailAddress = '\''+ strCcEmailAddress +'\''+ ',';
	    			ccEmailAddress = strCcEmailAddress + ',';
	    		}
	    		ccEmailAddress = ccEmailAddress.substring(0, ccEmailAddress.length() - 1);
	    		objNewEmailDetail.CcAddresses__c = ccEmailAddress;
    		}
    		
    		//If BccEmail Address not null
    		if(email.getBccAddresses() != NULL)
    		{
    			for(String strBCcEmailAddress : email.getBccAddresses())
	    		{
	    			bccEmailAddress = '\''+ strBCcEmailAddress +'\''+ ',';
	    		}
	    		bccEmailAddress = bccEmailAddress.substring(0, ccEmailAddress.length() - 1);
	    		objNewEmailDetail.BccAddresses__c= bccEmailAddress;
    			
    		}
    		
    		lstEmailDetails.add(objNewEmailDetail);
    	} 
    	
		//Messaging.sendEmail(lstMsgsToSend);
		if(!lstEmailDetails.isEmpty())
			insert lstEmailDetails;
			
		Document doc = [select id, name, body, contenttype, developername, type  from Document where id = '01590000000gk3B'];	
		Attachment attachment;
		Set<Id> setEmailDetailId = new Set<Id>();
		
		for(Email_Detail__c emailDetails: lstEmailDetails)
		{
			attachment = new Attachment();
			attachment.Body = doc.Body;
			attachment.Name = doc.Name;
			attachment.ParentId = emailDetails.Id;
			lstAttachment.add(attachment);	
			setEmailDetailId.add(emailDetails.Id);
		}
		
		//Insert Attachement 
		if(!lstAttachment.isEmpty())
			insert lstAttachment;
		
		List<Attachment> lstEmailAttach = [Select Id,Name,ContentType,Body from Attachment Where ParentId IN :setEmailDetailId];
		List<Messaging.EmailFileAttachment> lstEmailFileAttach = new List<Messaging.EmailFileAttachment>();
		
		for(Attachment objAttachment : lstEmailAttach)
		{
			Messaging.EmailFileAttachment objEmailFileAttach = new Messaging.EmailFileAttachment();
	       	objEmailFileAttach.setContentType(objAttachment.contentType);
	        objEmailFileAttach.setFileName(objAttachment.Name);
	        objEmailFileAttach.setInline(false);
	        objEmailFileAttach.Body = objAttachment.Body;
			
			lstEmailFileAttach.add(objEmailFileAttach);
			
		}
		
        //List<Messaging.SingleEmailMessage>  lstEmailMessage = new  List<Messaging.SingleEmailMessage>();
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
       	mail.toAddresses = new String[]{'gaurav.kakariya@eternussolutions.com'};
       	mail.setCcAddresses(new String[]{'kaushik.ray@eternussolutions.com'});
       	mail.setHtmlBody('Test');
       	mail.setSubject('Test Subkect');
        mail.setFileAttachments(lstEmailFileAttach);
        
        //Send Email with Attachement
        Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {mail});	
	}

}