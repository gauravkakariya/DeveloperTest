public with sharing class BatchSchedularForSendEmail 
{
	public BatchSchedularForSendEmail()
	{
		String batchQuery = 'Select ToAddresses__c, CcAddresses__c, BccAddresses__c, Subject__c, ReplyTo__c, IsEmail__c,  Id, HtmlBody__c, DocumentAttachments__c'+
							' From Email_Detail__c where IsEmail__c = false';

		BatchForSendEmail objBatch = new BatchForSendEmail(batchQuery);
		Database.executeBatch(objBatch,150);
	}
}