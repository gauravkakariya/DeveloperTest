public with sharing class EmailDetailsHandler 
{
	
	public void SendEmailToPartner(List<Email_Detail__c> lstEmailDetails)
	{
		/*
		List<Messaging.SingleEmailMessage> lstEmailMessage = new List<Messaging.SingleEmailMessage> ();
		List<String> lstToAddress = new List<String>();
		List<String> lstCCAddress = new List<String>();
		string test = '';
		string testCc = '';
		for(Email_Detail__c objEmailDetails : lstEmailDetails)
		{
			system.debug('**********objEmailDetails****'+objEmailDetails);
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			
			mail.setHtmlBody(objEmailDetails.HtmlBody__c);
			mail.setSenderDisplayName('Test');
			test= objEmailDetails.ToAddresses__c;
			system.debug('**********test****'+test);
			lstToAddress = test.split(',');
			system.debug('**********lstToAddress****'+lstToAddress);
			mail.setToAddresses(lstToAddress);
			//mail.setBccAddresses(pList);
			//mail.setCcAddresses(pList);
			mail.setPlainTextBody(objEmailDetails.HtmlBody__c);
			mail.setSubject(objEmailDetails.Subject__c);
			testCc= objEmailDetails.CcAddresses__c;
			lstCCAddress = testCc.split(',');
			system.debug('**********test****'+test);
			mail.setCcAddresses(lstCCAddress);
			//mail.setTargetObjectId(objEmailDetails.to);
			lstEmailMessage.add(mail);
			
		}
		//Send Email with Attachement
        Messaging.sendEmail(lstEmailMessage);	*/
		
	}
	
	
	
}