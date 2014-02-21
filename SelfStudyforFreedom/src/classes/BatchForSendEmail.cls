global with sharing class BatchForSendEmail implements Database.Batchable<sObject>
{
	private String query;
		/**
	* Constructor: Assign query parameter. 
	* @param : String query.
	*/
	public BatchForSendEmail(String query)
    { 
    	this.query = query;
    }
    
    /*
		@MethodName: start 
		@param : Database.BatchableContext BC
		@Description: It is overriden method of  Database.Batchable interface.
	*/
    global Database.QueryLocator start(Database.BatchableContext BC) 
    { 
    	return Database.getQueryLocator(query);    																				
    }
    
    /*
		@MethodName: execute 
		@param : Database.BatchableContext BC, List<sObject> scope
		@Description: It is overriden method of  Database.Batchable interface.
	*/
    global void execute(Database.BatchableContext BC, List<sObject> scope) 
    { 
    	List<Messaging.SingleEmailMessage> lstMail = new List<Messaging.SingleEmailMessage>();
    	List<Email_Detail__c> lstEmailDetail = new List<Email_Detail__c>();
    	for(sObject obj : scope)
    	{
	    	Email_Detail__c objEmailDetail = (Email_Detail__c) obj;
			Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			String[] toAddresses = new String[] {objEmailDetail.ToAddresses__c};
			mail.setToAddresses(toAddresses);
			mail.setCcAddresses(new List<String> {objEmailDetail.CcAddresses__c});
			mail.setBccAddresses(new List<String> {objEmailDetail.BccAddresses__c});
			mail.setSubject(objEmailDetail.Subject__c);
			mail.setUseSignature(false);
			mail.setInReplyTo(objEmailDetail.ReplyTo__c);
			mail.setHtmlBody(objEmailDetail.HtmlBody__c);
			lstMail.add(mail);
			Messaging.sendEmail(lstMail);
    	}
    	
    }
    /*
		@MethodName: finish 
		@param : Database.BatchableContext BC
		@Description: It is overriden method of  Database.Batchable interface.
	*/
    global void finish(Database.BatchableContext BC)
    {
    	
    }
}